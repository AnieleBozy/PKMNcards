
-- Burn
SMODS.Enhancement {
    key = 'burn',
    atlas = 'enh',
    pos = { x = 1, y = 0 },
    config = { h_x_chips = 0.5 },
    weight = 0,
    overrides_base_rank = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.h_x_chips } }
    end,
    in_pool = function(self, args)
        return false
    end
}
-- Sleep
SMODS.Enhancement {
    key = 'sleep',
    atlas = 'enh',
    pos = { x = 0, y = 1 }, soul_pos = { x = 2, y = 0 },
    weight = 0,
    overrides_base_rank = true,
    no_suit = true,
    
    calculate = function(self,card,context)
        if context.pre_discard then
            for k,v in pairs(context.full_hand) do
                if v == card then
                    local _card = v
                    G.E_MANAGER:add_event(Event({
                        triger = before,
                        delay = 0.1,
                        func = function()
                            SMODS.destroy_cards({v})
                            return true
                        end
                    }))

                    local card_copied = copy_card(_card, nil, nil, G.playing_card)
                    card_copied:add_to_deck()
                    --G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, card_copied)
                    G.hand:emplace(card_copied)
                    card_copied.states.visible = nil

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card_copied:start_materialize()
                            return true
                        end
                    }))
                    return {
                        message = 'Yawn...',
                        colour = G.C.UI.TEXT_LIGHT,
                        --SMODS.calculate_context({ playing_card_added = true, cards = { card_copied } }),
                        }
                    end
                end
            end
        end,
    in_pool = function(self, args)
        return false
    end
}
-- Paralysis
SMODS.Enhancement {
    key = 'para',
    atlas = 'enh',
    pos = { x = 0, y = 1 }, soul_pos = { x = 0, y = 0 },
    config = { extra = { drawn = true, odds = 2 } },
    weight = 0,
    overrides_base_rank = true,

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'pokes_para')
        return { vars = { numerator, denominator } }
    end,
    
    calculate = function(self, card, context)
        if context.hand_drawn and card.ability.extra.drawn == true and G.GAME.current_round.hands_left > 1 then
            if SMODS.pseudorandom_probability(card, 'pokes_para', 1, card.ability.extra.odds) then
                --G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1
                ease_hands_played(-1)
            end
            card.ability.extra.drawn = false
        end


        if context.playing_card_end_of_round or ( context.discard and context.other_card == card ) then
            card.ability.extra.drawn = true
        end
        if context.main_scoring and context.cardarea == G.play then
            card.ability.extra.drawn = true
        end
    end,
    in_pool = function(self, args)
        return false
    end

}
-- Poison
SMODS.Enhancement {
    key = 'psn',
    atlas = 'enh',
    pos = { x = 0, y = 1 }, soul_pos = { x = 3, y = 0 },
    config = { extra = { drawn = true } },
    weight = 0,
    overrides_base_rank = true,
    calculate = function(self, card, context)

        if context.hand_drawn and card.ability.extra.drawn == true then -- breaks when reloading a run lol
            local psnD = {}
            local notPsn = {}
            local any_selected = nil
            for k, v in pairs(G.hand.cards) do
                if SMODS.has_enhancement(v, "m_pokes_psn") then
                    if v.ability.extra.drawn == true then            
                        psnD[ # psnD + 1 ] = v      
                        v.ability.extra.drawn = false
                    end
                else 
                    notPsn[ # notPsn + 1 ] = v
                end 
            end

            local toxic = 1
            for _,v in pairs(G.jokers.cards) do
                if v.ability.extra.stage == 'Muk' then
                    toxic = 2
                end
            end

            for k, v in pairs(G.hand.cards) do
                if not(SMODS.has_enhancement(v, "m_pokes_psn") ) then
                    G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + math.max(math.min( # psnD, # notPsn ),5)
                    for i = 1, math.min( ( # psnD ) * toxic, # notPsn ) do
                        if G.hand.cards[i] then
                            local selected_card, card_index = pseudorandom_element(notPsn)
                            G.hand:add_to_highlighted(selected_card)
                            table.remove(notPsn, card_index)
                            any_selected = true
                            play_sound('card1', 1)
                        end
                    end
                    if any_selected then G.FUNCS.discard_cards_from_highlighted(nil, true) end

                    G.hand.config.highlighted_limit = 5
                    break
                end
            end
            card.ability.extra.drawn = false
        end

        if context.playing_card_end_of_round or ( context.discard and context.other_card == card ) then
            card.ability.extra.drawn = true
        end
        if context.main_scoring and context.cardarea == G.play then
            card.ability.extra.drawn = true
        end
    end,
    in_pool = function(self, args)
        return false
    end,
}
-- Freeze
SMODS.Enhancement {
    key = 'freeze',
    atlas = 'enh',
    no_suit = true,
    no_rank = true,
    pos = { x = 0, y = 1 }, soul_pos = { x = 4, y = 1 },
    weight = 0,
    overrides_base_rank = true,
    in_pool = function(self, args)
        return false
    end
}
-- Confusion
SMODS.Enhancement {
    key = 'confusion',
    atlas = 'enh',
    pos = { x = 0, y = 1 }, soul_pos = { x = 5, y = 1 },
    config = { Xmult = 1.5, extra = { odds = 2 }, Xchips = 0.5 },
    weight = 0,
    overrides_base_rank = true,
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'pokes_confusion')
        return { vars = { card.ability.Xmult, card.ability.Xchips, numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play and
        SMODS.pseudorandom_probability(card, 'pokes_confusion', 1, card.ability.extra.odds) then
            return { x_chips = card.ability.Xchips }
        end
    end,
    in_pool = function(self, args)
        return false
    end
}

--Club Energy
SMODS.Enhancement {
    key = 'energy_club',
    atlas = 'enh',
    pos = { x = 0, y = 2 },
    config = { extra = { give = 3, suitgive = 'Clubs' } },
    weight = 2.5,
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    never_scores = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.give, card.ability.extra.suitgive } }
    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card == card and G.jokers and G.jokers.cards and G.jokers.cards[1]
        and G.jokers.cards[1].ability and G.jokers.cards[1].ability.extra and type(G.jokers.cards[1].ability.extra) == 'table'
        and G.jokers.cards[1].ability.extra.energy and G.jokers.cards[1].ability.extra.suit
        and G.jokers.cards[1].ability.extra.suit == card.ability.extra.suitgive then
            G.jokers.cards[1].ability.extra.energy = G.jokers.cards[1].ability.extra.energy + card.ability.extra.give 
        end
    end,
    in_pool = function(self, args)
        return false
    end
}
--Diamond Energy
SMODS.Enhancement {
    key = 'energy_diamond',
    atlas = 'enh',
    pos = { x = 1, y = 2 },
    config = { extra = { give = 3, suitgive = 'Diamonds' } },
    weight = 2.5,
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    never_scores = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.give, card.ability.extra.suitgive } }
    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card == card and G.jokers and G.jokers.cards and G.jokers.cards[1]
        and G.jokers.cards[1].ability and G.jokers.cards[1].ability.extra and type(G.jokers.cards[1].ability.extra) == 'table'
        and G.jokers.cards[1].ability.extra.energy and G.jokers.cards[1].ability.extra.suit
        and G.jokers.cards[1].ability.extra.suit == card.ability.extra.suitgive then
            G.jokers.cards[1].ability.extra.energy = G.jokers.cards[1].ability.extra.energy + card.ability.extra.give 
        end
    end,
    in_pool = function(self, args)
        return false
    end
}
--Spade Energy
SMODS.Enhancement {
    key = 'energy_spade',
    atlas = 'enh',
    pos = { x = 2, y = 2 },
    config = { extra = { give = 3, suitgive = 'Spades' } },
    weight = 2.5,
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    never_scores = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.give, card.ability.extra.suitgive } }
    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card == card and G.jokers and G.jokers.cards and G.jokers.cards[1]
        and G.jokers.cards[1].ability and G.jokers.cards[1].ability.extra and type(G.jokers.cards[1].ability.extra) == 'table'
        and G.jokers.cards[1].ability.extra.energy and G.jokers.cards[1].ability.extra.suit
        and G.jokers.cards[1].ability.extra.suit == card.ability.extra.suitgive then
            G.jokers.cards[1].ability.extra.energy = G.jokers.cards[1].ability.extra.energy + card.ability.extra.give 
        end
    end,
    in_pool = function(self, args)
        return false
    end
}
--Heart Energy
SMODS.Enhancement {
    key = 'energy_heart',
    atlas = 'enh',
    pos = { x = 3, y = 2 },
    config = { extra = { give = 3, suitgive = 'Hearts' } },
    weight = 2.5,
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    never_scores = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.give, card.ability.extra.suitgive } }
    end,
    calculate = function(self, card, context)
        if context.discard and context.other_card == card and G.jokers and G.jokers.cards and G.jokers.cards[1]
        and G.jokers.cards[1].ability and G.jokers.cards[1].ability.extra and type(G.jokers.cards[1].ability.extra) == 'table'
        and G.jokers.cards[1].ability.extra.energy and G.jokers.cards[1].ability.extra.suit
        and G.jokers.cards[1].ability.extra.suit == card.ability.extra.suitgive then
            G.jokers.cards[1].ability.extra.energy = G.jokers.cards[1].ability.extra.energy + card.ability.extra.give 
        end
    end,
    in_pool = function(self, args)
        return false
    end
}
--Brock's Stone Card
SMODS.Enhancement {
    key = 'stone_brock',
    atlas = 'enh',
    pos = { x = 8, y = 0 }, soul_pos = { x = 4, y = 2 },
    config = { bonus = 50 },
    replace_base_card = true,
    no_rank = true,
    no_suit = false,
    always_scores = true,
    overrides_base_rank = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.bonus } }
    end,
    calculate = function(self, card, context)
        if context.modify_scoring_hand then
            SMODS.change_base(card, 'Diamonds')
        end
    end,
    in_pool = function(self, args)
        return false
    end
}

--Misty's Lucky Card
SMODS.Enhancement {
    key = 'lucky_misty',
    atlas = 'enh',
    pos = { x = 9, y = 0 }, soul_pos = { x = 6, y = 2 },
    config = {extra={m_pokes_lucky_misty = true, odds = 2, give = 2},},
    overrides_base_rank = true,
    loc_vars = function(self, info_queue, card)
        local mult_numerator, mult_denominator = SMODS.get_probability_vars(card, 1, 4,
            'lucky_mult')
        local dollars_numerator, dollars_denominator = SMODS.get_probability_vars(card, 1,
            15, 'lucky_money')
        local energy_numerator, energy_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'pokes_lucky_misty')
        return { vars = { mult_numerator, dollars_numerator, mult_denominator, dollars_denominator,
                          energy_numerator, energy_denominator, card.ability.extra.give } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, 'pokes_lucky_misty', 1, card.ability.extra.odds) then
                card.lucky_trigger = true
               for _,v in pairs(G.jokers.cards) do
                    if v.ability and v.ability.extra and type(v.ability.extra) == 'table' and v.ability.extra.energy then
                        v.ability.extra.energy = v.ability.extra.energy + card.ability.extra.give
                    end
               end
            end
        end

            if context.check_enhancement and context.other_card and context .other_card.ability and context.other_card.ability.extra
            and type(context.other_card.ability.extra) == 'table' and context.other_card.ability.extra.m_pokes_lucky_misty == true then
                return { m_lucky = true }
            end
    end,
    in_pool = function(self, args)
        return false
    end
}
--Pokemon Nurse's Card
SMODS.Enhancement {
    key = 'bonus_nurse',
    atlas = 'enh',
    config = {bonus = 20},
    pos = { x = 10, y = 0 }, soul_pos = { x = 7, y = 2 },
    overrides_base_rank = true,
    calculate = function(self, card, context)

        if context.before then
            local my_pos = nil
            for i = 1, #context.full_hand do
                if context.full_hand[i] == card then
                    my_pos = i
                    break
                end
            end
            if my_pos and context.full_hand[my_pos+1] then
                context.full_hand[my_pos+1]:set_ability('m_pokes_bonus_nurse', nil, true)
                context.full_hand[my_pos+1]:juice_up(0.2,0.2)
            end
        end
    end,
    in_pool = function(self, args)
        return false
    end

}-- Sabrina's Red Seal
SMODS.Seal {
    key = 'Redsabrina',
    atlas = 'enh',
    pos = { x = 5, y = 2 },
    config = { extra = { retriggers = 2 } },
    badge_colour = G.C.RED,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.hand and (next(context.card_effects[1]) or #context.card_effects > 1) then
            local random_enhancement = SMODS.poll_enhancement {key = "pokes_sabrina", guaranteed = true}
            if random_enhancement == 'm_stone' then random_enhancement = 'm_steel' end --hehe
            card:set_ability(random_enhancement, nil, true)
            
            return {
                repetitions = card.ability.seal.extra.retriggers,
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.retriggers } }
    end,
    in_pool = function(self, args)
        return false
    end
}-- Tate and Liza's Purple Seal
SMODS.Seal {
    key = 'purple_tateliza',
    atlas = 'enh',
    pos = { x = 8, y = 2 },
    config = { extra = { pokes_purple_tateliza_seal = true } },
    badge_colour = G.C.PURPLE,
    calculate = function(self, card, context)

            if context.pre_discard then
                for _,v in pairs(context.full_hand) do
                    
                    if v == card then
                        SMODS.calculate_context({ other_card = v, discard = true, full_hand = context.full_hand}) 
                    end

                end
            end

    end,
    in_pool = function(self, args)
        return false
    end
}
-- Pokeball Seal
SMODS.Seal {
    key = 'pokeball',
    atlas = 'enh',
    pos = { x = 7, y = 1 },
    badge_colour = G.C.RED,
    calculate = function(self, card, context)

        if context.hand_drawn then
            local just_drawned = false
            for _,v in pairs(context.hand_drawn) do
                if v == card then
                    just_drawned = true
                    break
                end
            end

            if not just_drawned then
            -- G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + 1
                G.hand:add_to_highlighted(card)    
                G.FUNCS.discard_cards_from_highlighted(nil, true)
                if card then G.hand:remove_from_highlighted(card) end
            -- G.hand.config.highlighted_limit= G.hand.config.highlighted_limit - 1

                if #G.deck.cards > 0 then
                    draw_card(G.deck,G.hand,70,'up',true)
                end
            end
        end

        if context.discard and context.other_card == card and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                delay = 0.0,
                func = function()
                    SMODS.add_card({ set = 'pokes_Trainer' })
                    G.GAME.consumeable_buffer = 0
                    return true
                end
            }))
            return { message = '+1 Trainer', colour = G.C.GRAY }
        end
    end,
    --in_pool = function(self, args)
    --    return false
    --end
}

--Ditto
--Foil
SMODS.Enhancement {
    key = 'ditto_foil',
    weight = 0,
    atlas = 'enh',
    pos = { x = 0, y = 1 }, soul_pos = { x = 4, y = 0 },
    config = { bonus = 50 },
    overrides_base_rank = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.bonus } }
    end,
    in_pool = function(self, args)
        return false
    end
}
--Holo
SMODS.Enhancement {
    key = 'ditto_holo',
    weight = 0,
    atlas = 'enh',
    pos = { x = 0, y = 1 }, soul_pos = { x = 5, y = 0 },
    config = { mult = 10 },
    overrides_base_rank = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.mult } }
    end,
    in_pool = function(self, args)
        return false
    end
}
--Poly
SMODS.Enhancement {
    key = 'ditto_poly',
    weight = 0,
    atlas = 'enh',
    pos = { x = 0, y = 1 }, soul_pos = { x = 6, y = 0 },
    config = { Xmult = 1.5 },
    overrides_base_rank = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.Xmult } }
    end,
    in_pool = function(self, args)
        return false
    end
}
