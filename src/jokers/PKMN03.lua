SMODS.Joker {
    key = "025", --/Pikachu/Raichu
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Diamond',
    cost = 5,
    pos = { x = 25, y = 0 },-- spritex
    config = { extra = { stage = 'Pikachu', stagef = 'Pikachu', suit = 'Diamonds',        -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 25, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         mult = 0, add = 1, spritey = 0 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_diamond'}
        --Extra

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                   card.ability.extra.mult, card.ability.extra.add,                              --Extra
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 10),  --Move1
                                },  colours = { HEX('FF0037'), HEX('FFFFFF')},
                            }, --key = stage_key
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
        if context.discard and not context.blueprint and not context.other_card.debuff
        and context.other_card:is_suit(card.ability.extra.suit)  then
            card.ability.extra.energy = card.ability.extra.energy + 1
                if card.ability.extra.energy >= 10 and card.ability.extra.activem1 == false then
                    card.ability.extra.activem1 = true
                    return {
                    message = localize('k_level_up_ex') }
                end
        end

        -- Evolution
        if context.pokes_tag026 and card.ability.extra.stage == 'Pikachu' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Raichu'                                     -- Set current stage
            card.ability.extra.spritex = 26                                         -- Get proper sprite
            card.ability.extra.spritey = 0
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.add = 2
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message    
        end
        
        --[[if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint 
        and card.ability.extra.stage == 'Pichu' then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.add
            return {
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.add } },
                colour = G.C.RED
            }
        end--]]
        if card.ability.extra.energy >= 10 and context.individual and context.cardarea == G.play and
            context.other_card:is_suit(card.ability.extra.suit) then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.add
            return {
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.add } },
                colour = G.C.RED }
        end
        if card.ability.extra.mult > 0 and context.joker_main then
            if card.ability.extra.energy >= 10 then
                card.ability.extra.energy = 0
            end
            return {mult = card.ability.extra.mult}
        end

        
        ENERGY_RESET(context, card) -- Reset energy at end of round
        

  ---Extra--- 
    end,
}
SMODS.Joker {
    key = "027", --Sandshrew/Sandslash
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Diamond',
    cost = 3,
    pos = { x = 27, y = 0 },-- spritex
    config = { extra = { stage = 'Sandshrew', stagef = 'Sandshrew', suit = 'Diamonds',          -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 27, energy = 0, activem1 = false,                            -- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         chips = 50, dig = 1} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_diamond'}
        --Extra
        

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                   card.ability.extra.dig, card.ability.extra.chips,                             --Extra
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
            if not(next(SMODS.get_enhancements(context.other_card)) == nil) then
                local pokeD = {}
                for _,v in pairs(G.jokers.cards) do
                    if v.ability.extra.suit and v.ability.extra.suit == 'Diamonds' and not(card == v) then
                        pokeD[#pokeD + 1] = v
                    end
                end 
                local randJoker = pseudorandom_element(pokeD)
                if randJoker then
                    randJoker.ability.extra.energy = randJoker.ability.extra.energy + card.ability.extra.dig
                    return { delay = 0.4,
                        message = ''..card.ability.extra.dig }
                end
            end
        end

        -- Evolution
        if context.pokes_tag027 and card.ability.extra.stage == 'Sandshrew' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Sandslash'                                     -- Set current stage
            card.ability.extra.spritex = 28                                         -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.chips = 100
            card.ability.extra.dig = 2
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message    
        end
        
        if context.joker_main and card.ability.extra.energy >= 3 and next(context.poker_hands['Two Pair']) then
            return { chips = card.ability.extra.chips }
        end

       -- if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
        --    card.ability.extra.activem1 = false
        --end
        
        --Message after getting access to move
        if card.ability.extra.energy >= 3 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context, card) -- Reset energy at end of round
  ---Extra--- 
    end,
}

SMODS.Joker {
    key = "029", --NidoranF/Nidorina/Nidoqueen
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Spade', --display type
    cost = 4,
    pos = { x = 29, y = 0 },-- spritex
    config = { extra = { stage = 'NidoranF', stagef = 'NidoranF', suit = 'Spades',          -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 29, energy = 0, activem1 = false,                            -- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         mult = 0, add = 3} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_spade'}
        --Extra
        
            return { vars = { card.ability.extra.stage,                                                          --Stage
                                   card.ability.extra.mult, card.ability.extra.add,                             --Extra
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 3),  --Move1
                                },
                            }
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
        if context.pokes_tag029 and card.ability.extra.stage == 'NidoranF' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Nidorina'                                     -- Set current stage
            card.ability.extra.spritex = 30                                       -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.add = 5
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message    
        end
        if context.pokes_tag030 and card.ability.extra.stage == 'Nidorina' then-- custom context
            -- Stage 2
            card.ability.extra.stage = 'Nidoqueen'                                     -- Set current stage
            card.ability.extra.spritex = 31                                       -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.add = 7
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message    
        end
        
        if context.joker_main and card.ability.extra.energy >= 3 then
            return { mult = card.ability.extra.mult }
        end
        
        if context.card_added and context.card.edition and context.card.edition.key == 'e_pokes_evolution' then--context.card.config.center.rarity == 'pokes_Evolution' then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.add
            return {
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.add } },
                colour = G.C.RED
            }
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
}
SMODS.Joker {
    key = "032", --NidoranM/Nidorino/Nidoking
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Spade', --display type
    cost = 3,
    pos = { x = 32, y = 0 },-- spritex
    config = { extra = { stage = 'NidoranM', stagef = 'NidoranM', suit = 'Spades',          -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 32, energy = 0, activem1 = false,                            -- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                        times = 1, poker_hand = 'Straight'} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_spade'}
        --Extra
        local stage_key = 'j_pokes_032'
        if card.ability.extra.stage == 'Nidorino' then
            stage_key = 'j_pokes_033'
        elseif card.ability.extra.stage == 'Nidoking' then
            stage_key = 'j_pokes_034'
        end
        
            return { vars = { card.ability.extra.stage,                                                          --Stage
                                   card.ability.extra.times, card.ability.extra.poker_hand,                      --Extra
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 4),  --Move1
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

        --Ability1
        if ( context.joker_main and next(context.poker_hands[card.ability.extra.poker_hand]) 
        and card.ability.extra.stage == 'Nidorino' ) then
            SMODS.add_card{ key = 'j_pokes_034', area = G.jokers, edition = 'e_pokes_evolution'}
        elseif ( context.joker_main and next(context.poker_hands[card.ability.extra.poker_hand]) 
        and card.ability.extra.stage == 'NidoranM' ) then
            SMODS.add_card{ key = 'j_pokes_033', area = G.jokers, edition = 'e_pokes_evolution'}
        end

        -- Evolution
        if ( context.pokes_tag033 and card.ability.extra.stage == 'Nidorino' ) then-- custom context

            -- Stage 2
            card.ability.extra.stage = 'Nidoking'                                     -- Set current stage
            card.ability.extra.spritex = 34                                           -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
            --return { delay = 0.8, message = '^', colour = HEX('83F1F7') }           -- Message 
        end
        if ( context.pokes_tag032 and card.ability.extra.stage == 'NidoranM'  ) then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Nidorino'                                     -- Set current stage
            card.ability.extra.spritex = 33                                           -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.times = 2
            --return { delay = 0.8, message = '^', ur = HEX('83F1coloF7') }             -- Message  
            card:juice_up(0.8,0.8)   
        end

        --Ability2
        if context.selling_card and context.card.ability.set == 'Joker'
        and context.card ~= card and context.card.config.center_key ~= 'j_pokes_032' and card.ability.extra.stage == 'Nidoking'
        and #G.jokers.cards <= G.jokers.config.card_limit then
            
            SMODS.add_card{ key = 'j_pokes_032', area = G.jokers}
            
            if #G.jokers.cards > G.jokers.config.card_limit then
                delay(0.5)
                SMODS.destroy_cards(G.jokers.cards[#G.jokers.cards], nil, nil, true)
                return { message =  localize('k_nope_ex') }
            end
        end
        
        --Move1
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint 
        and card.ability.extra.energy >= 4 then
            local k = 1
            while k > 0 do
                local my_pos = nil
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] == card then
                        my_pos = i
                        break
                    end
                end
                if my_pos and G.jokers.cards[my_pos + k] and not SMODS.is_eternal(G.jokers.cards[my_pos + k], card) and not G.jokers.cards[my_pos + k].getting_sliced then
                    local sliced_card = G.jokers.cards[my_pos + k]
                    sliced_card.getting_sliced = true
                    G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.joker_buffer = 0
                            card.ability.extra_value = card.ability.extra_value + sliced_card.sell_cost * card.ability.extra.times
                            card:set_cost()
                            card:juice_up(0.8, 0.8)
                            sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
                            play_sound('slice1', 0.96 + math.random() * 0.08)
                            return true
                        end
                    }))

                end
                if G.jokers.cards[my_pos + k] and G.jokers.cards[my_pos + k].config.center_key == 'j_pokes_032' and  
                G.jokers.cards[my_pos + k + 1] and G.jokers.cards[my_pos + k + 1].config.center_key == 'j_pokes_032' then
                    k = k + 1
                else 
                    k = 0
                end
            end
                    ENERGY_RESET(context, card) -- Reset energy at end of round
        end
        ENERGY_RESET(context, card) -- Reset energy at end of round
        
        
        --Message after getting access to move
        if card.ability.extra.energy >= 4 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
                delay = 0.3,
            message = localize('k_level_up_ex') }
        end
  ---Extra--- 
    end,
}

SMODS.Joker {
    key = "035", --Clefairy/Clefable
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Heart', --display type
    cost = 6,
    pos = { x = 35, y = 0 },-- spritex
    config = { extra = { stage = 'Clefairy', stagef = 'Clefairy', suit = 'Hearts',          -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 35, energy = 0, activem1 = false,                            -- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         odd1 = 4, odd2 = 15, lvlup = 1} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_heart'}
        --Extra
        local numerator1, denominator1 = SMODS.get_probability_vars(card, 1, card.ability.extra.odd1)
        local numerator2, denominator2 = SMODS.get_probability_vars(card, 1, card.ability.extra.odd2)

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                card.ability.extra.lvlup, numerator1, denominator1, numerator2, denominator2,      --Extra
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 1),  --Move1
                                },
                            }
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
        if context.pokes_tag035 and card.ability.extra.stage == 'Clefable' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Clefable'                                     -- Set current stage
            card.ability.extra.spritex = 36                                      -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.lvlup = 3
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message    
        end
        
        if context.end_of_round and context.individual and context.cardarea == G.hand 
        and SMODS.has_enhancement(context.other_card, 'm_lucky') and card.ability.extra.energy >= 1 then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                if SMODS.pseudorandom_probability(card, 'pokes_035', 1, card.ability.extra.odd1) then
                    local pokerHand = pseudorandom_element(SMODS.PokerHands).original_key
                    SMODS.upgrade_poker_hands({hands = {pokerHand}, level_up = card.ability.extra.lvlup, from = card})
                end
                if SMODS.pseudorandom_probability(card, 'pokes_035', 1, card.ability.extra.odd2) then
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        G.E_MANAGER:add_event(Event({
                            func = (function()
                                SMODS.add_card {
                                    set = 'Spectral',
                                }
                                G.GAME.consumeable_buffer = 0
                                return true
                            end)
                        }))
                        return {
                            message = localize('k_plus_spectral'),
                            colour = G.C.SECONDARY_SET.Spectral,
                        }
                    end
                end
            end
        end 
        
        
        --Message after getting access to move
        if card.ability.extra.energy >= 1 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end

  ---Extra--- 
    end,
    
    calc_dollar_bonus = function(self, card)
        card.ability.extra.activem1 = false
        if card.ability.extra.energy > 0 then
            card.ability.extra.energy = 0
        end
    end
}

SMODS.Joker {
    key = "037", --Vulpix/Ninetales
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Heart', --display type
    cost = 4,
    pos = { x = 37, y = 0 },-- spritex
    config = { extra = { stage = 'Vulpix', stagef = 'Vulpix', suit = 'Hearts',          -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 37, energy = 0, activem1 = false, activem2 = false,        -- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         spread = 1, chips = 30,} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_heart'}
        --Extra

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                card.ability.extra.chips, card.ability.extra.spread,                                --Extra
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 1),  --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 3),  --Move2
                                },
                            }
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
        if context.pokes_tag037 and card.ability.extra.stage == 'Vulpix' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Ninetales'                                     -- Set current stage
            card.ability.extra.spritex = 38                                         -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.chips = 90
            card.ability.extra.spread = 2
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message    
        end
        
        if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:get_id() == 9
        and card.ability.extra.energy >= 1 then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                local pokeD = {}
                for _,v in pairs(G.jokers.cards) do
                    if v.ability.extra and type(v.ability.extra) == "table" and v.ability.extra.suit and v.ability.extra.suit == 'Hearts' and not(card == v) then
                        v.ability.extra.energy = v.ability.extra.energy + card.ability.extra.spread
                    end
                end 
                return { delay = 0.3, message = '+', colour = G.C.SUITS.Hearts } 
            end
        end

        if context.joker_main and card.ability.extra.energy >= 3 then
            if G.hand.cards and G.hand.cards[1] then
                local do_chips = true
                for _,v in pairs(G.hand.cards) do
                    local compareid = v:get_id()
                    for _,u in pairs(G.hand.cards) do
                        if u ~= v and compareid == u:get_id() then
                            do_chips = false
                            break
                        end
                    end
                    if do_chips == false then break end
                end
                if do_chips then
                    return { chips = card.ability.extra.chips }
                end
            else
                return { chips = card.ability.extra.chips }
            end
        end
        
        
        --Message after getting access to move
        if card.ability.extra.energy >= 1 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= 3 and card.ability.extra.activem2 == false then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end
        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
}