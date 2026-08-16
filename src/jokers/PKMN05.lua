SMODS.Joker {
    key = "048", --Venonat/Venomoth
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Spade',
    cost = 5,
    pos = { x = 48, y = 0 },-- spritex
    config = { extra = { stage = 'Venonat', stagef = 'Venonat', suit = 'Spades',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 48, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         chips = 50, mod = 5, chips2 = 100, mod2 = 20 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_spade'}
        --Extra   
        local stage_key = 'j_pokes_048'
        if card.ability.extra.stage == 'Venomoth' then
            stage_key = 'j_pokes_049'
        end

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                   card.ability.extra.chips, card.ability.extra.mod,                             --Extra
                                   card.ability.extra.chips2, card.ability.extra.mod2,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 3),  --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 5),  --Move2
                                },
                            },key = stage_key,
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
        if context.pokes_tag048 and card.ability.extra.stage == 'Venonat' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Venomoth'                                     -- Set current stage
            card.ability.extra.spritex = 49                                         -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.chips = card.ability.extra.chips + 60
            card.ability.extra.chips2 = card.ability.extra.chips2 + 100
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message    
        end
        
        --Move1
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint
        and card.ability.extra.chips2 > 0 then
            card.ability.extra.chips2 = card.ability.extra.chips2 - card.ability.extra.mod2
        end
        if context.joker_main and card.ability.extra.energy >=3 and card.ability.extra.energy < 5 then
            return { chips = card.ability.extra.chips2 }
        end

        --Move2
        if context.joker_main and card.ability.extra.energy >=5 and card.ability.extra.stage == 'Venomoth' then

            local chips_current = card.ability.extra.chips + card.ability.extra.chips2
            if card.ability.extra.chips > 0 then
                card.ability.extra.chips = card.ability.extra.chips - card.ability.extra.mod
            end

            return {
                chips = chips_current
            }
        end


        --Message after getting access to move
        if card.ability.extra.energy >= 3 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= 5 and card.ability.extra.activem2 == false and card.ability.extra.stage == 'Venomoth' then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end
        
        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
}
SMODS.Joker {
    key = "050", --Diglett/Dugtrio
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Diamond',
    cost = 4,
    pos = { x = 50, y = 0 },-- spritex
    config = { extra = { stage = 'Diglett', stagef = 'Diglett', suit = 'Diamonds',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 50, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         mult = 6, draw = 6 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_diamond'}
        --Extra     
        local stage_key = 'j_pokes_050'
        if card.ability.extra.stage == 'Dugtrio' then
            stage_key = 'j_pokes_051'
        end

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                   card.ability.extra.mult, card.ability.extra.draw,                             --Extra
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 3),  --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 6),  --Move2
                                },
                            },key = stage_key,
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
        if context.pokes_tag050 and card.ability.extra.stage == 'Diglett' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Dugtrio'                                     -- Set current stage
            card.ability.extra.spritex = 51                                       -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.mult = 10
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message    
        end
        
        --Move1        
        if context.joker_main and card.ability.extra.energy >= 3 then
            local playsize = # G.play.cards
            if playsize < 2 then
                return { mult = card.ability.extra.mult }                
            else
                for i=2,playsize do
                    if G.play.cards[1].config.card.suit == G.play.cards[i].config.card.suit then
                     return false
                    end
                end
                return { mult = card.ability.extra.mult }
            end
        end

        --Move2
        if context.discard and #context.full_hand == 3 and card.ability.extra.energy >= 6
        and context.other_card == context.full_hand[#context.full_hand]
        and card.ability.extra.stage == 'Dugtrio' then
            --SMODS.draw_cards(2)
                return {
                    delay = 0.45,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                SMODS.draw_cards( card.ability.extra.draw )
                                return true
                            end
                        }))
                    end
                }
        end


        --Message after getting access to move
        if card.ability.extra.energy >= 3 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= 6 and card.ability.extra.activem2 == false
        and card.ability.extra.stage == 'Dugtrio' then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end
        
        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
}
SMODS.Joker {
    key = "052", --Meowth/Persian
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Normal',
    cost = 6,
    pos = { x = 52, y = 0 },-- spritex
    config = { extra = { stage = 'Meowth', stagef = 'Meowth', suit = 'Normal',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 50, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         chips = 0, add = 25, dollars = 4, dollars_true = true } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_normal'}
        --Extra     
        local stage_key = 'j_pokes_052'
        if card.ability.extra.stage == 'Persian' then
            stage_key = 'j_pokes_053'
        end

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                   card.ability.extra.dollars, card.ability.extra.chips, card.ability.extra.add, --Extra
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 5),  --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 15),  --Move2
                                },
                            },key = stage_key,
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
                card.ability.extra.energy = card.ability.extra.energy + 1
        end

        -- Evolution
        if context.pokes_tag052 and card.ability.extra.stage == 'Meowth' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Persian'                                     -- Set current stage
            card.ability.extra.spritex = 53                                       -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.dollars = 5
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message    
        end
        
        --Move1        
        if card.ability.extra.energy >= 5 and card.ability.extra.dollars_true == true then
            card.ability.extra.dollars_true = false
            return { dollars = card.ability.extra.dollars }
        end
        
        --Move2
        if context.joker_main and card.ability.extra.stage == 'Persian' then
            return { chips = card.ability.extra.chips }
        end




        --Message after getting access to move
        if card.ability.extra.energy >= 15 and card.ability.extra.activem2 == false and card.ability.extra.stage == 'Persian' then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end
        
        --ENERGY_RESET(context,card)
  ---Extra--- 
    end,
        --Move2
    calc_dollar_bonus = function(self, card)
        card.ability.extra.activem1 = false
        card.ability.extra.activem2 = false
        card.ability.extra.dollars_true = true
        if G.GAME.dollars > card.ability.extra.chips and card.ability.extra.energy >= 15 and card.ability.extra.stage == 'Persian' then
            card.ability.extra.energy = 0
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.add
            card:juice_up(0.2,0.2)
        else
            card.ability.extra.energy = 0
        end
    end
}
SMODS.Joker {
    key = "054", --Psyduck/Golduck
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Club',
    cost = 6,
    pos = { x = 54, y = 0 },-- spritex
    config = { extra = { stage = 'Psyduck', stagef = 'Psyduck', suit = 'Clubs',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 54, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         sell = 2, odds = 2 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club'}
        --Extra     
        local psyduck_card = G.GAME.current_round.pokes_psyduck_card or { rank = 'Ace', suit = 'Clubs' }
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'pokes_psyduckodd')


            return { vars = { card.ability.extra.stage,                                                          --Stage
                                   card.ability.extra.sell,                                                      --Extra
                                   localize(psyduck_card.rank, 'ranks'), localize(psyduck_card.suit, 'suits_plural'), colours = { G.C.SUITS[psyduck_card.suit] },
                                   numerator, denominator,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 4),  --Move1
                                },
                            },
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
        if context.discard and not context.blueprint and not context.other_card.debuff
        and context.other_card:is_suit(card.ability.extra.suit) then
                card.ability.extra.energy = card.ability.extra.energy + 1
        end

        -- Evolution
        if context.pokes_tag054 and card.ability.extra.stage == 'Psyduck' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Golduck'                                     -- Set current stage
            card.ability.extra.spritex = 55                                       -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.sell = 4
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message    
        end
        
        if context.individual and context.cardarea == G.play and card.ability.extra.energy >= 4 and SMODS.pseudorandom_probability(card, 'pokes_psyduckodd', 1, card.ability.extra.odds) and
            context.other_card:get_id() == G.GAME.current_round.pokes_psyduck_card.id and
            context.other_card:is_suit('Clubs') then

                local _card = pseudorandom_element(G.jokers.cards)
                if _card.set_cost then
                    _card.ability.extra_value = (_card.ability.extra_value or 0) +
                        card.ability.extra.sell
                    _card:set_cost()
                end
        end




        --Message after getting access to move
        if card.ability.extra.energy >= 4 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        
        if (context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint )
        or not G.GAME.current_round.pokes_psyduck_card then
            G.GAME.current_round.pokes_psyduck_card = { rank = 'Ace', suit = 'Clubs' }
            local valid_psyduck_cards = {}
            for _, playing_card in ipairs(G.playing_cards) do
                if not SMODS.has_no_suit(playing_card) and not SMODS.has_no_rank(playing_card)
                and playing_card:is_suit("Clubs") then
                    valid_psyduck_cards[#valid_psyduck_cards + 1] = playing_card
                end
            end
            local psyduck_card = pseudorandom_element(valid_psyduck_cards, 'pokes_psyduck' .. G.GAME.round_resets.ante)
            if psyduck_card then
                G.GAME.current_round.pokes_psyduck_card.rank = psyduck_card.base.value
                G.GAME.current_round.pokes_psyduck_card.suit = 'Clubs'--psyduck_card.base.suit
                G.GAME.current_round.pokes_psyduck_card.id = psyduck_card.base.id
            end
            
        end

        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
}
SMODS.Joker {
    key = "056", --Mankey/Primeape
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Diamond',
    cost = 4,
    pos = { x = 56, y = 0 },-- spritex
    config = { extra = { stage = 'Mankey', stagef = 'Mankey', suit = 'Diamonds',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 54, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         mult = 20, hands = 6, if_hand = false } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_diamond'}
        --Extra     
        local stage_key = 'j_pokes_056'
        if card.ability.extra.stage == 'Primeape' then
            stage_key = 'j_pokes_057'
        end
            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                                                                 --Extra
                                   card.ability.extra.mult, card.ability.extra.hands,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 2),  --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 3),  --Move1
                                },
                            },key = stage_key,
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
        if context.discard and not context.blueprint and not context.other_card.debuff
        and context.other_card:is_suit(card.ability.extra.suit) then
                card.ability.extra.energy = card.ability.extra.energy + 1
        end

        -- Evolution
        if context.pokes_tag056 and card.ability.extra.stage == 'Mankey' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Primeape'                                     -- Set current stage
            card.ability.extra.spritex = 57                                       -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
                card.ability.extra.mult = card.ability.extra.mult + 10
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message    
        end
        

        --Move2
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint
        and card.ability.extra.hands > 0 and card.ability.extra.stage == 'Primeape' then
            card.ability.extra.hands = card.ability.extra.hands - 1
        end
        if card.ability.extra.energy >= 3 and card.ability.extra.if_hand == false and card.ability.extra.stage == 'Primeape' then
            ease_hands_played(card.ability.extra.hands)
            card.ability.extra.if_hand = true
        end

        --Move1
        if context.joker_main and card.ability.extra.energy >=2 and card.ability.extra.mult > 0 then

                local mult_current = card.ability.extra.mult
                card.ability.extra.mult = card.ability.extra.mult - 2
                return {
                    mult = mult_current
                }

        end


        ENERGY_RESET(context,card)
        if (context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint ) and card.ability.extra.if_hand == true
         and card.ability.extra.stage == 'Primeape' then
            card.ability.extra.if_hand = false
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 2 and card.ability.extra.activem1 == false and card.ability.extra.mult > 0 then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= 3 and card.ability.extra.activem2 == false and card.ability.extra.stage == 'Primeape' 
        and card.ability.extra.hands > 0 then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end

  ---Extra--- 
    end,
}
SMODS.Joker {
    key = "058", --Growlithe/Arcanine
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Heart',
    cost = 5,
    pos = { x = 58, y = 0 },-- spritex
    config = { extra = { stage = 'Growlithe', stagef = 'Growlithe', suit = 'Hearts',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 58, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         Xmult = 3,} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_heart'}
        local stage_key = 'j_pokes_058'
        if card.ability.extra.stage == 'Arcanine' then
            stage_key = 'j_pokes_059'
        end
        --Extra     
            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                                                                 --Extra
                                   card.ability.extra.Xmult,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 1),  --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 3),  --Move2
                                },
                            }, key = stage_key,
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
        if context.discard and not context.blueprint and not context.other_card.debuff
        and context.other_card:is_suit(card.ability.extra.suit) then
                card.ability.extra.energy = card.ability.extra.energy + 1
        end

        -- Evolution
        if context.pokes_tag058 and card.ability.extra.stage == 'Growlithe' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Arcanine'                                     -- Set current stage
            card.ability.extra.spritex = 59                                       -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
                card.ability.extra.Xmult = 4
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message    
        end

        --Move2
        if context.joker_main and card.ability.extra.energy >=3 then
                for k, v in pairs(G.hand.cards) do
                    if not ( v.config.center.key == "m_pokes_burn" ) then
                        v:set_ability('m_pokes_burn')
                        v:juice_up(0.8, 0.8)
                        break
                    end                
                end

                return {
                    Xmult = card.ability.extra.Xmult
                }

        end

        --Move1
        if context.individual and context.cardarea == G.hand and not context.end_of_round and SMODS.has_enhancement(context.other_card, "m_pokes_burn")
        and card.ability.extra.energy >= 1 and card.ability.extra.stage == 'Arcanine' then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
           else
                local gave = false
                for _,v in pairs(G.jokers.cards) do
                    if v.ability.extra and type(v.ability.extra) == "table" and v.ability.extra.suit and v.ability.extra.suit == 'Hearts' and not(card == v)
                    and v.ability.extra.energy then
                        v.ability.extra.energy = v.ability.extra.energy + 1
                        gave = true
                       --return { delay = 0.3, message = ''..1, colour = G.C.SUITS.Hearts } 
                    end
                end
                if gave then card:juice_up(0.2,0.2) end
            end
        end


        ENERGY_RESET(context,card)

        --Message after getting access to move
        if card.ability.extra.energy >= 1 and card.ability.extra.activem1 == false and card.ability.extra.stage == 'Arcanine' then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= 3 and card.ability.extra.activem2 == false then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end

  ---Extra--- 
    end,
}