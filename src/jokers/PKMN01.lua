SMODS.Joker { --Bulba/Ivy/Venusaur
    key = "001",
    atlas = "sprites",
    config = {
        extra = {
            energy = 0,
            normal = 0,
            suit = 'Clubs',
            odds = 4,
            dollars = 1,
            stage = 'Bulbasaur',
            high = 2,
            lows_display = 'Ace and 2',
            spritex = 1, activem1 = false,
        }
    },
    pos = {
        x = 1,
        y = 0
    },
    rarity = 'pokes_Club',
    cost = 7,
    blueprint_compat = false,
    discovered = true,
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club'}
        local low_cards = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                local card_id = playing_card:get_id()
                for i = 2, card.ability.extra.high, 1 do
                    if card_id == i then low_cards = low_cards + 1 break end
                    if card_id == 14 then low_cards = low_cards + 1 break end
                end
            end
        end
        
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'pokes_001')

        local stage_key = 'j_pokes_001'
        if card.ability.extra.stage == 'Ivysaur' then
            stage_key = 'j_pokes_002a'
        end
        if card.ability.extra.stage == 'Venusaur' then 
            stage_key = 'j_pokes_003'
        end
        
        return { vars = { numerator, denominator, card.ability.extra.dollars, low_cards,
                          card.ability.extra.energy, localize(card.ability.extra.suit, 'suits_singular'), card.ability.extra.stage,
                          elements = { ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 3),
                          ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),
                          
                           } }, key = stage_key }
    end,
    calc_dollar_bonus = function(self, card)
        if SMODS.pseudorandom_probability(card, 'pokes_001', 1, card.ability.extra.odds)
        and card.ability.extra.energy >= 3 then
            local low_cards = 0
            for _, playing_card in ipairs(G.playing_cards) do
                local card_id = playing_card:get_id()
            for i = 2, card.ability.extra.high, 1 do
                if card_id == i then low_cards = low_cards + 1 break end
            end
            if card_id == 14 then low_cards = low_cards + 1 end
                --if card_id == 2 or card_id == 3 then low_cards = low_cards + 1 end
            end
            card.ability.extra.energy = 0
            return low_cards > 0 and card.ability.extra.dollars * low_cards or nil
        elseif card.ability.extra.energy >= 3 then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    attention_text({
                        text = localize('k_nope_ex'),
                        scale = 1.3,
                        hold = 1.4,
                        major = card,
                        backdrop_colour = G.C.SECONDARY_SET.Tarot,
                        align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                            'tm' or 'cm',
                        offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                        silent = true
                    })
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.06 * G.SETTINGS.GAMESPEED,
                        blockable = false,
                        blocking = false,
                        func = function()
                            play_sound('tarot2', 0.76, 0.4)
                            return true
                        end
                    }))
                    play_sound('tarot2', 1, 0.4)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
        card.ability.extra.activem1 = false
        if not ( card.ability.extra.energy == 0 ) then
            card.ability.extra.energy = 0
        end
    end,
    calculate = function(self, card, context)
        if context.pokes_tag001 and card.ability.extra.stage == 'Bulbasaur' then
                            card.children.center:set_sprite_pos({ x=2, y=0 })
                            card.ability.extra.stage = 'Ivysaur'

                            card.ability.extra.high = 4
                            --card.ability.extra.lows_display = 'Ace, 2, 3 and 4'    
                            card.ability.extra.spritex = 2
                            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }
        elseif context.pokes_tag002 and card.ability.extra.stage == 'Ivysaur' then
                            card.children.center:set_sprite_pos({ x=3, y=0 })
                            card.ability.extra.stage = 'Venusaur'

                            card.ability.extra.high = 6
                            --card.ability.extra.lows_display = 'Ace, 2, 3, 4, 5 and 6'    
                            card.ability.extra.spritex = 3
                            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }            
        end

        if context.discard and not context.blueprint and not context.other_card.debuff and
            context.other_card:is_suit(card.ability.extra.suit) then
            card.ability.extra.energy = card.ability.extra.energy + 1
        elseif context.discard and not context.blueprint and not context.other_card.debuff and not
            context.other_card:is_suit(card.ability.extra.suit) then
            card.ability.extra.normal = card.ability.extra.normal + 1
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 3 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
    end,

    set_sprites = function(self, card, front)
        G.E_MANAGER:add_event(Event({
            blockable = false;
            func = function()
                if not (card.ability.extra.stage == 'Bulbasaur') then
                    card.children.center:set_sprite_pos({ x= card.ability.extra.spritex , y=0 })
                end
            return true
            end
        }))
    end,
}

SMODS.Joker {
    key = "004", --Squirtle/Wartortle/Blastoise
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Club',
    cost = 4,
    pos = { x = 7, y = 0 },
    config = { extra = { stage = 'Squirtle', stagef = 'Squirtle', suit = 'Clubs',     -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 7, energy = 0, activem1 = false, activem2 = false, -- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         chips = 30, hands = 0, isHand = false } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club'}
        --Extra
        local stage_key = 'j_pokes_004'
        if card.ability.extra.stage == 'Blastoise' then
            stage_key = 'j_pokes_006'
        end

            return { vars = { card.ability.extra.stage,                                                         --Stage
                                   card.ability.extra.chips, card.ability.extra.hands,                          --Extra
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit), --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 2), --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 5), --Move2/Ability
                                            move2                                                               --Move2/Ability
                                }
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
        if context.discard and not context.blueprint and not context.other_card.debuff and
            context.other_card:is_suit(card.ability.extra.suit) then
            card.ability.extra.energy = card.ability.extra.energy + 1
        --elseif context.discard and not context.blueprint and not context.other_card.debuff and not
        -- Nomal type enerrgy
        --    context.other_card:is_suit(card.ability.extra.suit) then
        --    card.ability.extra.normal = card.ability.extra.normal + 1
        end

        -- Evolution
        if context.pokes_tag004 and card.ability.extra.stage == 'Squirtle' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Wartortle'                                    -- Set current stage
            card.ability.extra.spritex = 8                                            -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.chips = 40                                                   
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message
        elseif context.pokes_tag005 and card.ability.extra.stage == 'Wartortle' then-- custom context
            --Stage 2
            card.ability.extra.stage = 'Blastoise'                                    -- Set current stage
            card.ability.extra.spritex = 9                                            -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.chips = 50                                         
            card.ability.extra.hands = 1
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message     
        end

        if card.ability.extra.energy >= 2 then -- Active with enough energy
            -- Moves and Ability
            --Move1
            if context.joker_main then
                return {
                    chips = G.GAME.current_round.hands_left * card.ability.extra.chips
                }
            end
            --Move2/Ability
            if card.ability.extra.energy >= 5 and not context.blueprint and not card.ability.extra.isHand and card.ability.extra.spritex == 9 then
                --G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
                ease_hands_played(card.ability.extra.hands)               
                card.ability.extra.isHand = true
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and
           card.ability.extra.spritex == 9 and card.ability.extra.energy >= 5 then
                --G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
                ease_hands_played(-card.ability.extra.hands)  
                card.ability.extra.isHand = false
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 2 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        --Message after getting access to move
        if card.ability.extra.energy >= 5 and card.ability.extra.stage == 'Blastoise' and card.ability.extra.activem2 == false then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context, card) -- Reset energy at end of round  ease_hands_played(-card.ability.extra.hands)

  ---Extra--- 
    end,
    remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.spritex == 9 and card.ability.extra.energy >= 5 then
            --G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
            ease_hands_played(-card.ability.extra.hands)
        end
    end

    

}

SMODS.Joker {
    key = "007", --Charmander/Charmeleon/Charizard
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Heart',
    cost = 4,
    pos = { x = 4, y = 0 },
    config = { extra = { stage = 'Charmander', stagef = 'Charmander', suit = 'Hearts',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 4, energy = 0,                                     -- Which sprite to get for you PKMN?, Current energy
                         activem1 = false, activem2 = false,
                                                                                      -- Extra
                         mult = 0, add = 1, lose = 20, d_size = 0, isD = false } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_heart'}
        --Extra
        local stage_key = 'j_pokes_007'
        if card.ability.extra.stage == 'Charizard' then
            stage_key = 'j_pokes_009'
        end

            return { vars = { card.ability.extra.stage,                                                         --Stage
                                   card.ability.extra.add, card.ability.extra.lose, card.ability.extra.mult,    --Extra
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit), --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 1), --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 5), --Move2/Ability
                                            move2                                                               --Move2/Ability
                                },
                                colours = { HEX('FF0037'), HEX('FFFFFF')}
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
        if context.discard and not context.blueprint and not context.other_card.debuff and
            context.other_card:is_suit(card.ability.extra.suit) then
            card.ability.extra.energy = card.ability.extra.energy + 1
        end

        -- Evolution
        if context.pokes_tag006 and card.ability.extra.stage == 'Charmander' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Charmeleon'                                   -- Set current stage
            card.ability.extra.spritex = 5                                            -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.lose = 10                                                   
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message
        elseif context.pokes_tag007 and card.ability.extra.stage == 'Charmeleon' then-- custom context
            --Stage 2
            card.ability.extra.stage = 'Charizard'                                    -- Set current stage
            card.ability.extra.spritex = 6                                            -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.add = 2                                         
            card.ability.extra.lose = 20                                    
            card.ability.extra.d_size = 1
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message     
        end

        if card.ability.extra.energy >= 1 then -- Active with enough energy
            -- Moves and Ability
            --Move1
            if context.discard and not context.blueprint and not context.other_card.debuff and
               context.other_card:is_suit(card.ability.extra.suit) then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.add
                return {
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.add } }
                }
            end
            
            --Move2/Ability
            if card.ability.extra.energy >= 5 and not context.blueprint and not card.ability.extra.isD 
               and card.ability.extra.spritex == 6 then
                --G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
                ease_discard(card.ability.extra.d_size)               
                card.ability.extra.isD = true
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and
           card.ability.extra.spritex == 6 and card.ability.extra.energy >= 5 then
                --G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
                ease_discard(-card.ability.extra.d_size)  
                card.ability.extra.isD = false
        end
        
        
        if context.joker_main then
            local lmult = card.ability.extra.mult
            card.ability.extra.mult = math.max(0, card.ability.extra.mult - card.ability.extra.lose)
            return {
                mult = lmult
            }
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 1 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= 5 and card.ability.extra.stage == 'Charizard' and card.ability.extra.activem2 == false then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context, card) -- Reset energy at end of round
        

  ---Extra--- 
    end,
    remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.spritex == 6 and card.ability.extra.energy >= 5 then
            --G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
            ease_discard(-card.ability.extra.d_size)
        end
    end
}

SMODS.Joker {
    key = "010", --Caterpie/Metapod/Butterfree
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Club',
    cost = 2,
    pos = { x = 10, y = 0 },
    config = { extra = { stage = 'Caterpie', stagef = 'Caterpie', suit = 'Clubs',     -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 10, energy = 0,                                    -- Which sprite to get for you PKMN?, Current energy
                         activem1 = false, activem2 = false,
                                                                                      -- Extra
                         mult = 3, h_size = 0, isH = false } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club'}
        --Extra
        local stage_key = 'j_pokes_010'
        if card.ability.extra.stage == 'Metapod' then
            stage_key = 'j_pokes_011'
        elseif card.ability.extra.stage == 'Butterfree' then
            stage_key = 'j_pokes_012'
        end

            return { vars = { card.ability.extra.stage,                                                         --Stage
                                   card.ability.extra.mult, card.ability.extra.h_size,    --Extra
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit), --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 1), --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 3), --Move2/Ability
                                            move2                                                               --Move2/Ability
                                },
                                colours = { HEX('FF0037'), HEX('FFFFFF')}
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
        if context.discard and not context.blueprint and not context.other_card.debuff and
            context.other_card:is_suit(card.ability.extra.suit) then
            card.ability.extra.energy = card.ability.extra.energy + 1
        end

        -- Evolution
        if context.pokes_tag010 and card.ability.extra.stage == 'Caterpie' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Metapod'                                      -- Set current stage
            card.ability.extra.spritex = 11                                           -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.mult = 6                                                   
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message
        elseif context.pokes_tag011 and card.ability.extra.stage == 'Metapod' then-- custom context
            --Stage 2
            card.ability.extra.stage = 'Butterfree'                                   -- Set current stage
            card.ability.extra.spritex = 12                                           -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.mult = 12                                   
            card.ability.extra.h_size = 2
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message     
        end

        if card.ability.extra.energy >= 1 then -- Active with enough energy
            --Moves and Ability
            --Move1
            if context.joker_main then
                return {
                    mult = card.ability.extra.mult
                }
            end
            
            --Move2
            if card.ability.extra.energy >= 3 and not context.blueprint and not card.ability.extra.isH 
            and card.ability.extra.spritex == 12 then
                G.hand:change_size(card.ability.extra.h_size)            
                card.ability.extra.isH = true
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and
        card.ability.extra.spritex == 12 and card.ability.extra.energy >= 3 then
            G.hand:change_size(-card.ability.extra.h_size)            
            card.ability.extra.isH = false
        end        

        --Message after getting access to move
        if card.ability.extra.energy >= 1 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= 3 and card.ability.extra.stage == 'Butterfree' and card.ability.extra.activem2 == false then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end
        
        ENERGY_RESET(context, card) -- Reset energy at end of round
        

  ---Extra--- 
    end,
    remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.spritex == 12 and card.ability.extra.energy >= 3 then
            G.hand:change_size(-card.ability.extra.h_size)
        end
        if card.ability.extra.stage == 'Metapod' then
                                SMODS.add_card {
                                    key = 'j_pokes_010',
                                    edition = 'e_negative',
                                    stickers = {'perishable'},
                                    force_stickers = true
                                }
        end
    end
}

SMODS.Joker {
    key = "013", --Weedle/Kakuna/Beedrill
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Club',
    cost = 2,
    pos = { x = 13, y = 0 },
    config = { extra = { stage = 'Weedle', stagef = 'Weedle', suit = 'Clubs',         -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 13, energy = 0,                                    -- Which sprite to get for you PKMN?, Current energy
                         activem1 = false, activem2 = false,
                                                                                      -- Extra
                         chips = 30, reT = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club'}
        --Extra
        local stage_key = 'j_pokes_013'
        if card.ability.extra.stage == 'Beedrill' then
            stage_key = 'j_pokes_015'
        elseif card.ability.extra.stage == 'Kakuna' then
            stage_key = 'j_pokes_014'
        end

            return { vars = { card.ability.extra.stage,                                                         --Stage
                                   card.ability.extra.chips, card.ability.extra.reT,    --Extra
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit), --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 1), --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 2), --Move2/Ability
                                            move2                                                               --Move2/Ability
                                }, colours = { HEX('FF0037'), HEX('FFFFFF')},
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
        if context.discard and not context.blueprint and not context.other_card.debuff and
            context.other_card:is_suit(card.ability.extra.suit) then
            card.ability.extra.energy = card.ability.extra.energy + 1
        end

        -- Evolution
        if context.pokes_tag013 and card.ability.extra.stage == 'Weedle' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Kakuna'                                   -- Set current stage
            card.ability.extra.spritex = 14                                           -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.chips = 40                                                   
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message
        elseif context.pokes_tag014 and card.ability.extra.stage == 'Kakuna' then-- custom context
            --Stage 2
            card.ability.extra.stage = 'Beedrill'                                   -- Set current stage
            card.ability.extra.spritex = 15                                           -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.chips = 70                                   
            card.ability.extra.reT = 1

            ease_dollars(20)

            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message     
        end

        if card.ability.extra.energy >= 1 then -- Active with enough energy
            --Moves and Ability
            --Move1
            if context.joker_main then
                return {
                    chips = card.ability.extra.chips
                }
            end
            
            --Move2
            if card.ability.extra.energy >= 2 and not context.blueprint and card.ability.extra.spritex == 15
            and context.repetition and context.cardarea == G.play and context.other_card == context.scoring_hand[1] then
            return { repetitions = card.ability.extra.reT }
            end
        end
        
        --Message after getting access to move
        if card.ability.extra.energy >= 1 and card.ability.extra.activem2 == false then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= 2 and card.ability.extra.stage == 'Beedrill' and card.ability.extra.activem2 == false then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context, card) -- Reset energy at end of round
        

  ---Extra--- 
    end,
}