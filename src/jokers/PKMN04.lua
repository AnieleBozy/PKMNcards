SMODS.Joker {
    key = "039", --Jigglypuff/Wigglytuff
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Heart',
    cost = 4,
    pos = { x = 39, y = 0 },-- spritex
    config = { extra = { stage = 'Jigglypuff', stagef = 'Jigglypuff', suit = 'Hearts',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 39, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         add = 15 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_heart'}
        --Extra        
            local stage_key = 'j_pokes_039'
            if (card.ability.extra.stage == 'Wigglytuff') then
                stage_key = 'j_pokes_040'
            end


            return { vars = { card.ability.extra.stage,                                                          --Stage
                                   card.ability.extra.add,                                                       --Extra
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 1),  --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 2),  --Move2
                                }, colours = { HEX('FF0037'), HEX('FFFFFF')}, 
                            }, key = stage_key
                    }
    end,
    
    -- Set sprite after reload
    set_sprites = function(self, card, front)
        G.E_MANAGER:add_event(Event({
            blockable = false;
            func = function()
                if not (card.ability.extra.stage == card.ability.extra.stagef) then
                    card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})
                end
            return true
            end
        }))
    end,

    calculate = function(self, card, context)
        -- Get energy from discards
        if context.discard and not context.blueprint and not context.other_card.debuff then
            if context.other_card:is_suit(card.ability.extra.suit) then
                card.ability.extra.energy = card.ability.extra.energy + 1
            end
        end

        -- Evolution
        if context.pokes_tag039 and card.ability.extra.stage == 'Jigglypuff' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Wigglytuff'                                     -- Set current stage
            card.ability.extra.spritex = 40                                         -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message    
        end
        
        --Ability
        if context.first_hand_drawn then
            for _, v in pairs(G.hand.cards) do
                --if not(SMODS.has_enhancement(v, "m_pokes_sleep")) then
                if not next(SMODS.get_enhancements(v)) then
                    v:set_ability('m_pokes_sleep')
                    v:juice_up(0.8, 0.8)
                    play_sound('timpani')
                    break
                end
            end
        end

        if context.individual and context.cardarea == G.hand and not context.end_of_round and card.ability.extra.energy >= 1 then
           if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                local s_chips = context.other_card.base.nominal
                if context.other_card.ability.perma_bonus then
                    s_chips = s_chips + context.other_card.ability.perma_bonus
                end
                if context.other_card.ability.bonus then
                    s_chips = s_chips + context.other_card.ability.bonus
                end
                return { chips = s_chips }
            end
        end
        
        if card.ability.extra.energy >= 2 and context.scoring_name == 'Pair'
        and context.individual and context.cardarea == G.play 
        and card.ability.extra.stage == 'Wigglytuff'
        and SMODS.has_enhancement(G.play.cards[1], "m_pokes_sleep") and SMODS.has_enhancement(G.play.cards[2], "m_pokes_sleep") then
            context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) +
                card.ability.extra.add
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS
            }
            
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 1 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        
        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
}SMODS.Joker {
    key = "041", --Zubat/Golbat/Crobat
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Spade',
    cost = 3,
    pos = { x = 41, y = 0 },-- spritex
    config = { extra = { stage = 'Zubat', stagef = 'Zubat', suit = 'Spades',          -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 41, spritey = 0, energy = 0, activem1 = false,                            -- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         mult = 6, xmult = 1, by = 0.1} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_spade'}
        --Extra
        local stage_key = 'j_pokes_041'
        if card.ability.extra.stage == 'Crobat' then
            stage_key = 'j_pokes_042a'
        end
        

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                   card.ability.extra.mult, card.ability.extra.xmult, card.ability.extra.by,        --Extra
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 1),  --Move1
                                },  colours = { HEX('FF0037'), HEX('FFFFFF')},
                            }, key = stage_key
                    }
    end,
    
    -- Set sprite after reload
    set_sprites = function(self, card, front)
        G.E_MANAGER:add_event(Event({
            blockable = false;
            func = function()
                if not (card.ability.extra.stage == card.ability.extra.stagef) then
                    card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})
                end
            return true
            end
        }))
    end,

    calculate = function(self, card, context)
        -- Get energy from discards
        if context.discard and not context.blueprint and not context.other_card.debuff then
            if context.other_card:is_suit(card.ability.extra.suit) then
                card.ability.extra.energy = card.ability.extra.energy + 1
            end
        end

        -- Evolution
        if context.pokes_tag041 and card.ability.extra.stage == 'Zubat' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Golbat'                                     -- Set current stage
            card.ability.extra.spritex = 42                                         -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra=
            card.ability.extra.mult = 9

                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                    for _, _card in pairs(G.playing_cards) do
                        if _card then
                            if next(SMODS.get_enhancements(_card)) then
                                _card:set_ability('c_base', nil, true)
                                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.by
                            end
                        end
                    end
                    return true
                    end
                }))

            --card.ability.extra.by = 0.2
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message    

        end
        if context.pokes_tag042 and card.ability.extra.stage == 'Golbat' then-- custom context
            -- Stage 2
            card.ability.extra.stage = 'Crobat'                                     -- Set current stage
            card.ability.extra.spritex = 42                                           -- Get proper sprite
            card.ability.extra.spritey = 1
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})   -- Set sprite
                                                                                      -- Extra=
            card.ability.extra.mult = 12

                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                    for _, _card in pairs(G.playing_cards) do
                        if _card then
                            if next(SMODS.get_enhancements(_card)) then
                                _card:set_ability('c_base', nil, true)
                                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.by
                            end
                        end
                    end
                    return true
                    end
                }))

            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message    

        end
        
        -- Move1
        if context.joker_main and card.ability.extra.energy >= 1 and not (next(context.poker_hands['Three of a Kind'])) then
            return { mult = card.ability.extra.mult }
        end
        if context.joker_main then
            return { xmult = card.ability.extra.xmult }
        end


        --Message after getting access to move
        if card.ability.extra.energy >= 1 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context, card) -- Reset energy at end of round
  ---Extra--- 
    end,
}

SMODS.Joker {
    key = "043", --Oddish/Gloom/Vileplume/Bellossom
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Club',
    cost = 4,
    pos = { x = 43, y = 0 },-- spritex
    config = { extra = { stage = 'Oddish', stagef = 'Oddish', suit = 'Clubs',          -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 43, spritey = 0, energy = 0, activem1 = false,                            -- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         gain = 1, dollars = 3, lose = 9} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club'}
        --Extra
        local stage_key = 'j_pokes_043'
        if card.ability.extra.stage == 'Bellossom' then
            stage_key = 'j_pokes_045evo'
        end
        

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                   card.ability.extra.gain, card.ability.extra.dollars, card.ability.extra.lose,        --Extra
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, card.ability.extra.lose),  --Move1
                                },  colours = { HEX('FF0037'), HEX('FFFFFF')},
                            }, key = stage_key
                    }
    end,
    
    -- Set sprite after reload
    set_sprites = function(self, card, front)
        G.E_MANAGER:add_event(Event({
            blockable = false;
            func = function()
                if not (card.ability.extra.stage == card.ability.extra.stagef) then
                    card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})
                end
            return true
            end
        }))
    end,

    calculate = function(self, card, context)
        -- Get energy from discards
        if context.discard and not context.blueprint and not context.other_card.debuff then
            if context.other_card:is_suit(card.ability.extra.suit) then
                card.ability.extra.energy = card.ability.extra.energy + 1
            end
            local id = context.other_card:get_id()
            if (id <= 10 and id >= 0 and id % 2 == 1) or (id == 14) then
                card.ability.extra.energy = card.ability.extra.energy + card.ability.extra.gain
            end
        end

        -- Evolution
        if context.pokes_tag043 and card.ability.extra.stage == 'Oddish' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Gloom'                                     -- Set current stage
            card.ability.extra.spritex = 44                                         -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.gain = 3
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message    
        end
        if context.pokes_tag044 and card.ability.extra.stage == 'Gloom' then-- custom context
            -- Stage 2
            card.ability.extra.stage = 'Vileplume'                                     -- Set current stage
            card.ability.extra.spritex = 45                                         -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.dollars    = 5
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message    
        end
        if context.pokes_tag044evo and card.ability.extra.stage == 'Gloom' then-- custom context
            -- Stage 2 Evo
            card.ability.extra.stage = 'Bellossom'                                     -- Set current stage
            card.ability.extra.spritex = 45                                            -- Get proper sprite
            card.ability.extra.spritey = 1
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})   -- Set sprite
                                                                                      -- Extra
            --card.ability.extra.lose    = 11
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message    
        end
        
        -- Move1
        if context.individual and context.cardarea == G.play and
        card.ability.extra.energy >= card.ability.extra.lose
        and not(card.ability.extra.stage == 'Bellossom')
        and context.other_card:is_suit(card.ability.extra.suit) then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.dollars
            card.ability.extra.energy = card.ability.extra.energy - card.ability.extra.lose
            return {
                dollars = card.ability.extra.dollars,
                func = function() -- This is for timing purposes, it runs after the dollar manipulation
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end

        --Move1alt
        if context.repetition and context.cardarea == G.play and context.other_card == context.scoring_hand[1]
        and card.ability.extra.energy >= 15 and card.ability.extra.stage == 'Bellossom' then
            local repetitions = math.floor(card.ability.extra.energy / card.ability.extra.lose)
            --print(repetitions)
            card.ability.extra.energy = card.ability.extra.energy - (card.ability.extra.lose * repetitions)
            return {
                repetitions = repetitions
            }
        end


        --Message after getting access to move
        if card.ability.extra.energy >= card.ability.extra.lose and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context, card) -- Reset energy at end of round
  ---Extra--- 
    end,
}
SMODS.Joker {
    key = "046", --Paras/Parasect
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Club',
    cost = 6,
    pos = { x = 46, y = 0 },-- spritex
    config = { extra = { stage = 'Paras', stagef = 'Paras', suit = 'Clubs',          -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 46, spritey = 0, energy = 0, activem1 = false,                            -- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         add = 1} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club'}
        --Extra
        local stage_key
        if card.ability.extra.stage == 'Parasect' then
            stage_key = 'j_pokes_047'
        else
            stage_key = 'j_pokes_046'
        end

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                   card.ability.extra.add,                               --Extra
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 3),  --Move1
                                },  colours = { HEX('FF0037'), HEX('FFFFFF')},
                            }, key = stage_key
                    }
    end,
    
    -- Set sprite after reload
    set_sprites = function(self, card, front)
        G.E_MANAGER:add_event(Event({
            blockable = false;
            func = function()
                if not (card.ability.extra.stage == card.ability.extra.stagef) then
                    card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})
                end
            return true
            end
        }))
    end,

    calculate = function(self, card, context)
        -- Get energy from discards
        if context.discard and not context.blueprint and not context.other_card.debuff then
            if context.other_card:is_suit(card.ability.extra.suit) then
                card.ability.extra.energy = card.ability.extra.energy + card.ability.extra.add
            end
        end

        -- Evolution
        if context.pokes_tag046 and card.ability.extra.stage == 'Paras' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Parasect'                                     -- Set current stage
            card.ability.extra.spritex = 47                                         -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.add = 1
                                                                                      
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message    
        end
      

        --Move1 
        if context.before and #context.full_hand == 1 and card.ability.extra.energy >=3 then
            card.ability.extra_value = card.ability.extra_value + card.ability.extra.add
            card:set_cost()
            card:juice_up(0.4,0.4)
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 3 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context, card) -- Reset energy at end of round
  ---Extra--- 
    end,

    remove_from_deck = function(self, card, from_debuff) 

        if card then
           if card.sell_cost > 0 then
            local _self = copy_card(card, nil, nil, nil)
            _self:set_edition()
            _self.ability.extra_value = -3
            _self:set_cost()
            _self:add_to_deck()
            G.jokers:emplace(_self)

           end 

            if G.hand.cards[1] then
                local copies = 1
                local cards = {}
                if card.ability.extra.stage == 'Parasect' then
                    copies = card.sell_cost
                end

                for i=1,copies,1 do
                    local card_copied = copy_card(G.hand.cards[1], nil, nil, G.playing_card)
                    card_copied:set_ability( pseudorandom_element( { 'm_pokes_sleep', 'm_pokes_psn', 'm_pokes_burn', 'm_pokes_freeze', 'm_pokes_para' } ) )
                    card_copied:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, card_copied)
                    G.hand:emplace(card_copied)
                    card_copied.states.visible = nil
                    cards[ # cards + 1 ] = card_copied

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card_copied:start_materialize()
                            return true
                        end
                    }))
                end

                    return {
                        message = localize('k_copied_ex'),
                        colour = G.C.CHIPS,
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    SMODS.calculate_context({ playing_card_added = true, cards = cards })
                                    return true
                                end
                            }))
                        end
                    }
            end

        end

    end,
}