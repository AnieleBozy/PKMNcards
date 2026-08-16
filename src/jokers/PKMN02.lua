
SMODS.Joker {
    key = "016", --Pidgey/Pidgeotto/Pidgeot
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Normal',
    cost = 3,
    pos = { x = 16, y = 0 },
    config = { extra = { stage = 'Pidgey', stagef = 'Pidgey', suit = 'Normal',         -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 16, energy = 0,                                    -- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         activem1 = false, activem2 = false,
                         mult = 8, bossR = true} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_normal'}
        --Extra
        local stage_key = 'j_pokes_016'
        if card.ability.extra.stage == 'Pidgeotto' then
            stage_key = 'j_pokes_017'
        elseif card.ability.extra.stage == 'Pidgeot' then
            stage_key = 'j_pokes_018'
        end

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                   card.ability.extra.mult,                                          --Extra
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 5),  --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 15), --Move2/Ability
                                            move2                                                                --Move2/Ability
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
        -- Get energy from discards // Normal
        if context.discard and not context.blueprint and not context.other_card.debuff then
            card.ability.extra.energy = card.ability.extra.energy + 1
        end

        -- Evolution
        if context.pokes_tag016 and card.ability.extra.stage == 'Pidgey' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Pidgeotto'                                   -- Set current stage
            card.ability.extra.spritex = 17                                           -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.mult = 12                                           
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message
        elseif context.pokes_tag017 and card.ability.extra.stage == 'Pidgeotto' then-- custom context
            --Stage 2
            card.ability.extra.stage = 'Pidgeot'                                   -- Set current stage
            card.ability.extra.spritex = 18                                           -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra

            --Ability
            for i=1,2 do
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        G.E_MANAGER:add_event(Event({
                            trigger = 'before',
                            delay = 0.0,
                            func = (function()
                                SMODS.add_card {
                                    --set = 'Tarot',
                                    key = 'c_emperor',
                                    key_append = 'pokes_pidgeotto'
                                }
                                G.GAME.consumeable_buffer = 0
                                return true
                            end)
                        }))
                end
            end

            card.ability.extra.mult = 20 
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message     
        end

        
        if card.ability.extra.energy >= 5 then -- Active with enough energy
            --Moves and Ability
            --Move1
            if context.joker_main and not next(context.poker_hands['Pair']) then
                return {
                    mult = card.ability.extra.mult
                }
            end

            --Move2
            if card.ability.extra.energy >= 15 and not context.blueprint and card.ability.extra.spritex == 18 and card.ability.extra.bossR == true then
                card.ability.extra.bossR = false
                if G.jokers.cards and G.jokers.cards[1] and G.jokers.cards[1] == card then
                        G.E_MANAGER:add_event(Event({
                            func = (function()
                                add_tag({ key = 'tag_boss' })
                                play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                                play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                                return true
                            end)
                        }))
                end
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and
        card.ability.extra.spritex == 18 and card.ability.extra.energy >= 15 then
            card.ability.extra.bossR = true
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 5 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= 15 and card.ability.extra.activem2 == false then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end
        
        ENERGY_RESET(context, card) -- Reset energy at end of round
        

  ---Extra--- 
    end,
}

SMODS.Joker {
    key = "019", --Rattata/Raticate
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Normal',
    cost = 4,
    pos = { x = 19, y = 0 },
    config = { extra = { stage = 'Rattata', stagef = 'Rattata', suit = 'Normal',         -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 19, energy = 0,                                    -- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         activem1 = false, activem2 = false,
                         mult = 4, chips = 20} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_normal'}
        --Extra

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                   card.ability.extra.mult, card.ability.extra.chips,                            --Extra
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 2),  --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 3),  --Move2/Ability
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
        -- Get energy from discards // Normal
        if context.discard and not context.blueprint and not context.other_card.debuff then
            card.ability.extra.energy = card.ability.extra.energy + 1
        end

        -- Evolution
        if context.pokes_tag019 and card.ability.extra.stage == 'Rattata' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Raticate'                                     -- Set current stage
            card.ability.extra.spritex = 20                                           -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.mult = 8
            card.ability.extra.chips = 40
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message    
        end

        
        if card.ability.extra.energy >= 2      -- Active with enough energy
           and context.joker_main then
            --Moves and Ability
            --Move2
            if context.joker_main and card.ability.extra.energy >=3 then
                return {
                    chips = card.ability.extra.chips * (# G.consumeables.cards),
                    mult  = card.ability.extra.mult  * ( G.consumeables.config.card_limit - (# (G.consumeables.cards)) )
                }
            else
                --Move1
                return {
                    mult  = card.ability.extra.mult  * ( G.consumeables.config.card_limit - (# (G.consumeables.cards)) )
                }
            end
        end
        --Message after getting access to move
        if card.ability.extra.energy >= 2 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= 3 and card.ability.extra.activem2 == false then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end
        
        ENERGY_RESET(context, card) -- Reset energy at end of round
        

  ---Extra--- 
    end,
}

SMODS.Joker {
    key = "021", --Spearow/Fearow
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Normal',
    cost = 2,
    pos = { x = 21, y = 0 },-- spritex
    config = { extra = { stage = 'Spearow', stagef = 'Spearow', suit = 'Normal',      -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 21, energy = 0,                                    -- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         activem1 = false, activem2 = false,
                         cost = 4, add = 5, lose = 2 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_normal'}
        --Extra
        local stage_key = 'j_pokes_021'
        if card.ability.extra.stage == 'Fearow' then
            stage_key = 'j_pokes_022'
        end

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                card.ability.extra.add, card.ability.extra.lose,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 4),  --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 5),  --Move2
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
        -- Get energy from discards // Normal
        if context.discard and not context.blueprint and not context.other_card.debuff then
            card.ability.extra.energy = card.ability.extra.energy + 1
        end

        -- Evolution
        if context.pokes_tag021 and card.ability.extra.stage == 'Spearow' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Fearow'                                     -- Set current stage
            card.ability.extra.spritex = 22                                           -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message    
        end

        
            --Move1
            if  context.repetition and context.cardarea == G.play and card.ability.extra.energy >= 4
            and next(SMODS.get_enhancements(context.other_card)) == nil
            and context.other_card.seal == nil and context.other_card.edition == nil then
                return { repetitions = 1 }
            end

        --Move2
        if context.discard and not context.blueprint and not context.other_card.debuff and
        context.other_card:get_id() == 2 and card.ability.extra.energy >= 5
        and card.ability.extra.stage == 'Fearow' then
            card.ability.extra.energy = card.ability.extra.energy - card.ability.extra.lose - 1
            for _,v in pairs(G.jokers.cards) do
                if v.ability and v.ability.extra and type(v.ability.extra) == 'table'
                and v.ability.extra.suit == 'Normal' and v.ability.extra.energy
                and v ~= card then
                    v.ability.extra.energy = v.ability.extra.energy + card.ability.extra.add
                    card:juice_up(0.15,0.15)
                end
            end
        end

        --[[Message after getting access to move
        if card.ability.extra.energy >= 4 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end]]
        
        ENERGY_RESET(context, card) -- Reset energy at end of round
        

  ---Extra--- 
    end,
}

SMODS.Joker {
    key = "023", --Ekans/Arbok
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Spade',
    cost = 5,
    pos = { x = 23, y = 0 },-- spritex
    config = { extra = { stage = 'Ekans', stagef = 'Ekans', suit = 'Spades',          -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 23, energy = 0,                                    -- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         activem1 = false,
                         mult = 0, add = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_spade'}
        --Extra

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                   card.ability.extra.mult, card.ability.extra.add,                              --Extra
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 2),  --Move1
                                }, colours = { HEX('FF0037'), HEX('FFFFFF')},
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
        if context.discard and not context.blueprint and not context.other_card.debuff
        and context.other_card:is_suit(card.ability.extra.suit)  then
            card.ability.extra.energy = card.ability.extra.energy + 1
        end

        -- Evolution
        if context.pokes_tag023 and card.ability.extra.stage == 'Ekans' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Arbok'                                     -- Set current stage
            card.ability.extra.spritex = 24                                           -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.add = 2
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message    
        end

        
        if card.ability.extra.energy >= 2 then  -- Active with enough energy
            --Moves
            --Move1
           if context.joker_main and next(context.poker_hands['Flush']) then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.add
           end

        end
        if context.joker_main and card.ability.extra.mult > 0 then
            return { mult = card.ability.extra.mult }
        end

        --Ability
        if context.first_hand_drawn then
            if #G.deck.cards > G.hand.config.card_limit then
            local j = math.min( (#G.deck.cards-G.hand.config.card_limit),4 )
                for i = 1,j,1 do
                    draw_card(G.deck,G.hand)
                end
            end
        end
        
        --Message after getting access to move
        if card.ability.extra.energy >= 2 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        
        ENERGY_RESET(context, card) -- Reset energy at end of round
        

  ---Extra--- 
    end,
}