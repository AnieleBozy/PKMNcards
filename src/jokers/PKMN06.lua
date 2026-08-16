SMODS.Joker {
    key = "060", --Poliwag/Poliwhirl/Poliwrath/Politoed
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Club',
    cost = 6,
    pos = { x = 60, y = 0 },-- spritex
    config = { extra = { stage = 'Poliwag', stagef = 'Poliwag', suit = 'Clubs',       -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 60, spritey = 0, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                      -- Extra
                         add = 1, mult = 0, current = 0, ranks = {1, 1, 2, 3, 5, 8}, rain = 4, skips = 0, max = 5, ranks_skip = {1,1,2,3,5}} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club'}
        --Extra     
        local stage_key = 'j_pokes_060'
        if card.ability.extra.stage == 'Poliwhirl' then
            stage_key = 'j_pokes_061'
        elseif card.ability.extra.stage == 'Poliwrath' then
            stage_key = 'j_pokes_062'
        elseif card.ability.extra.stage == 'Politoed' then
            stage_key = 'j_pokes_062a'
        end

            return { vars = {  card.ability.extra.stage,                                                         --Stage
                            
                                                                                                                 --Extra
                               card.ability.extra.mult, card.ability.extra.add, card.ability.extra.rain,
                               card.ability.extra.ranks[(card.ability.extra.current + 1)], card.ability.extra.ranks_skip[(card.ability.extra.skips + 1)],
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 1),  --Move1
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
        if context.pokes_tag060 and card.ability.extra.stage == 'Poliwag' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Poliwhirl'                                                          -- Set current stage
            card.ability.extra.spritex = 61                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message    
        elseif context.pokes_tag061 and card.ability.extra.stage == 'Poliwhirl' then-- custom context
            -- Stage 2
            card.ability.extra.stage = 'Poliwrath'                                                          -- Set current stage
            card.ability.extra.spritex = 62                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message    
        elseif context.pokes_tag061a  and card.ability.extra.stage == 'Poliwhirl' then-- custom context
            -- Stage 2
            card.ability.extra.stage = 'Politoed'                                                          -- Set current stage
            card.ability.extra.spritex = 62                                                                -- Get proper sprite
            card.ability.extra.spritey = 1
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            card.ability.extra.max = 6
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message    
        end
        
        --Move1
        if context.before and not context.blueprint
        and card.ability.extra.energy >= 1 and card.ability.extra.stage == 'Poliwag'
        and #context.full_hand == 1 then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.add
            return {
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.add } }
            }
        elseif context.before and not context.blueprint
        and card.ability.extra.energy >= 1
        and ( card.ability.extra.stage == 'Poliwhirl' or card.ability.extra.stage == 'Poliwrath' or card.ability.extra.stage == 'Politoed' )
        and #context.full_hand == card.ability.extra.ranks[card.ability.extra.current + 1] then
            card.ability.extra.current = ( card.ability.extra.current + 1 ) % card.ability.extra.max
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.add
            if card.ability.extra.ranks[card.ability.extra.current + 1] == 8 then
                G.hand.config.highlighted_limit = 8
                SMODS.change_play_limit(3)--G.GAME.starting_params.play_limit = 8
            elseif card.ability.extra.ranks[card.ability.extra.current + 1] ~= 8 and G.hand.config.highlighted_limit == 8 then
                G.hand.config.highlighted_limit = 5
                SMODS.change_play_limit(-3)--G.GAME.starting_params.play_limit = 5
            end
            return {
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.add } }
            }
        end

        if context.joker_main and card.ability.extra.mult > 0 then
            return {mult=card.ability.extra.mult}
        end
        
        --Ability1
        if context.skip_blind and card.ability.extra.stage == 'Poliwrath' then
            ease_ante(-1)
            G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
            G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - 1

            G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.ranks_skip[card.ability.extra.skips + 1]
            ease_hands_played(-card.ability.extra.ranks_skip[card.ability.extra.skips + 1])
                G.E_MANAGER:add_event(Event({
                    trigger = after,
                    func = function()
                        if G.GAME.current_round.hands_left <= 0 then
                            G.STATE = G.STATES.GAME_OVER
                            if not G.GAME.won and not G.GAME.seeded and not G.GAME.challenge then
                                G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt = 0
                            end
                            G:save_settings()
                            G.FILE_HANDLER.force = true
                            G.STATE_COMPLETE = false
                        end
                        return true
                    end
                }))
            card.ability.extra.skips = ( card.ability.extra.skips + 1 ) % 3
        end

        --Ability2 
        if context.setting_blind and card.ability.extra.stage == 'Politoed' then
                for _,v in pairs(G.jokers.cards) do
                    if v.ability.extra and type(v.ability.extra) == "table" and v.ability.extra.suit and v.ability.extra.suit == 'Clubs' then
                       v.ability.extra.energy = v.ability.extra.energy + card.ability.extra.rain
                    end
                end 
                return { delay = 0.3, message = ''..card.ability.extra.rain, colour = G.C.SUITS.Clubs } 
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
    remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.stage == 'Politoed' and card.ability.extra.ranks[card.ability.extra.current + 1] == 8 then
                G.hand.config.highlighted_limit = 5
                SMODS.change_play_limit(-3)
        end
    end
}
SMODS.Joker {
    key = "063", --Abra/Kadabra/Alakazam
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Heart',
    cost = 4,
    pos = { x = 63, y = 0 },-- spritex
    config = { extra = { stage = 'Abra', stagef = 'Abra', suit = 'Hearts',       -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 63, spritey = 0, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                      -- Extra
                         odds = 8 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_heart'}
        --Extra     
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'pokes_abra')

            return { vars = {  card.ability.extra.stage,                                                         --Stage
                            
                                                                                                                 --Extra
                               numerator, denominator, 
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 2),  --Move1
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
        if context.pokes_tag063 and card.ability.extra.stage == 'Abra' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Kadabra'                                                            -- Set current stage
            card.ability.extra.spritex = 64                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            card.ability.extra.odds = 4
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message    
        elseif context.pokes_tag064  and card.ability.extra.stage == 'Kadabra' then-- custom context
            -- Stage 2
            card.ability.extra.stage = 'Alakazam'                                                           -- Set current stage
            card.ability.extra.spritex = 65                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            card.ability.extra.odds = 2
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message  
        end
        
        --Move1
        if card.ability.extra.energy >= 2 and context.using_consumeable then
            card.ability.extra.energy = card.ability.extra.energy - 2
            if SMODS.pseudorandom_probability(card, 'pokes_abra', 1, card.ability.extra.odds) then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.0,
                    func = (function()
                            if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                                SMODS.add_card {
                                    set = 'Tarot',
                                }
                                G.GAME.consumeable_buffer = 0
                                card:juice_up()
                            end
                        return true
                    end)
                }))
            end
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 2 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        
        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
}

SMODS.Joker {
    key = "066", --Machop/Machoke/Machamp
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Diamond',
    cost = 4,
    pos = { x = 66, y = 0 },-- spritex
    config = { extra = { stage = 'Machop', stagef = 'Machop', suit = 'Diamonds',       -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 66, spritey = 0, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                      -- Extra
                         chips = 0, add = 1, convert = 0, set = 0 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_diamond'}
        --Extra     
        local stage_key = 'j_pokes_066'
        if card.ability.extra.stage == 'Machoke' then
            stage_key = 'j_pokes_067'
        elseif card.ability.extra.stage == 'Machamp' then
            stage_key = 'j_pokes_068'
        end

            return { vars = {  card.ability.extra.stage,                                                         --Stage
                            
                                                                                                                 --Extra
                                card.ability.extra.chips, card.ability.extra.add,
                                card.ability.extra.set,                                                                          
                                elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                             ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 12), --Move1
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
        if context.pokes_tag066  and card.ability.extra.stage == 'Machop' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Machoke'                                                            -- Set current stage
            card.ability.extra.spritex = 67                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            card.ability.extra.set = 1
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message    
        elseif context.pokes_tag067  and card.ability.extra.stage == 'Machoke' then-- custom context
            -- Stage 2
            card.ability.extra.stage = 'Machamp'                                                           -- Set current stage
            card.ability.extra.spritex = 68                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            card.ability.extra.set = 2                                                                                                            
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message  
        end
        
        --Move1
        if context.hand_drawn and card.ability.extra.energy >= 12 then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.add * (# context.hand_drawn)
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end

        --Ability1
        if context.setting_blind and card.ability.extra.stage ~= 'Machop' then
            card.ability.extra.convert = card.ability.extra.set
            local eval = function() return ( not context.end_of_round and card.ability.extra.convert ~= 0 ) and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
            
        end
        if context.pokes_select and context.pokes_selected.config.card.suit ~= 'Diamonds'
        and card.ability.extra.convert > 0 and card.ability.extra.stage ~= 'Machop' then
            SMODS.change_base(context.pokes_selected, 'Diamonds')
            context.pokes_selected:juice_up(1,1)
            play_sound('tarot1')
            card.ability.extra.convert = card.ability.extra.convert - 1
        end
        

        --Message after getting access to move
        if card.ability.extra.energy >= 12 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        
        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
}

local eaten069 = {}
SMODS.Joker {
    key = "069", --Bellsprout/Weepinbell/Victreebel
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Spade',
    cost = 4,
    pos = { x = 69, y = 0 },-- spritex
    config = { extra = { stage = 'Bellsprout', stagef = 'Bellsprout', suit = 'Spades',       -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 69, spritey = 0, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                      -- Extra
                         cost = 8, last_size = nil, eaten = {}, } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_spade'}
        --Extra     
        local stage_key = 'j_pokes_069'
        if card.ability.extra.stage == 'Victreebel' then
            stage_key = 'j_pokes_071'
        end

            return { vars = {  card.ability.extra.stage,                                                         --Stage
                            
                                                                                                                 --Extra
                                                                                                                                 
                                elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                             ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, card.ability.extra.cost), --Move1
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
        if context.pokes_tag069  and card.ability.extra.stage == 'Bellsprout' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Weepinbell'                                                            -- Set current stage
            card.ability.extra.spritex = 70                                                                -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            card.ability.extra.cost = 4                                                                                                            
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message    
        elseif context.pokes_tag070 and card.ability.extra.stage == 'Weepinbell' then-- custom context
            -- Stage 2
            card.ability.extra.stage = 'Victreebel'                                                           -- Set current stage
            card.ability.extra.spritex = 71                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
                                                                                                            
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message  
        end
        
        if context.discard and not context.blueprint and context.other_card == context.full_hand[#context.full_hand]
        and card.ability.extra.energy >= card.ability.extra.cost then
                if card.ability.extra.last_size == nil then
                   card.ability.extra.last_size = G.GAME.current_round.discards_left
                end
                if card.ability.extra.last_size ~= G.GAME.current_round.discards_left then
                            if card.ability.extra.last_size > G.GAME.current_round.discards_left then
                                G.hand:change_size( -G.GAME.current_round.discards_left + card.ability.extra.last_size + 1 )
                                card.ability.extra.last_size = G.GAME.current_round.discards_left
                            else
                                G.hand:change_size( G.GAME.current_round.discards_left - card.ability.extra.last_size - 1 )
                                card.ability.extra.last_size = G.GAME.current_round.discards_left
                            end    
                else
                    G.hand:change_size( -1 )
                end
                card.ability.extra.last_size = card.ability.extra.last_size - 1
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint
        and card.ability.extra.energy >= card.ability.extra.cost then
            G.hand:change_size(-G.GAME.current_round.discards_left)
            card.ability.extra.last_size = nil
        end  
        
        --Ability
        if context.first_hand_drawn and card.ability.extra.stage == 'Victreebel' then
            local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end

        if context.first_hand_drawn and not context.blueprint and card.ability.extra.stage == 'Victreebel' 
        and card.ability.extra.eaten[1] ~= nil then
            if card.ability.extra.eaten[1] == '"MANUAL_REPLACE"' then
                card.ability.extra.eaten = eaten069
            end

            G.E_MANAGER:add_event(Event({
                func = function()
                        card:juice_up(0.8,0.8)
                        for _,v in pairs(card.ability.extra.eaten) do
                            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                            local _card = copy_card( v , nil, nil, G.playing_card)
                            _card:add_to_deck()
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
                            table.insert(G.playing_cards, _card)   
                            G.hand:emplace(_card)  
                            _card:start_materialize()
                        end
                        SMODS.calculate_context({ playing_card_added = true, cards = card.ability.extra.eaten })
                        card.ability.extra.eaten = {}
                        return true
                end
            }))    
        end  

        if context.discard and not context.blueprint and G.GAME.current_round.discards_used == 0
        and card.ability.extra.stage == 'Victreebel' and not ( context.other_card.ability and context.other_card.ability.scizor ) then
            card.ability.extra.eaten[ # card.ability.extra.eaten + 1 ] = context.other_card
            if context.other_card == context.full_hand[#context.full_hand] then
                eaten069 = card.ability.extra.eaten
            end
            return {
                remove = true
            }
        end

        --Message after getting access to move
        if card.ability.extra.energy >= card.ability.extra.cost and card.ability.extra.activem1 == false then

            --Move1
            G.hand:change_size( G.GAME.current_round.discards_left )

            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
    remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.energy >=card.ability.extra.cost then
            G.hand:change_size(-G.GAME.current_round.discards_left)
        end
    end
}

SMODS.Joker {
    key = "072", --Tentacool/Tentacruel
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Club',
    cost = 4,
    pos = { x = 72, y = 0 },-- spritex
    config = { extra = { stage = 'Tentacool', stagef = 'Tentacool', suit = 'Clubs',                -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 72, spritey = 0, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                                   -- Extra
                         chips = 20, spread = 2 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club'}
        --Extra     
        local stage_key = 'j_pokes_072'
        if card.ability.extra.stage == 'Tentacruel' then
            stage_key = 'j_pokes_073'
        end

            return { vars = {  card.ability.extra.stage,                                                         --Stage
                                                                                                                 --Extra
                                card.ability.extra.chips, card.ability.extra.spread,
                                elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit), --Current energy
                                             ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 2), --Move1
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
        if context.pokes_tag072  and card.ability.extra.stage == 'Tentacool' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Tentacruel'                                                            -- Set current stage
            card.ability.extra.spritex = 73                                                                -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            card.ability.extra.chips = 40                                                                                                            
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message    
        end

        --Move1
        if context.individual and context.cardarea == G.play and
        (context.other_card:get_id() == 10 or context.other_card:get_id() == 8)
        and card.ability.extra.energy >= 2 then
            if card.ability.extra.stage == 'Tentacruel' then
                for _,v in pairs(G.jokers.cards) do
                    if v.ability.extra and type(v.ability.extra) == "table" and v.ability.extra.suit and v.ability.extra.suit == card.ability.extra.suit and not(card == v) then
                        v.ability.extra.energy = v.ability.extra.energy + card.ability.extra.spread
                    end
                end
            return {
                chips = card.ability.extra.chips,
                message = '+', colour = G.C.SUITS.Clubs
            }
            else
                return { chips = card.ability.extra.chips }
            end
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 2 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
}

SMODS.Joker {
    key = "074", --Geodude/Graveler/Golem
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Diamond',
    cost = 4,
    pos = { x = 74, y = 0 },-- spritex
    config = { extra = { stage = 'Geodude', stagef = 'Geodude', suit = 'Diamonds',                    -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 74, spritey = 0, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                                   -- Extra
                         mult1 = {0,0,1}, mult2 = {0,0,0,0,0,0,1,2,3},
                         explode = false, xmult = 1, add = 0.25, jig = false,
                         max = 2, speed = 0.5 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_diamond'}
        --Extra
        
        local r_mults = {}
        for i = 0, card.ability.extra.max do
            r_mults[#r_mults + 1] = tostring(i)
        end
        local el1 = 
            { n = G.UIT.T, config = { text = '  +', colour = G.C.MULT, scale = 0.32 } }
        local el2 =  { n = G.UIT.O, config = { object = DynaText({ string = r_mults, colours = { G.C.RED }, pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = card.ability.extra.speed, scale = 0.32, min_cycle_time = 0 }) } }


        local stage_key = 'j_pokes_074'
        if card.ability.extra.stage == 'Golem' then
            stage_key   = 'j_pokes_076'
        end

            return { vars = {  card.ability.extra.stage,                                                         --Stage
                                                                                                                 --Extra
                                card.ability.extra.xmult, card.ability.extra.add,
                                elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit), --Current energy
                                             ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 3), --Move1
                                             ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 5), --Move2
                                             el1, el2
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
        if context.pokes_tag074 and card.ability.extra.stage == 'Geodude'  then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Graveler'                                                           -- Set current stage
            card.ability.extra.spritex = 75                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            card.ability.extra.max = 4
            card.ability.extra.speed = 0.2 
                                                                                                            
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message  
        elseif context.pokes_tag075  and card.ability.extra.stage == 'Graveler' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Golem'                                                              -- Set current stage
            card.ability.extra.spritex = 76                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
                                                                                                            
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message    
        end

        --Move1
        if context.hand_drawn and card.ability.extra.energy >= 3 then
            local s = 0
            for _,v in pairs(context.hand_drawn) do
                if v:is_suit(card.ability.extra.suit) and not v.debuff and 
                pseudorandom('pokes_geodude_pre', -1, 1) > 0 then
                    local _add = pseudorandom('pokes_geodude', 1, card.ability.extra.max)

                    v.ability.perma_mult = v.ability.perma_mult + _add
                    s = s + _add
                end
            end

            if s > 0 then
                return { message = localize { type = 'variable', key = 'a_mult', vars = { s }  } }
            end
        end

        --Move2
        if context.setting_blind and card.ability.extra.explode == false then
            G.E_MANAGER:add_event(Event({
                blockable = false;
                func = function()
                    card.ability.extra.explode = true      
                    card.ability.extra.jig = false
                return true
                end
            }))
        end
        if card.ability.extra.energy >=5 and card.ability.extra.jig == false then
            local eval = function(card) return context.pokes_select and not G.RESET_JIGGLES end
            juice_card_until(card, eval, false)            
            card.ability.extra.jig = true
        end

        if context.pokes_select and card.ability.extra.explode == true 
        and card.ability.extra.stage == 'Golem' and card.ability.extra.energy >= 5 then
            local rip = {}    
            SMODS.destroy_cards(context.pokes_selected)    
            card.ability.extra.explode = false
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.add

            for _,v in pairs(G.hand.cards) do
                rip[ # rip + 1 ] = v
            end
            for _,v in pairs(G.jokers.cards) do
                if v ~= card then
                    rip[ # rip + 1 ] = v
                end
            end
            for _,v in pairs(G.consumeables.cards) do
                rip[ # rip + 1 ] = v
            end
            
            SMODS.destroy_cards(pseudorandom_element( rip ))
        end
        if card.ability.extra.xmult > 1 and context.joker_main then
            return { xmult = card.ability.extra.xmult  }
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 3 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
}

SMODS.Joker {
    key = "077", --Ponyta/Rapidash
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Heart',
    cost = 4,
    pos = { x = 77, y = 0 },-- spritex
    config = { extra = { stage = 'Ponyta', stagef = 'Ponyta', suit = 'Hearts',                    -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 77, spritey = 0, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                                   -- Extra
                         mult = 10, skip = false, } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_heart'}
        --Extra
        local stage_key = 'j_pokes_077'
        if card.ability.extra.stage == 'Rapidash' then
            stage_key   = 'j_pokes_078'
        end

            return { vars = {  card.ability.extra.stage,                                                         --Stage
                                                                                                                 --Extra
                                card.ability.extra.mult,
                                elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit), --Current energy
                                             ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 1), --Move1
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
        if context.pokes_tag077  and card.ability.extra.stage == 'Ponyta' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Rapidash'                                                           -- Set current stage
            card.ability.extra.spritex = 78                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra

            card.ability.extra.mult = 15
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message
        end

        --Move1
        if context.joker_main and card.ability.extra.energy >= 1 and context.scoring_hand then
            local card1 = context.scoring_hand[1]
            for _,v in pairs(context.scoring_hand) do
                if v ~= card1 then
                    if v.config.card.value ~= card1.config.card.value then
                        return { mult = card.ability.extra.mult }
                    end
                end
            end
        end

        --Ability
        if context.reroll_shop and G.shop_booster and card.ability.extra.stage == 'Rapidash' then -- to do fix reroll_shop
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    func = (function()
                        local i = 0
                            for _, booster in pairs(G.shop_booster.cards) do
                                SMODS.destroy_cards( booster )   
                                i = i+1
                            end
                            for j=1,i,1 do
                                SMODS.add_booster_to_shop()                    
                            end
                        return true
                    end)
                }))
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
    remove_from_deck = function(self, card)
        if card.ability.extra.size ~= nil then
            G.GAME.modifiers.booster_size_mod = card.ability.extra.size
        end
    end
}

SMODS.Joker {
    key = "079", --Slowpoke/Slowbro/Slowking
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Club',
    cost = 6,
    pos = { x = 79, y = 0 },-- spritex
    config = { extra = { stage = 'Slowpoke', stagef = 'Slowpoke', suit = 'Clubs',                    -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 79, spritey = 0, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                                   -- Extra
                         xmult = 1.25, hand = 1, h_size = 5 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club'}
        --Extra
        local stage_key = 'j_pokes_079'
        if card.ability.extra.stage == 'Slowbro' then
            stage_key   = 'j_pokes_080'
        elseif card.ability.extra.stage == 'Slowking' then
            stage_key   = 'j_pokes_080a'
        end
        local remaining = 5 - (card.ability.extra.hand%5)
        if remaining%5 == 0 and card.ability.extra.hand ~= 0 then
            remaining = 'Active!'
        else
            remaining = tostring(remaining)..' remaining'
        end

            return { vars = {  card.ability.extra.stage,                                                         --Stage
                                                                                                                 --Extra
                                card.ability.extra.xmult, remaining, card.ability.extra.h_size,
                                elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit), --Current energy
                                             ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 3), --Move1
                                             ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 4), --Move2
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
        if context.pokes_tag079 and card.ability.extra.stage == 'Slowpoke' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Slowbro'                                                            -- Set current stage
            card.ability.extra.spritex = 80                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra

            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message
        elseif context.pokes_tag079a and card.ability.extra.stage == 'Slowpoke' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Slowking'                                                            -- Set current stage
            card.ability.extra.spritex = 80                                                                 -- Get proper sprite
            card.ability.extra.spritey = 1                                                                 
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra

            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message
        end

        --Move1
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 13
        and card.ability.extra.energy >= 3 then
            return {
                xmult = card.ability.extra.xmult,
            }
        end

        --Ability1
        if context.before and card.ability.extra.stage == 'Slowbro' then
            if (card.ability.extra.hand + 1) % 5 == 0 then
                G.hand:change_size(card.ability.extra.h_size)
            elseif (card.ability.extra.hand + 1) % 5 == 1 and card.ability.extra.hand ~= 1 then
                G.hand:change_size(-card.ability.extra.h_size)
            end
            card.ability.extra.hand = card.ability.extra.hand + 1
        end

        --Move2
        if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:get_id() == 13
        and card.ability.extra.energy >= 4 and card.ability.extra.stage == 'Slowking' then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                return {
                    x_mult = card.ability.extra.xmult
                }
            end
        end
        
        --Message after getting access to move
        if card.ability.extra.energy >= 3 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= 4 and card.ability.extra.activem2 == false then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
    remove_from_deck = function(self, card, from_debuff)
        if (card.ability.extra.hand) % 5 == 0 then
            G.hand:change_size(-card.ability.extra.h_size)
        end
    end
}

SMODS.Joker {
    key = "081", --Magnemite/Magneton
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Spade',
    cost = 3,
    pos = { x = 81, y = 0 },-- spritex
    config = { extra = { stage = 'Magnemite', stagef = 'Magnemite', suit = 'Spades',                    -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 81, spritey = 0, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                                   -- Extra
                         chips = 50 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_spade'}
        --Extra
        local stage_key = 'j_pokes_081'
        if card.ability.extra.stage == 'Magneton' then
            stage_key   = 'j_pokes_082'
        end

            return { vars = {  card.ability.extra.stage,                                                         --Stage
                                                                                                                 --Extra
                                card.ability.extra.chips,
                                elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit), --Current energy
                                             ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 2), --Move1
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
        if context.pokes_tag081  and card.ability.extra.stage == 'Magnemite' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Magneton'                                                            -- Set current stage
            card.ability.extra.spritex = 82                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra

            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message
        end

        --Move1
        if context.joker_main and card.ability.extra.energy >= 2 and context.scoring_hand then
            local card1 = context.scoring_hand[1]
            for _,v in pairs(context.scoring_hand) do
                if v ~= card1 then
                    if v.config.card.suit ~= card1.config.card.suit then
                        return { chips = card.ability.extra.chips }
                    end
                end
            end
        end 

        --Ability
        if card.ability.extra.energy > 0 and card.ability.extra.stage == 'Magneton' then
            local other_joker = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i + 1] end
            end
            if other_joker ~= nil and other_joker.ability.extra and other_joker.ability.extra.energy then
                other_joker.ability.extra.energy = other_joker.ability.extra.energy + card.ability.extra.energy
                card.ability.extra.energy = 0
                return { message = 'Charge' }
            end
        end

        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
}


SMODS.Joker {
    key = "083", --Farfetch'd
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Normal',
    cost = 6,
    pos = { x = 83, y = 0 },-- spritex
    config = { extra = { stage = "Farfetch'd", stagef = "Farfetch'd", suit = 'Normal',                     -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 83, spritey = 0, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                                   -- Extra
                         xmult = 2 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_normal'}
        --Extra

            return { vars = {  card.ability.extra.stage,                                                         --Stage
                                                                                                                 --Extra
                                card.ability.extra.xmult,
                                elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit), --Current energy
                                             ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 11), --Move1
                                }, colours = { HEX('FF0037'), HEX('FFFFFF')},
                            },
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
            --if context.other_card:is_suit(card.ability.extra.suit) then
                card.ability.extra.energy = card.ability.extra.energy + 1
            --end
        end

        --Move1
        if context.joker_main and card.ability.extra.energy >= 11 then
            local is_rank = 0
            local is_suit = 0
            local playsize = # G.play.cards
            if playsize < 2 then
                return { xmult = card.ability.extra.xmult }                
            else
                for i=2,playsize do
                    if is_rank == 0 and G.play.cards[1].config.card.value == G.play.cards[i].config.card.value then
                        is_rank = 1
                    end
                    if is_suit == 0 and G.play.cards[1].config.card.suit == G.play.cards[i].config.card.suit then
                        is_suit = 1
                    end
                    if is_suit + is_rank == 2 then
                        return false
                    end
                end
                return { xmult = card.ability.extra.xmult }
            end
        end

        --Ability
        if context.selling_self then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag({ key = 'tag_juggle' })
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))
            return nil, true
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 11 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
}


SMODS.Joker {
    key = "084", --Doduo/Dodrio
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Normal',
    cost = 3,
    pos = { x = 84, y = 0 },
    config = { extra = { stage = 'Doduo', stagef = 'Doduo', suit = 'Normal',          -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 84, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         chips = 50, ante = true, ante_text = 'Not active' } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_normal'}
        --Extra
        local stage_key = 'j_pokes_084'
        if card.ability.extra.stage == 'Dodrio' then
            stage_key = 'j_pokes_085'
            if card.ability.extra.ante == true then
                card.ability.extra.ante_text = 'Active!'
            else
                card.ability.extra.ante_text = 'Not active'
            end
        end

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                   card.ability.extra.chips, card.ability.extra.ante_text,                                          --Extra
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 5),  --Move1
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
        -- Get energy from discards // Normal
        if context.discard and not context.blueprint and not context.other_card.debuff then
            card.ability.extra.energy = card.ability.extra.energy + 1
        end

        -- Evolution
        if context.pokes_tag084  and card.ability.extra.stage == 'Doduo' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Dodrio'                                       -- Set current stage
            card.ability.extra.spritex = 85                                           -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra
            card.ability.extra.chips = 70                                         
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message
        end

        
            --Move1
            if context.joker_main and not next(context.poker_hands['Pair']) and card.ability.extra.energy >=5 then
                return {
                    chips = card.ability.extra.chips
                }
            end
        
            --Ability
            if context.ante_end and card.ability.extra.ante == false
            and card.ability.extra.stage == 'Dodrio' then
                card.ability.extra.ante = true
                card:juice_up(0.8,0.8)
            end
            if context.selling_card and card.ability.extra.ante == true and context.card.config.center_key ~= 'j_pokes_084'
            and card.ability.extra.stage == 'Dodrio' and context.card.ability.set == 'Joker' then
                card.ability.extra.ante = false
                local _card = copy_card(context.card, nil, nil, nil)
                _card:add_to_deck()
                G.jokers:emplace(_card)
            end

        ENERGY_RESET(context, card) -- Reset energy at end of round
        

        --Message after getting access to move
        if card.ability.extra.energy >= 5 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
  ---Extra--- 
    end,
}

SMODS.Joker {
    key = "086", --Seel/Dewgong
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Club',
    cost = 6,
    pos = { x = 86, y = 0 },
    config = { extra = { stage = 'Seel', stagef = 'Seel', suit = 'Clubs',             -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 86, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         chips = 0, add = 5, } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club'}
        --Extra
        local stage_key = 'j_pokes_086'
        if card.ability.extra.stage == 'Dewgong' then
            stage_key = 'j_pokes_087'
        end

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                   card.ability.extra.chips, card.ability.extra.add,                                          --Extra
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 2),  --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 3),  --Move2
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
        -- Get energy from discards // Normal
        if context.discard and not context.blueprint and not context.other_card.debuff then
            if context.other_card:is_suit(card.ability.extra.suit) then
                card.ability.extra.energy = card.ability.extra.energy + 1
            end
        end

        -- Evolution
        if context.pokes_tag086  and card.ability.extra.stage == 'Seel' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Dewgong'                                       -- Set current stage
            card.ability.extra.spritex = 87                                           -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=0})   -- Set sprite
                                                                                      -- Extra

            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }             -- Message
        end

        
            --Move1
            if context.joker_main and next(context.poker_hands['Straight Flush']) and card.ability.extra.energy >=2 then
                local random_seal = SMODS.poll_seal {key = "pokes_seed", guaranteed = true}
                SMODS.add_card { set = "Playing Card", seal = random_seal }
            end

            --Move2
            if context.individual and context.cardarea == G.play and context.other_card.seal ~= nil and not context.blueprint 
            and card.ability.extra.stage == 'Dewgong' and card.ability.extra.energy >= 3 then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.add
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS,
                message_card = card
            }
            end
            if context.joker_main and card.ability.extra.chips > 0 then
                return { chips = card.ability.extra.chips }
            end

        ENERGY_RESET(context, card) -- Reset energy at end of round
        

        --Message after getting access to move
        if card.ability.extra.energy >= 3 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= 2 and card.ability.extra.activem2 == false then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end
  ---Extra--- 
    end,
}
SMODS.Joker {
    key = "088", --Grimer/Muk
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Spade',
    cost = 6,
    pos = { x = 88, y = 0 },-- spritex
    config = { extra = { stage = 'Grimer', stagef = 'Grimer', suit = 'Spades',                     -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 88, spritey = 0, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                                   -- Extra
                         xmult = 3 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_spade'}
        --Extra     
        local stage_key = 'j_pokes_088'
        if card.ability.extra.stage == 'Muk' then
            stage_key = 'j_pokes_089'
        end

            return { vars = {  card.ability.extra.stage,                                                         --Stage
                            
                                                                                                                 --Extra
                               card.ability.extra.xmult,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 15),  --Move1
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
        if context.pokes_tag088  and card.ability.extra.stage == 'Grimer' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Muk'                                                                -- Set current stage
            card.ability.extra.spritex = 89                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            --card.ability.extra.xmult = 4
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message   
        end

        --Ability1
        if context.first_hand_drawn and card.ability.extra.stage == 'Grimer' then
                G.E_MANAGER:add_event(Event({
                    blockable = false;
                    trigger = 'after',
                    func = function()
                        SMODS.add_card { set = "Base", enhancement = 'm_pokes_psn', area = G.deck  }
                        card:juice_up(0.8,0.8)
                    return true
                    end
                }))
        end

        --Move1
        if context.joker_main and card.ability.extra.energy >= 15 then
            return {xmult = card.ability.extra.xmult}
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 15 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        
        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
}
SMODS.Joker {
    key = "090", --Shellder/Cloyster
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Club',
    cost = 6,
    pos = { x = 90, y = 0 },-- spritex
    config = { extra = { stage = 'Shellder', stagef = 'Shellder', suit = 'Clubs',                     -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 90, spritey = 0, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                                   -- Extra
                         repetitions = 3, card = nil, protect = true } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club'}
        --Extra     
        local stage_key = 'j_pokes_090'
        if card.ability.extra.stage == 'Cloyster' then
            stage_key = 'j_pokes_091'
        end

            return { vars = {  card.ability.extra.stage,                                                         --Stage
                            
                                                                                                                 --Extra
                               card.ability.extra.repetitions,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 4),  --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 10),  --Move2
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
        if context.pokes_tag090  and card.ability.extra.stage == 'Shellder' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Cloyster'                                                                -- Set current stage
            card.ability.extra.spritex = 91                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message   
        end

        --Move1
        if context.before and card.ability.extra.energy >= 4 then
            card.ability.extra.card = pseudorandom_element(context.scoring_hand)
        end
        if context.repetition and context.cardarea == G.play and card.ability.extra.energy >= 4 then
            if context.other_card == card.ability.extra.card then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end

        --Move2
        if context.setting_blind and card.ability.extra.protect == false then
            card.ability.extra.protect = true
            local eval = function(card) return card.ability.extra.protect == true and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.final_scoring_step and card.ability.extra.energy >= 10 and card.ability.extra.stage == 'Cloyster'
        and card.ability.extra.protect == true then
            card.ability.extra.protect = false
            hand_chips = 0
            ease_hands_played(1)
            card:juice_up(0.8,0.8)
            return { message = 'Protect' }
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 4 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= 10 and card.ability.extra.activem2 == false then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end
        
        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
}

SMODS.Joker {
    key = "092", --Gastly/Haunter/Gengar
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Spade',
    cost = 6,
    pos = { x = 92, y = 0 },-- spritex
    config = { extra = { stage = 'Gastly', stagef = 'Gastly', suit = 'Spades',                     -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 92, spritey = 0, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                                   -- Extra
                         chips = 0, add = 1, dead = 0.25 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_spade'}
        --Extra     
        local stage_key = 'j_pokes_092'
        if card.ability.extra.stage == 'Haunter' then
            stage_key = 'j_pokes_093'
        elseif card.ability.extra.stage == 'Gengar' then
            stage_key = 'j_pokes_094'
        end

            return { vars = {  card.ability.extra.stage,                                                         --Stage
                            
                                                                                                                 --Extra
                               card.ability.extra.chips, card.ability.extra.add,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 4),  --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 10),  --Move2
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
        if context.pokes_tag092  and card.ability.extra.stage == 'Gastly' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Haunter'                                                            -- Set current stage
            card.ability.extra.spritex = 93                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message   
        elseif context.pokes_tag093  and card.ability.extra.stage == 'Haunter' then
            -- Stage 2
            card.ability.extra.stage = 'Gengar'                                                             -- Set current stage
            card.ability.extra.spritex = 94                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            card.ability.extra.dead = 0.75
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message 
        end

        --Move1
        if context.discard and not context.blueprint and not context.other_card.debuff and
            context.other_card:is_suit(card.ability.extra.suit) and card.ability.extra.energy >= 5 then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.add
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end

        
        if context.end_of_round and context.game_over and context.main_eval 
        and card.ability.extra.energy >= 10 and card.ability.extra.stage ~= 'Gastly' then
            if G.GAME.chips / G.GAME.blind.chips >= card.ability.extra.dead then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.hand_text_area.blind_chips:juice_up()
                        G.hand_text_area.game_chips:juice_up()
                        play_sound('tarot1')

                        if card.ability.extra.stage == 'Haunter' then
                            SMODS.destroy_cards(card, nil, true)
                        end

                        return true
                    end
                }))
                return {
                    message = 'Life Shaker',
                    saved = 'Life Shaker',
                    colour = G.C.RED
                }
            end
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 4 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= 10 and card.ability.extra.activem2 == false then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end
        
        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
}

SMODS.Joker {
    key = "095", --Onix/Steelix
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Diamond',
    cost = 4,
    pos = { x = 95, y = 0 },-- spritex
    config = { extra = { stage = 'Onix', stagef = 'Onix', suit = 'Diamonds',                       -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 95, spritey = 0, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                                   -- Extra
                         per = 30, xmult = 2 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_diamond'}
        --Extra     
        local stage_key = 'j_pokes_095'
        if card.ability.extra.stage == 'Steelix' then
            stage_key = 'j_pokes_095a'
        end
            local _mult = 0
            if G.jokers and G.jokers.cards then
                for _,v in pairs(G.jokers.cards) do
                    if v.ability.extra and type(v.ability.extra) == "table" and v.ability.extra.suit and v.ability.extra.suit == 'Diamonds' then
                        _mult = _mult + card.ability.extra.per
                    end
                end
            end

            return { vars = {  card.ability.extra.stage,                                                         --Stage
                            
                                                                                                                 --Extra
                               _mult, card.ability.extra.per, card.ability.extra.xmult,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 1),  --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 2), --Move2
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
        if context.pokes_tag095 and card.ability.extra.stage == 'Onix' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Steelix'                                                            -- Set current stage
            card.ability.extra.spritey = 1                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message
        end

        --Move1
        if context.joker_main and card.ability.extra.energy >= 1 then
            local _mult = 0
            for _,v in pairs(G.jokers.cards) do
                if v.ability.extra and type(v.ability.extra) == "table" and v.ability.extra.suit and v.ability.extra.suit == 'Diamonds' then
                    _mult = _mult + card.ability.extra.per
                end
            end
            return {
                chips = _mult
            }
        end

        --Move2
        if context.main_scoring and context.cardarea == G.play and card.ability.extra.energy >=2 then
            SMODS.calculate_context({ steelix = true, })
        end
        if context.individual and context.cardarea == G.play and card.ability.extra.energy >=2
        and (context.other_card.config.center.key == "m_stone" or context.other_card.config.center.key == "m_pokes_stone_brock")
        and card.ability.extra.stage == 'Steelix'
        and not ( context.scoring_name == 'Pair' or context.scoring_name == 'High Card' ) then
            return {
                xmult = card.ability.extra.xmult
            }
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 1 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= 2 and card.ability.extra.activem2 == false and card.ability.extra.stage == 'Steelix' then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end
        
        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
}
SMODS.Joker {
    key = "096", --Drowzee/Hypno
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Heart',
    cost = 6,
    pos = { x = 96, y = 0 },-- spritex
    config = { extra = { stage = 'Drowzee', stagef = 'Drowzee', suit = 'Hearts',                   -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 96, spritey = 0, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                                   -- Extra
                         mult = 0, add = 1, mult2 = 0 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_heart'}
        --Extra     
        local stage_key = 'j_pokes_096'
        if card.ability.extra.stage == 'Hypno' then
            stage_key = 'j_pokes_097'
        end
        
            return { vars = {  card.ability.extra.stage,                                                         --Stage
                            
                                                                                                                 --Extra
                               card.ability.extra.mult, card.ability.extra.add, card.ability.extra.mult2,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 1),  --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 3), --Move2
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
        if context.pokes_tag096 and card.ability.extra.stage == 'Drowzee' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Hypno'                                                              -- Set current stage
            card.ability.extra.spritex = 97                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message
        end

        --Move1
        if context.before and not context.blueprint and card.ability.extra.energy >= 1 then
            local faces = false
            for _, playing_card in ipairs(G.hand.cards) do
                if playing_card:is_face() then
                    faces = true
                    break
                end
            end
            if faces then
                
                local even = true
                if card.ability.extra.stage == 'Hypno' and card.ability.extra.energy >= 6 then
                    even = false
                    for _, playing_card in ipairs(G.hand.cards) do
                        local id = playing_card:get_id()
                        if id <= 10 and id >= 0 and id % 2 == 0 then
                            even = true
                            break
                        end
                    end
                end

                local last_mult = card.ability.extra.mult
                card.ability.extra.mult = 0
                if last_mult > 0 and even then
                    return {
                        message = localize('k_reset')
                    }
                end
            else
                card:juice_up(0.4,0.4)
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.add
            end
        end
        if context.joker_main and card.ability.extra.energy >=3
        and ( card.ability.extra.energy < 6 or not card.ability.extra.stage == 'Hypno' ) then
            return {
                mult = card.ability.extra.mult
            }
        end

        --Move2
        if context.before and not context.blueprint and card.ability.extra.energy >= 3 then
            local even = false
            for _, playing_card in ipairs(G.hand.cards) do
                local id = playing_card:get_id()
                if id <= 10 and id >= 0 and id % 2 == 0 then
                    even = true
                    break
                end
            end
            if even then
                local last_mult = card.ability.extra.mult2
                card.ability.extra.mult2 = 0
                if last_mult > 0 then
                    return {
                        message = localize('k_reset')
                    }
                end
            else
                card:juice_up(0.4,0.4)
                card.ability.extra.mult2 = card.ability.extra.mult2 + card.ability.extra.add
            end
        end
        if context.joker_main and card.ability.extra.energy >=6 then
            return {
                mult = card.ability.extra.mult2 + card.ability.extra.mult
            }
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
SMODS.Joker {
    key = "098", --Krabby/Kingler
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Club',
    cost = 6,
    pos = { x = 98, y = 0 },-- spritex
    config = { extra = { stage = 'Krabby', stagef = 'Krabby', suit = 'Clubs',                      -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 98, spritey = 0, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                                   -- Extra
                          xmult = 2, odds = 4} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club'}
        --Extra     
        local stage_key = 'j_pokes_098'
        if card.ability.extra.stage == 'Kingler' then
            stage_key = 'j_pokes_099'
        end
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'pokes_krabby')
        
            return { vars = {  card.ability.extra.stage,                                                         --Stage
                            
                                                                                                                 --Extra
                               card.ability.extra.xmult, numerator, denominator,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 5),  --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 11),  --Move2
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
        if context.pokes_tag098 and card.ability.extra.stage == 'Kingler' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Kingler'                                                            -- Set current stage
            card.ability.extra.spritex = 99                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message
        end

        --Move1
        if context.joker_main and card.ability.extra.energy >= 5 then
            return { xmult = card.ability.extra.xmult }
        end
        --Ability1
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint
        and card.ability.extra.stage == 'Krabby' then
            if SMODS.pseudorandom_probability(card, 'pokes_krabby', 1, card.ability.extra.odds) then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = 'Guillotine'
                }
            end
        end

        --Move2
        if context.remove_playing_cards and not context.blueprint and
        card.ability.extra.stage == 'Kingler' and card.ability.extra.energy >= 11 then
            G.E_MANAGER:add_event(Event({
                blockable = false;
                trigger = 'after',
                delay = 2,
                func = function()

                local new_cards = {}
                for _, removed_card in ipairs(context.removed) do
                    if removed_card.shattered then 
                        for i=1,2 do
                    
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
                            local _card = copy_card( removed_card , nil, nil, nil)
                            _card:add_to_deck()
                            
                            table.insert(G.playing_cards, _card)   
                            G.hand:emplace(_card)  
                            _card:start_materialize()
                            
                            new_cards[#new_cards + 1] = _card

                        end
                    end
                end
                if new_cards ~= {} then
                    SMODS.calculate_context({ playing_card_added = true, cards = new_cards })
                    card:juice_up(0.8,0.8)
                end
                return true
                end
            }))
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 5 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= 11 and card.ability.extra.activem2 == false and card.ability.extra.stage == 'Kingler' then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end
        
        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
}
SMODS.Joker {
    key = "100", --Voltorb/Electrode
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Diamond',
    cost = 4,
    pos = { x = 100, y = 0 },-- spritex
    config = { extra = { stage = 'Voltorb', stagef = 'Voltorb', suit = 'Diamonds',                  -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 100, spritey = 0, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                                    -- Extra
                          cash = 4} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_diamond'}
        --Extra     
        local stage_key = 'j_pokes_100'
        if card.ability.extra.stage == 'Electrode' then
            stage_key = 'j_pokes_101'
        end
        
            return { vars = {  card.ability.extra.stage,                                                         --Stage
                            
                                                                                                                 --Extra
                               card.ability.extra.cash,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 3),  --Move1
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
        if context.pokes_tag100 and card.ability.extra.stage == 'Voltorb' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Electrode'                                                          -- Set current stage
            card.ability.extra.spritex = 1                                                                  -- Get proper sprite
            card.ability.extra.spritey = 2
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message
        end

        --Move1
        if context.hand_drawn and card.ability.extra.energy >= 3 then
            local faces = 0
            for _,v in pairs(context.hand_drawn) do
                if v:is_face() then
                    faces = faces + 1
                    if faces >= 2 then
                        break
                    end
                end
            end

            if faces >= 2 then
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.cash
                return {
                    dollars = card.ability.extra.cash,
                    delay = 0.45,
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.GAME.dollar_buffer = 0
                                return true
                            end
                        }))
                    end
                }
            end
        end

        --Ability
        if context.first_hand_drawn and card.ability.extra.stage == 'Electrode' then
            local charge = 0
            for _,v in pairs(context.hand_drawn) do
                if v:is_face() then
                    charge = charge + 2
                end
            end
            if charge > 0 then
                local pkmn = {}
                for _,v in pairs(G.jokers.cards) do
                    if v.ability.extra and type(v.ability.extra) == "table" and v.ability.extra.energy and v.ability.extra.suit and v.ability.extra.suit == 'Diamonds' then
                        pkmn[ #pkmn + 1 ] = v
                    end
                end
                if pkmn ~= {} then
                    card:juice_up(0.8,0.8)
                    while charge > 0 do
                        local random_pkmn = pseudorandom_element(pkmn)
                        --print(random_pkmn.ability.extra.stage,random_pkmn.ability.extra.stage,'sss')
                        random_pkmn.ability.extra.energy = random_pkmn.ability.extra.energy + 1
                        charge = charge - 1                        
                    end
                end
            end
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 3 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        
        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
}
SMODS.Joker {
    key = "102", --Exeggcute/Exeggutor
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Club',
    eternal_compat = false,
    cost = 3,
    pos = { x = 2, y = 2 },-- spritex
    config = { extra = { stage = 'Exeggcute', stagef = 'Exeggcute', suit = 'Clubs',                  -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 12, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                                    -- Extra
                          xprice = 2, cost = 3, priced = false, odds = 2 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club'}
        --Extra     
        local stage_key = 'j_pokes_102'
        local numerator, denominator
        if card.ability.extra.stage == 'Exeggutor' then
            stage_key = 'j_pokes_103'
            numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
                'pokes_harvest' .. G.GAME.round_resets.ante)
        end

        local _cost = card.ability.extra.energy
        if card.ability.extra.priced == true then
            _cost = card.ability.extra.cost
        end

        
            return { vars = {  card.ability.extra.stage,                                                         --Stage
                            
                                                                                                                 --Extra
                               card.ability.extra.xprice, numerator, denominator,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(_cost, card.ability.extra.suit, card.ability.extra.cost),--Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 10),--Move2
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
        if context.pokes_tag102 and card.ability.extra.stage == 'Exeggcute' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Exeggutor'                                                          -- Set current stage
            card.ability.extra.spritex = 3                                                                  -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message
        end

        --Move1
        if card.ability.extra.energy >= card.ability.extra.cost and card.ability.extra.priced == false then
            card.ability.extra.priced = true
            card.ability.extra.cost = card.ability.extra.cost * 2
            card.ability.extra_value = card.ability.extra_value + card.ability.extra.xprice
            card.ability.extra.xprice = card.ability.extra.xprice * 2


            card:set_cost()
            return {
                message = localize('k_val_up'),
                colour = G.C.MONEY
            }
        end

        --Move2
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and
            card.ability.extra.stage == 'Exeggutor' and card.ability.extra.energy >= 10
            and (#G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables) and
            G.GAME.last_tarot_planet then
                if SMODS.pseudorandom_probability(card, 'pokes_harvest' .. G.GAME.round_resets.ante, 1, card.ability.extra.odds) then
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            if G.consumeables.config.card_limit > #G.consumeables.cards then
                                play_sound('timpani')
                                SMODS.add_card({ key = G.GAME.last_tarot_planet })
                                card:juice_up(0.3, 0.5)
                            end
                            return true
                        end
                    }))
                    delay(0.6)
                end
        end


        --[[Message after getting access to move
        if card.ability.extra.energy >= 3 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end --]]
        if card.ability.extra.energy >= 10 and card.ability.extra.activem2 == false then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end 
        
        --ENERGY_RESET(context,card)
  ---Extra--- 
    end,
    calc_dollar_bonus = function(self, card)
        card.ability.extra.energy = 0
        card.ability.extra.activem2 = false
            if card.ability.extra.priced == true then
                card.ability.extra.priced = false
            end
    end,
    remove_from_deck = function(self, card, from_debuff) 

        if card then
           if card.sell_cost > 0 then
                card.ability.extra.cost = 3
                card.ability.extra.xprice = 2
                local _self = copy_card(card, nil, nil, nil)
                _self:set_edition()
                _self.ability.extra_value = -1
                _self.ability.extra.energy = 0
                _self:set_cost()
                _self:add_to_deck()
                G.jokers:emplace(_self)
           end 
        end

    end,
}
SMODS.Joker {
    key = "098", --Krabby/Kingler
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Club',
    cost = 6,
    pos = { x = 98, y = 0 },-- spritex
    config = { extra = { stage = 'Krabby', stagef = 'Krabby', suit = 'Clubs',                      -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 98, spritey = 0, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                                   -- Extra
                          xmult = 2, odds = 4} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club'}
        --Extra     
        local stage_key = 'j_pokes_098'
        if card.ability.extra.stage == 'Kingler' then
            stage_key = 'j_pokes_099'
        end
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'pokes_krabby')
        
            return { vars = {  card.ability.extra.stage,                                                         --Stage
                            
                                                                                                                 --Extra
                               card.ability.extra.xmult, numerator, denominator,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 5),  --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 11),  --Move2
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
        if context.pokes_tag098 and card.ability.extra.stage == 'Krabby' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Kingler'                                                            -- Set current stage
            card.ability.extra.spritex = 99                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message
        end

        --Move1
        if context.joker_main and card.ability.extra.energy >= 5 then
            return { xmult = card.ability.extra.xmult }
        end
        --Ability1
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint
        and card.ability.extra.stage == 'Krabby' then
            if SMODS.pseudorandom_probability(card, 'pokes_krabby', 1, card.ability.extra.odds) then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = 'Guillotine'
                }
            end
        end

        --Move2
        if context.remove_playing_cards and not context.blueprint and
        card.ability.extra.stage == 'Kingler' and card.ability.extra.energy >= 11 then
            G.E_MANAGER:add_event(Event({
                blockable = false;
                trigger = 'after',
                delay = 2,
                func = function()

                local new_cards = {}
                for _, removed_card in ipairs(context.removed) do
                    if removed_card.shattered then 
                        for i=1,2 do
                    
                            G.deck.config.card_limit = G.deck.config.card_limit + 1
                            local _card = copy_card( removed_card , nil, nil, nil)
                            _card:add_to_deck()
                            
                            table.insert(G.playing_cards, _card)   
                            G.hand:emplace(_card)  
                            _card:start_materialize()
                            
                            new_cards[#new_cards + 1] = _card

                        end
                    end
                end
                if new_cards ~= {} then
                    SMODS.calculate_context({ playing_card_added = true, cards = new_cards })
                    card:juice_up(0.8,0.8)
                end
                return true
                end
            }))
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 5 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= 11 and card.ability.extra.activem2 == false and card.ability.extra.stage == 'Kingler' then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end
        
        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
}

        local cubone_conf = function(slots)
            if slots > G.consumeables.config.card_limit then return end
            local _cards = #G.consumeables.cards - ( G.consumeables.config.card_limit - slots )
            local removed = 0
            local poz = 0
            if _cards > 0 then
                local i = 0
                local removed = 0
                while i <= _cards - 1 or removed <= _cards - 1 do
                if not ( G.consumeables.cards[ #G.consumeables.cards - i ].edition 
                and G.consumeables.cards[ #G.consumeables.cards - i ].edition.key == 'e_negative' ) then
                    SMODS.destroy_cards( G.consumeables.cards[ #G.consumeables.cards - i ] , nil, nil, true)
                    removed = removed + 1
                end
                i = i+1
                --[[for i=poz,_cards - 1,1 do
                    print( not ( G.consumeables.cards[ #G.consumeables.cards - i ].edition 
                    and G.consumeables.cards[ #G.consumeables.cards - i ].edition.key == 'e_negative' ))
                    if not ( G.consumeables.cards[ #G.consumeables.cards - i ].edition 
                    and G.consumeables.cards[ #G.consumeables.cards - i ].edition.key == 'e_negative' ) then
                        SMODS.destroy_cards( G.consumeables.cards[ #G.consumeables.cards - i ] , nil, nil, true)
                    end
                end]]
                end
            end
            G.consumeables.config.card_limit = G.consumeables.config.card_limit - slots
        end
SMODS.Joker {
    key = "104", --Cubone/Marowak
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Diamond',
    cost = 4,
    pos = { x = 4, y = 2 },-- spritex
    config = { extra = { stage = 'Cubone', stagef = 'Cubone', suit = 'Diamonds',                  -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 4, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                                  -- Extra
                          price = 5, slots = 4} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_diamond'}
        --Extra     
        local stage_key = 'j_pokes_104'
        if card.ability.extra.stage == 'Marowak' then
            stage_key = 'j_pokes_105'
        end
        
            return { vars = {  card.ability.extra.stage,                                                         --Stage
                            
                                                                                                                 --Extra
                               card.ability.extra.price,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 2),  --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 5),  --Move2
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
        if context.pokes_tag104 and card.ability.extra.stage == 'Cubone' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Marowak'                                                          -- Set current stage
            card.ability.extra.spritex = 5                                                                -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message
        end


        --Move1
        if card.ability.extra.energy >=2 and card.ability.extra.activem1 == false then
            G.consumeables.config.card_limit = G.consumeables.config.card_limit + card.ability.extra.slots
            card:juice_up(0.8,0.8)
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint
        and card.ability.extra.energy >= 2 then
            --G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.slots
            cubone_conf(card.ability.extra.slots)
        end

        --Move2
        if card.ability.extra.energy >= 5 and card.ability.extra.activem2 == false
        and card.ability.extra.stage == 'Marowak' then
            local i = false
            for _,v in pairs(G.consumeables.cards) do
                v.ability.extra_value = (v.ability.extra_value or 0) + card.ability.extra.price
                v:set_cost()

                if not i then
                    i = true
                end
            end
            if i then    
                card:juice_up(0.4,0.4)
            end
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 2 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            if card.ability.extra.energy >= 5 and card.ability.extra.stage == 'Marowak' then
                card.ability.extra.activem2 = true                
            end
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= 5 and card.ability.extra.activem2 == false and card.ability.extra.stage == 'Marowak' then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end
        
        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
    remove_from_deck = function(self, card, from_debuff)
        if card.ability.extra.energy >= 2 then
            --G.consumeables.config.card_limit = G.consumeables.config.card_limit - card.ability.extra.slots
            cubone_conf(card.ability.extra.slots)
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        if card.ability.extra.energy > 0 then
            --in case of coping
            card.ability.extra.energy = 0
        end
    end
}
SMODS.Joker {
    key = "106a", --Tyrogue/Hitmonlee/Hitmonchan/Hitmontop
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Diamond',
    cost = 3,
    pos = { x = 6, y = 3 },-- spritex
    config = { extra = { stage = 'Tyrogue', stagef = 'Tyrogue', suit = 'Diamonds',                  -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 6, spritey = 3, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                                  -- Extra
                         select = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_diamond'}
        --Extra     
        local stage_key = 'j_pokes_106a'
        if card.ability.extra.stage == 'Hitmonlee' then
            stage_key = 'j_pokes_106'
        elseif card.ability.extra.stage == 'Hitmonchan' then
            stage_key = 'j_pokes_107'
        elseif card.ability.extra.stage == 'Hitmontop' then
            stage_key = 'j_pokes_107c'
        end
        
            return { vars = {  card.ability.extra.stage,                                                         --Stage
                            
                                                                                                                 --Extra
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 1),  --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 5),  --Move2
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
        if context.pokes_tag106a and card.ability.extra.stage == 'Tyrogue' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Hitmonlee'                                                          -- Set current stage
            card.ability.extra.spritex = 6                                                                  -- Get proper sprite
            card.ability.extra.spritey = 2
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message
        elseif context.pokes_tag106b and card.ability.extra.stage == 'Tyrogue' then
            -- Stage 1
            card.ability.extra.stage = 'Hitmonchan'                                                          -- Set current stage
            card.ability.extra.spritex = 7                                                                  -- Get proper sprite
            card.ability.extra.spritey = 2
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message
        elseif context.pokes_tag106c and card.ability.extra.stage == 'Tyrogue' then
            -- Stage 1
            card.ability.extra.stage = 'Hitmontop'                                                          -- Set current stage
            card.ability.extra.spritex = 7                                                                  -- Get proper sprite
            card.ability.extra.spritey = 3
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message
        end


        if context.setting_blind and card.ability.extra.select == 0 then
            card.ability.extra.select = 1
        end
        if card.ability.extra.energy >= 1 and ( card.ability.extra.stage == 'Tyrogue') and not card.ability.extra.activem1 then
                    local eval = function(card) return card.ability.extra.select == 1 and not G.RESET_JIGGLES end
                    juice_card_until(card, eval, true)
        end
        --Move1
        if context.pokes_select and card.ability.extra.select > 0
        and card.ability.extra.stage == 'Tyrogue' and card.ability.extra.energy >= 1 then
            card.ability.extra.select = 0
            local _rank = pseudorandom_element({-1,1})
            assert(SMODS.modify_rank(context.pokes_selected, _rank))
            card:juice_up(0.8,0.8)
        end

        if card.ability.extra.energy >= 5 and ( card.ability.extra.stage ~= 'Tyrogue') and not card.ability.extra.activem1 then
                    local eval = function(card) return card.ability.extra.select == 1 and not G.RESET_JIGGLES end
                    juice_card_until(card, eval, true)
        end
        --Move1a
        if context.pokes_select and card.ability.extra.stage == 'Hitmonlee' and card.ability.extra.energy >= 5 
        and card.ability.extra.select == 1 then
            card.ability.extra.select = 0
            local _rank = context.pokes_selected:get_id()
            if _rank == '2' then
                assert(SMODS.modify_rank(context.pokes_selected, -1))
            else
                _rank = tostring(math.ceil( tonumber(_rank) / 2))
                local rank_dif = - context.pokes_selected:get_id() + _rank
                assert(SMODS.modify_rank(context.pokes_selected, rank_dif))
            end

            local copies = {}
            for i=1,2 do
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local card_copied = copy_card(context.pokes_selected, nil, nil, G.playing_card)

                card_copied.base.value = _rank

                card_copied:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, card_copied)
                G.hand:emplace(card_copied)
                --card_copied.states.visible = nil

                copies[ # copies + 1 ] = card_copied

                G.E_MANAGER:add_event(Event({
                    func = function()
                        card_copied:start_materialize()
                        return true
                    end  
                }))
            end

                SMODS.destroy_cards(context.pokes_selected, nil, true)
                play_sound('slice1', 0.76 + math.random() * 0.20)
                return {
                    message = 'High Jump Kick',
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                SMODS.calculate_context({ playing_card_added = true, cards = { copies } })
                                return true
                            end
                        }))
                    end
                }
        end

        --Move1b
        if context.before and #context.full_hand == 2 and card.ability.extra.select > 0
        --and next(context.poker_hands['Pair'])
        and card.ability.extra.stage == 'Hitmonchan' and card.ability.extra.energy >= 3 then
            card.ability.extra.select = 0
            local _rank = context.full_hand[2]:get_id() + context.full_hand[1]:get_id()
            if _rank == 28 then
                _rank = 2
            elseif _rank > 14 then
                _rank = _rank - 14 + 1
            end
            --print(context.full_hand[2]:get_id(), context.full_hand[1]:get_id(),_rank)

            local _edition
            if context.full_hand[1].edition or context.full_hand[2].edition then
                if context.full_hand[1].edition and context.full_hand[2].edition then
                    _edition = pseudorandom_element({ context.full_hand[1].edition.key, context.full_hand[2].edition.key })
                elseif context.full_hand[1].edition then
                    _edition = context.full_hand[1].edition.key
                else
                    _edition = context.full_hand[2].edition.key
                end
            end
            local _seal
            if context.full_hand[1].seal or context.full_hand[2].seal then
                if context.full_hand[1].seal and context.full_hand[2].seal then
                    _seal = pseudorandom_element({ context.full_hand[1].seal, context.full_hand[2].seal })
                elseif context.full_hand[1].seal then
                    _seal = context.full_hand[1].seal
                else
                    _seal = context.full_hand[2].seal
                end
            end
            local _enh
            if next(SMODS.get_enhancements(context.full_hand[1])) or next(SMODS.get_enhancements(context.full_hand[2])) then
                if next(SMODS.get_enhancements(context.full_hand[1])) and next(SMODS.get_enhancements(context.full_hand[2])) then
                    _enh = pseudorandom_element({ context.full_hand[1].config.center.key, context.full_hand[2].config.center.key })
                elseif next(SMODS.get_enhancements(context.full_hand[1])) then
                    _enh = context.full_hand[1].config.center.key
                else
                    _enh = context.full_hand[2].config.center.key
                end
            end

            
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local which_copy = pseudorandom_element({context.full_hand[1],context.full_hand[2]})
                local card_copied = copy_card(which_copy, nil, nil, G.playing_card)

                local rank_dif = - which_copy:get_id() + _rank
                if which_copy:get_id() ~= _rank then
                    assert(SMODS.modify_rank(card_copied, rank_dif))
                end
                if _edition then
                    card_copied:set_edition(_edition)
                end 
                if _seal then
                    card_copied:set_seal(_seal)
                end
                if _enh then
                    card_copied:set_ability(_enh)
                end

                card_copied:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, card_copied)
                G.hand:emplace(card_copied)
                card_copied.states.visible = nil

                G.E_MANAGER:add_event(Event({
                    func = function()
                        card_copied:start_materialize()
                        return true
                    end
                }))

                SMODS.destroy_cards(context.full_hand[1], nil, true)
                SMODS.destroy_cards(context.full_hand[2], nil, true)
                play_sound('slice1', 0.76 + math.random() * 0.20)
                return {
                    message = 'Mach Cross',
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                SMODS.calculate_context({ playing_card_added = true, cards = { card_copied } })
                                return true
                            end
                        }))
                    end
                }

        end

        --Move1c
        if context.pokes_select and card.ability.extra.stage == 'Hitmontop'
        and card.ability.extra.energy >=5 and card.ability.extra.select > 0 then
            card.ability.extra.select = 0
            local _rank = context.pokes_selected:get_id()
            local any = false
            for _,v in pairs(G.hand.cards) do
                if v:get_id() ~= _rank then
                    if v:get_id() > _rank then
                      assert(SMODS.modify_rank(v, -1))
                    else
                      assert(SMODS.modify_rank(v, 1))
                    end
                    v:juice_up(0.5,0.5)
                    any = true
                end
            end
            if any then
                play_sound('slice1', 0.76 + math.random() * 0.20)
                return {
                    message = 'Helicoptero', }
            end
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 1 and card.ability.extra.activem1 == false
        and card.ability.extra.stage == 'Tyrogue' then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= 5 and card.ability.extra.activem1 == false
        and (card.ability.extra.stage ~= 'Tyrogue') then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        
        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
}
SMODS.Joker {
    key = "108", -- 	Lickitung
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Normal',
    cost = 4,
    pos = { x = 8, y = 2 },-- spritex
    config = { extra = { stage = 'Lickitung', stagef = 'Lickitung', suit = 'Normal',                  -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 8, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                                  -- Extra
                          chips = 0, add = 5, rank = { rank = 'Ace', id = 14 }} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_normal'}
        --Extra     
        
            return { vars = {  card.ability.extra.stage,                                                         --Stage
                            
                                                                                                                 --Extra
                               card.ability.extra.chips, card.ability.extra.add, card.ability.extra.rank.rank,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 8),  --Move1
                                }, colours = { HEX('FF0037'), HEX('FFFFFF')},
                            }, 
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
                card.ability.extra.energy = card.ability.extra.energy + 1
        end

        --Move1
        if context.before and not context.blueprint and card.ability.extra.energy >= 8 then
            for _,v in pairs(context.scoring_hand) do
               if v:get_id() == card.ability.extra.rank.id then
                 card.ability.extra.chips = 0
                 return { message = localize('k_reset') }
               end 
            end
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.add
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS
            }
        end
        if context.joker_main and card.ability.extra.energy >= 8 and card.ability.extra.chips > 0 then
            return {
                chips = card.ability.extra.chips
            }
        end

        if context.end_of_round then
            card.ability.extra.rank.rank = 'Ace'
            local valid_cards = {}
            for _, playing_card in ipairs(G.playing_cards) do
                if not SMODS.has_no_rank(playing_card) then
                    valid_cards[#valid_cards + 1] = playing_card
                end
            end
            local _card = pseudorandom_element(valid_cards, 'pokes_lick' .. G.GAME.round_resets.ante)
            if _card then
                card.ability.extra.rank.rank = _card.base.value
                card.ability.extra.rank.id = _card.base.id
            end
        end


        --Message after getting access to move
        if card.ability.extra.energy >= 8 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        
        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
}
SMODS.Joker {
    key = "109", --Koffing/Weezing
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Spade',
    cost = 4,
    pos = { x = 9, y = 2 },-- spritex
    config = { extra = { stage = 'Koffing', stagef = 'Koffing', suit = 'Spades',       -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 9, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                      -- Extra
                         cash = 2, odds = 2, cost1 = 5 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_spade'}
        --Extra

            return { vars = {  card.ability.extra.stage,                                                         --Stage
                            
                                                                                                                 --Extra
                               card.ability.extra.cash,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, card.ability.extra.cost1),  --Move1
                                }, colours = { HEX('FF0037'), HEX('FFFFFF')},
                            },
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
        if context.pokes_tag109  and card.ability.extra.stage == 'Koffing' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Weezing'                                                            -- Set current stage
            card.ability.extra.spritex = 10                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            card.ability.extra.cash = 3
            --card.ability.extra.cost1 = 6

            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }  
        end

        --Ability
        if context.selling_self then
            if not((card.edition and card.edition.key == 'e_negative') and (G.jokers and #G.jokers.cards >= G.jokers.config.card_limit) ) then
                local _size = pseudorandom_element( { -1, 1 },'pokes_koffing')
                G.jokers:change_size( _size ) 
                if _size == 1 then _size = '+1' end
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            attention_text({
                                text = _size..' slot',
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
        end

        --Move1
        if card.ability.extra.energy >= card.ability.extra.cost1 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            G.E_MANAGER:add_event(Event({
                trigger = 'before',
                func = function()
                    card:juice_up(0.6,0.6)
                    ease_dollars( G.GAME.current_round.discards_left * card.ability.extra.cash )
                    return true
                end
            }))
        end
        
        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
}

SMODS.Joker {
    key = "111", --Rhyhorn/Rhydon
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Diamond',
    cost = 3,
    pos = { x = 11, y = 2 },-- spritex
    config = { extra = { stage = 'Rhyhorn', stagef = 'Rhyhorn', suit = 'Diamonds',       -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 11, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                      -- Extra
                         add = 1, odds = 15 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_diamond'}
        --Extra
        local stage_key = 'j_pokes_111'
        if card.ability.extra.stage == 'Rhydon' then
            stage_key = 'j_pokes_112'
        end
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'pokes_rhydon')

            return { vars = {  card.ability.extra.stage,                                                         --Stage
                            
                                                                                                                 --Extra
                               card.ability.extra.add, numerator, denominator,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 2),  --Move
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 9),  --Move11
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
        if context.pokes_tag111 and card.ability.extra.stage == 'Rhyhorn' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Rhydon'                                                            -- Set current stage
            card.ability.extra.spritex = 12                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            --card.ability.extra.add = 2

            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }  
        end


        --Move1
        if context.hand_drawn and card.ability.extra.energy >= 2 then
            for _,v in pairs(context.hand_drawn) do
                    
                v.ability.perma_bonus = (v.ability.perma_bonus or 0) +
                    card.ability.extra.add
                --Move2
                if card.ability.extra.stage == 'Rhydon' and card.ability.extra.energy >= 9
                and SMODS.pseudorandom_probability(card, 'pokes_rhydon', 1, card.ability.extra.odds) then
                    card:juice_up(1,1)
                    v.ability.perma_bonus = (v.ability.perma_bonus) * 3
                end
            end
        end
        
        --Message after getting access to move
        if card.ability.extra.energy >= 2 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        --Message after getting access to move
        if card.ability.extra.energy >= 9 and card.ability.extra.activem2 == false and card.ability.extra.stage == 'Rhydon' then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
}

SMODS.Joker {
    key = "113", --Chansey/Blissey
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Normal',
    cost = 4,
    pos = { x = 13, y = 2 },-- spritex
    config = { extra = { stage = 'Chansey', stagef = 'Chansey', suit = 'Normal',       -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 13, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                      -- Extra
                         cash = 5, give = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_normal'}
        --Extra
        local stage_key = 'j_pokes_113'
        if card.ability.extra.stage == 'Blissey' then
            stage_key = 'j_pokes_113a'
        end

            return { vars = {  card.ability.extra.stage,                                                         --Stage
                            
                                                                                                                 --Extra
                               card.ability.extra.cash, card.ability.extra.give,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 1),  --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 3),  --Move11
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
                    card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})
                end
            return true
            end
        }))
    end,

    calculate = function(self, card, context)
        -- Get energy from discards
        if context.discard and not context.blueprint and not context.other_card.debuff then
            --if context.other_card:is_suit(card.ability.extra.suit) then
                card.ability.extra.energy = card.ability.extra.energy + 1
            --end

            --Move2
            if (next(SMODS.get_enhancements(context.other_card))) == nil
            and context.other_card.seal == nil and context.other_card.edition == nil
            and card.ability.extra.stage == 'Blissey' and card.ability.extra.energy >= 3 then
                local pokeD = {}
                for _,v in pairs(G.jokers.cards) do
                    if not(card == v) and v.ability and v.ability.extra and type(v.ability.extra) == "table" and v.ability.extra.energy then
                        pokeD[#pokeD + 1] = v
                    end
                end 
                local randJoker = pseudorandom_element(pokeD)
                if randJoker then
                    randJoker.ability.extra.energy = randJoker.ability.extra.energy + card.ability.extra.give
                    return { delay = 0.4,
                        message = ''..card.ability.extra.give }
                end
            end
        end

        -- Evolution
        if context.pokes_tag113 and card.ability.extra.stage == 'Chansey' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Blissey'                                                            -- Set current stage
            card.ability.extra.spritey = 3                                                                  -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }  
        end

        --Move1
        if context.before and not context.blueprint and card.ability.extra.energy >= 1 then
            local enhanced = {}
            for _, scored_card in ipairs(context.scoring_hand) do
                if next(SMODS.get_enhancements(scored_card)) and not scored_card.debuff and not scored_card.vampired then
                    enhanced[#enhanced + 1] = scored_card
                    scored_card.vampired = true
                    scored_card:set_ability('c_base', nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            scored_card.vampired = nil
                            return true
                        end
                    }))
                end
            end
            if #enhanced > 0 then
                ease_dollars( card.ability.extra.cash * #enhanced )
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


SMODS.Joker {
    key = "114", --Tangela
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Club',
    cost = 4,
    pos = { x = 14, y = 2 },-- spritex
    config = { extra = { stage = 'Tangela', stagef = 'Tangela', suit = 'Clubs',       -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 14, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                      -- Extra
                         cash = 2,} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club'}
        --Extra

            return { vars = {  card.ability.extra.stage,                                                         --Stage
                            
                                                                                                                 --Extra
                               card.ability.extra.cash,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 2),  --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 6),  --Move2
                                }, colours = { HEX('FF0037'), HEX('FFFFFF')},
                            },-- key = stage_key
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

        --Move1
        if #G.jokers.cards  < G.jokers.config.card_limit
        and card.ability.extra.energy >= 2 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            G.E_MANAGER:add_event(Event({
                func = function()
                        SMODS.add_card {
                            set = 'Joker',
                            rarity = 'pokes_Club',
                            key_append = 'pokes_tangela' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                        }
                    return true
                end
            }))
            return {
                message = localize('k_plus_joker'),
                colour = G.C.BLUE,
            }
        end

        --Move2
        if card.ability.extra.energy >= 6 and card.ability.extra.activem2 == false then
            card.ability.extra.activem2 = true
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
            if my_pos and G.jokers.cards[my_pos + 1] then
                G.jokers.cards[my_pos + 1].ability.extra_value = ( G.jokers.cards[my_pos + 1].ability.extra_value or 0 )
                + card.ability.extra.cash
                G.jokers.cards[my_pos + 1]:set_cost()
                return {
                    message = localize('k_val_up'),
                    colour = G.C.MONEY
                }
            end
        end

        ENERGY_RESET(context,card)
  ---Extra--- 
    end,
}
SMODS.Joker {
    key = "115", --Kangaskhan
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Normal',
    cost = 6,
    pos = { x = 15, y = 2 },-- spritex
    config = { extra = { stage = 'Kangaskhan', stagef = 'Kangaskhan', suit = 'Normal',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 15, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         cash = 4,} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_normal'}
        --Extra     
            local _payout = 0
            if G.jokers then
                for _,v in pairs(G.jokers.cards) do
                    if v.ability and v.ability.extra and type(v.ability.extra) == "table" and v.ability.extra.suit and v.ability.extra.suit == 'Normal' then
                        _payout = _payout + card.ability.extra.cash
                    end
                end
            end
            
            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                                                                 --Extra
                                   card.ability.extra.cash, _payout,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 9), --Move1
                                }, colours = { HEX('FF0037'), HEX('FFFFFF')},
                            },
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
        --and context.other_card:is_suit(card.ability.extra.suit) 
        then
                card.ability.extra.energy = card.ability.extra.energy + 1
        end


        --Ability
        if context.first_hand_drawn then
            for _,v in pairs(G.jokers.cards) do
                if v.ability and v.ability.extra and type(v.ability.extra) == "table" and v.ability.extra.energy
                and v ~= card then
                    v.ability.extra.energy = v.ability.extra.energy + 1
                end
            end
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 9 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end

  ---Extra--- 
    end,
    calc_dollar_bonus = function(self, card)
        if card.ability.extra.energy >= 9 then
            card.ability.extra.energy = 0
            card.ability.extra.activem1 = false
            local _payout = 0
            for _,v in pairs(G.jokers.cards) do
                if v.ability and v.ability.extra and type(v.ability.extra) == "table" and v.ability.extra.suit and v.ability.extra.suit == 'Normal' then
                    _payout = _payout + card.ability.extra.cash
                end
            end
            return _payout
        end
        if not ( card.ability.extra.energy == 0 ) then
            card.ability.extra.energy = 0
            card.ability.extra.activem1 = false
        end
    end,
}

SMODS.Joker {
    key = "116", --Horsea/Seadra/Kingdra
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Club',
    cost = 4,
    pos = { x = 16, y = 2 },-- spritex
    config = { extra = { stage = 'Horsea', stagef = 'Horsea', suit = 'Clubs',                -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 16, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy, When move1/move2 active
                                                                                                   -- Extra
                         remove = 1, active = false, first = false,
                        energy2 = 0 } },
    loc_vars = function(self, info_queue, card)

        --Extra     
        local stage_key = 'j_pokes_116'
        if card.ability.extra.stage == 'Seadra' then
            stage_key = 'j_pokes_117'
        elseif card.ability.extra.stage == 'Kingdra' then
            stage_key = 'j_pokes_117a'
            if card.config.center.rarity ~= 'pokes_Dragon' then --after quiting game rarity breaks :/
                card.config.center.rarity = 'pokes_Dragon'
            end
            info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club_diamond'}
        end

        if card.ability.extra.stage ~= 'Kingdra' then  
            info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club'}
        end

            return { vars = {  card.ability.extra.stage,                                                         --Stage
                                                                                                                 --Extra
                                card.ability.extra.chips, card.ability.extra.spread,
                                elements = { DRAGON_CURRENT({card.ability.extra.energy, card.ability.extra.energy2}, {'Clubs','Diamonds'}), --Current energy
                                             ENERGY_MOVE(card.ability.extra.energy, 'Clubs', 4), --Move1
                                             DRAGON_MOVE({card.ability.extra.energy, card.ability.extra.energy2}, {'Clubs','Diamonds'}, {1,2}), --Move2
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
                    card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})
                end
            return true
            end
        }))
    end,

    calculate = function(self, card, context)
        -- Get energy from discards
        if context.discard and not context.blueprint and not context.other_card.debuff then
            if context.other_card:is_suit('Clubs') then
                card.ability.extra.energy = card.ability.extra.energy + 1
            elseif card.ability.extra.stage == 'Kingdra' and context.other_card:is_suit('Diamonds') then
                card.ability.extra.energy2 = card.ability.extra.energy2 + 1
            end
        end

        -- Evolution
        if context.pokes_tag116 and card.ability.extra.stage == 'Horsea' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Seadra'                                                            -- Set current stage
            card.ability.extra.spritex = 17                                                                -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            card.ability.extra.remove = 2                                                                                                            
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message   
        elseif context.pokes_tag117 and card.ability.extra.stage == 'Seadra' then
            -- Stage 2
            card.ability.extra.stage = 'Kingdra'                                                            -- Set current stage
            card.ability.extra.spritey = 3                                                                  -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            card.ability.extra.remove = 3         
            card.ability.extra.suit = 'Dragon'
            card.config.center.rarity = 'pokes_Dragon'
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message 
        end

        --Ability
        if context.first_hand_drawn and card.ability.extra.stage == 'Kingdra' then
            local cards = {}
            for _,v in pairs(context.hand_drawn) do
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local _card = copy_card(v, nil, nil, G.playing_card)
                    _card:add_to_deck()
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, _card)
                    G.hand:emplace(_card)
                    _card:start_materialize()
                    cards[#cards + 1] = _card
            end
            SMODS.calculate_context({ playing_card_added = true, cards = cards })
        end
        --Move2
        if card.ability.extra.stage == 'Kingdra' and card.ability.extra.first
        and context.before and card.ability.extra.energy >= 1 and card.ability.extra.energy2 >= 2 then
            card.ability.extra.first = false
            play_sound('slice1', 0.16 + math.random() * 0.21)
            local cards = {}
            for _,v in pairs(G.play.cards) do
                cards[ # cards + 1 ] = v                
            end
            SMODS.destroy_cards(cards, nil, nil, true)
        end

        --Move1
        if context.before and not context.blueprint and #context.scoring_hand == 5
        and card.ability.extra.active and card.ability.extra.energy >=4 then
            card.ability.extra.active = false
            --[[local cards = {}
            for i=1,card.ability.extra.remove do
                local _card = pseudorandom_element(context.scoring_hand,'pokes_kingdra')
                for v in cards do
                    
                end
                cards[ # cards + 1 ] = _card
            end
            SMODS.destroy_cards(cards, nil, nil, true)--]]
            for i=1,card.ability.extra.remove do
                local _card = pseudorandom_element(context.scoring_hand,'pokes_kingdra')
                SMODS.destroy_cards(_card, nil, nil, true)
            end

            card:juice_up(0.8,0.8)
            play_sound('slice1', 0.16 + math.random() * 0.21)
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 4 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            card.ability.extra.active = true
            local eval = function(card) return card.ability.extra.active == true and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= 1 and card.ability.extra.energy2 >=2 and card.ability.extra.activem2 == false then
            card.ability.extra.first = true
            local eval = function(card) return card.ability.extra.first == true and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
            card.ability.extra.activem2 = true
            local eval = function(card) return card.ability.extra.active == true and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
            return {
            message = localize('k_level_up_ex') }
        end

        if context.end_of_round and card.ability.extra.active == true and card.ability.extra.energy >= 4 then
            card.ability.extra.active = false
        end
        if context.end_of_round and card.ability.extra.first == true and card.ability.extra.energy >= 1
        and card.ability.extra.energy2 >= 4 then
            card.ability.extra.first = false
        end
        DRAGON_RESET(context,card)
  ---Extra--- 
    end,
}
SMODS.Joker {
    key = "118", --Goldeen/Seaking
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Club',
    cost = 5,
    pos = { x = 18, y = 2 },-- spritex
    config = { extra = { stage = 'Goldeen', stagef = 'Goldeen', suit = 'Clubs',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 18, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         xdebt = 2,debt = 0, start = 3, evo = false} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club'}
        --Extra    
        local stage_key = 'j_pokes_118'
        local debt = card.ability.extra.debt
        if card.ability.extra.stage == 'Seaking' then
         stage_key = 'j_pokes_119'
         if card.ability.extra.debt == 0 then
            debt = card.ability.extra.start
         end
        end
            
            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                                                                 --Extra
                                   card.ability.extra.xdebt, debt,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 2), --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 4), --Move2
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
                    card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})
                end
            return true
            end
        }))
    end,

    calculate = function(self, card, context)
        -- Get energy from discards
        if context.discard and not context.blueprint and not context.other_card.debuff
        and context.other_card:is_suit(card.ability.extra.suit) 
        then
                card.ability.extra.energy = card.ability.extra.energy + 1
        end

        -- Evolution
        if context.pokes_tag118 and card.ability.extra.stage == 'Goldeen' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Seaking'                                                            -- Set current stage
            card.ability.extra.spritex = 19                                                                -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra  
            G.GAME.bankrupt_at = G.GAME.bankrupt_at - card.ability.extra.start
            card.ability.extra.evo = true
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message   
        end

        --Move1
        if context.before and not context.blueprint and card.ability.extra.energy >= 2 then
            local sixes = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card:get_id() == 6 then
                    sixes = sixes + 1
                    scored_card:set_ability('m_gold', nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if sixes > 0 then
                return {
                    message = localize('k_gold'),
                    colour = G.C.MONEY
                }
            end
        end

        --Move2
        if context.setting_blind and card.ability.extra.stage == 'Seaking' then
            if card.ability.extra.evo then
                card.ability.extra.evo = false
                card.ability.extra.debt = card.ability.extra.start
                G.GAME.bankrupt_at = G.GAME.bankrupt_at + card.ability.extra.debt
            else
            G.GAME.bankrupt_at = G.GAME.bankrupt_at + card.ability.extra.debt
            card.ability.extra.debt = card.ability.extra.start
            end
            print(G.GAME.bankrupt_at, card.ability.extra.debt)
        end
        if context.individual and context.cardarea == G.play and card.ability.extra.stage == 'Seaking'
        and card.ability.extra.energy >= 4 then
            if SMODS.has_enhancement(context.other_card, "m_gold") then
                card.ability.extra.debt = card.ability.extra.debt * card.ability.extra.xdebt
                context.other_card:juice_up(0.5,0.5)
                --play_sound('holo1', 2.2 + math.random() * 0.5, 0.2)
                    return {
                        message = 'X'..card.ability.extra.xdebt,
                        colour = G.C.MONEY
                    }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint
        and card.ability.extra.stage == 'Seaking' then
            if card.ability.extra.debt then
                G.E_MANAGER:add_event(Event({
                    blockable = false;
                    func = function()
                        G.GAME.bankrupt_at = G.GAME.bankrupt_at - card.ability.extra.debt
                        print(G.GAME.bankrupt_at, card.ability.extra.debt)
                    return true
                    end
                    }))
            end
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 2 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= 4 and card.ability.extra.activem2 == false
        and card.ability.extra.stage == 'Seaking' then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context,card)

  ---Extra--- 
    end,
    remove_from_deck = function(self, card, from_debuff)
        --if card.ability.extra. stage == 'Seaking' then
        --     G.GAME.bankrupt_at =  G.GAME.bankrupt_at + card.ability.extra.start
        --end
        if card.ability.extra.stage == 'Seaking' then
            if card.ability.extra.debt == 0 and card.ability.extra.evo then
                G.GAME.bankrupt_at = G.GAME.bankrupt_at + card.ability.extea.start
            else
                G.GAME.bankrupt_at = G.GAME.bankrupt_at + card.ability.extra.debt
            end
        end
    end
}
SMODS.Joker {
    key = "120", --Staryu/Starmie
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Heart',
    cost = 5,
    pos = { x = 20, y = 2 },-- spritex
    config = { extra = { stage = 'Staryu', stagef = 'Staryu', suit = 'Hearts',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 20, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         mult = 0, add = 1, xmult = 1.25} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_heart'}
        --Extra    
        local stage_key = 'j_pokes_120'
        if card.ability.extra.stage == 'Starmie' then
         stage_key = 'j_pokes_121'
        end
            
            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                                                                 --Extra
                                   card.ability.extra.mult, card.ability.extra.add, card.ability.extra.xmult,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 1), --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 10), --Move2
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
                    card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})
                end
            return true
            end
        }))
    end,

    calculate = function(self, card, context)
        -- Get energy from discards
        if context.discard and not context.blueprint and not context.other_card.debuff
        and context.other_card:is_suit(card.ability.extra.suit) 
        then
                card.ability.extra.energy = card.ability.extra.energy + 1
        end

        -- Evolution
        if context.pokes_tag120 and card.ability.extra.stage == 'Staryu' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Starmie'                                                            -- Set current stage
            card.ability.extra.spritex = 21                                                                -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra  
            card.ability.extra.add = 2
            
                    local pokerHand = pseudorandom_element(SMODS.PokerHands).original_key
                    local level = G.GAME.hands[pokerHand].level
                    SMODS.upgrade_poker_hands({hands = {pokerHand}, level_up = level, from = card})


            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message   
        end

        --Move1
        if G.hand and context.end_of_round-- and context.other_card:get_id() == 5
        and card.ability.extra.energy >= 1 then 
            for _,v in pairs(G.hand.cards) do
                if v:get_id() == 5 then
                    card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.add
                    v:juice_up(0.3,0.3)
                end
            end
                    card:juice_up(0.8,0.8)
        end
        if context.joker_main and card.ability.extra.energy >=1 then
            return {mult = card.ability.extra.mult}
        end

        --Move2
        if context.individual and context.cardarea == G.hand and not context.end_of_round and G.GAME.current_round.hands_left == 0
        and card.ability.extra.energy >= 10 and card.ability.extra.stage == 'Starmie' then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 1 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= 10 and card.ability.extra.activem2 == false
        and card.ability.extra.stage == 'Starmie' then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context,card)

  ---Extra--- 
    end
}
SMODS.Joker {
    key = "122", --Mr. Mime
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Heart',
    cost = 5,
    pos = { x = 22, y = 2 },-- spritex
    config = { extra = { stage = 'Mr. Mime', stagef = 'Mr. Mime', suit = 'Hearts',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 22, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         xmult = 1, add = 0.05,} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_heart'}
        --Extra

        if G.playing_cards and # G.playing_cards > 52 then
            card.ability.extra.xmult = 1 + ( # G.playing_cards - 52 ) * card.ability.extra.add 
        else
            card.ability.extra.xmult = 1
        end
            
            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                                                                 --Extra
                                   card.ability.extra.xmult, card.ability.extra.add,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 4), --Move1
                                }, colours = { HEX('FF0037'), HEX('FFFFFF')},
                            },-- key = stage_key
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
        and context.other_card:is_suit(card.ability.extra.suit) 
        then
                card.ability.extra.energy = card.ability.extra.energy + 1
        end

        --Move1
        if context.individual and context.cardarea == G.hand and not context.end_of_round
        and G.hand and G.hand.cards and G.hand.cards[1] and G.hand.cards[1] == context.other_card and # G.playing_cards > 52
        and card.ability.extra.energy >= 4 then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                card.ability.extra.xmult = 1 + ( # G.playing_cards - 52 ) * card.ability.extra.add 
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 4 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context,card)

  ---Extra--- 
    end
}
SMODS.Joker {
    key = "123", --Scyther/Scizor
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Club',
    cost = 5,
    pos = { x = 23, y = 2 },-- spritex
    config = { extra = { stage = 'Scyther', stagef = 'Scyther', suit = 'Clubs',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 23, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         d = 0,} },
    loc_vars = function(self, info_queue, card)
        --Extra
        local stage_key = 'j_pokes_123'
        if card.ability.extra.stage == 'Scizor' then
            stage_key = 'j_pokes_123a'
            if card.config.center.rarity ~= 'pokes_Spade' then
                card.config.center.rarity = 'pokes_Spade'
            end
            info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_spade'}
        end

        if card.ability.extra.stage ~= 'Scizor' then
            info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club'}
        end

            
            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                                                                 --Extra
                                   card.ability.extra.xmult, card.ability.extra.add,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 3), --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 15), --Move2
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
                    card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})
                end
            return true
            end
        }))
    end,

    calculate = function(self, card, context)
        -- Get energy from discards
        if context.discard and not context.blueprint and not context.other_card.debuff
        and context.other_card:is_suit(card.ability.extra.suit) 
        then
                card.ability.extra.energy = card.ability.extra.energy + 1
        end

        -- Evolution
        if context.pokes_tag123 and card.ability.extra.stage == 'Scyther' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Scizor'                                                            -- Set current stage
            card.ability.extra.spritey = 3                                                                -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra  
            card.ability.extra.suit = 'Spades'
            card.config.center.rarity = 'pokes_Spade'
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message   
        end

        --Move1
        --[[if context.before then
            print(context.scoring_hand[1]:get_id()) 
            for _,v in pairs(context.scoring_hand) do
                SMODS.calculate_context({ other_card = v, discard = true})

                if v:get_seal() == 'Purple' and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = function()
                            SMODS.add_card({ set = 'Tarot' })
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
            end
        end --]]

        
        if context.individual and context.cardarea == G.play and card.ability.extra.energy >= 3 then
            SMODS.calculate_context({ other_card = context.other_card, discard = true, full_hand = context.full_hand})
                if context.other_card:get_seal() == 'Purple' and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        trigger = 'before',
                        delay = 0.0,
                        func = function()
                            SMODS.add_card({ set = 'Tarot' })
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
        end

        if context.pre_discard and card.ability.extra.energy >= 15 and card.ability.extra.stage == 'Scizor' then
            --card.ability.extra.d = card.ability.extra.d + 1
            for _,v in pairs(context.full_hand) do
                if v.ability then v.ability.scizor = true end
                SMODS.calculate_context({ other_card = v, discard = true, full_hand = context.full_hand}) 
                if v.ability then v.ability.scizor = false end
            end           
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 3 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        --Message after getting access to move
        if card.ability.extra.energy >= 15 and card.ability.extra.stage == 'Scizor' and card.ability.extra.activem2 == false then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context,card)

  ---Extra--- 
    end
}
SMODS.Joker {
    key = "124", --Jynx
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Heart',
    cost = 8,
    pos = { x = 24, y = 2 },-- spritex
    config = { extra = { stage = 'Jynx', stagef = 'Jynx', suit = 'Hearts',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 24, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         add = 0.5, adde = 1, card = { rank = 'Ace', id = 14 }} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_heart'}
        --Extra
        local  xmult = 1
            if G.hand and G.hand.highlighted and G.hand.highlighted[1] then
                local _scored = {}
                for _,v in pairs(G.hand.highlighted) do
                    local _continue = false
                    for _,u in pairs(_scored) do
                        if v:get_id() == u:get_id() then
                            _continue = true
                            break
                        end
                    end

                    if not _continue then
                        _scored[# _scored+1] = v
                        for _,u in pairs(G.hand.cards) do

                            if not u.highlighted and v:get_id() == u:get_id() then
                                xmult = xmult + card.ability.extra.add 
                            end
                        end
                    end
                end
            end

            
            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                                                                 --Extra
                                xmult, card.ability.extra.add, card.ability.extra.card.rank, card.ability.extra.adde,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 10), --Move1
                                }, colours = { HEX('FF0037'), HEX('FFFFFF')},
                            },-- key = stage_key
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
        and context.other_card:is_suit(card.ability.extra.suit) 
        then
                card.ability.extra.energy = card.ability.extra.energy + 1
        end

        --Ability
        if context.setting_blind and not context.blueprint then
            local matches = 0
            if G.playing_cards then
                for _, playing_card in ipairs(G.playing_cards) do
                    if playing_card:get_id() == card.ability.extra.card.id then matches = matches + card.ability.extra.adde end
                end
            end
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
            if my_pos and G.jokers.cards[my_pos + 1] and G.jokers.cards[my_pos + 1].ability and G.jokers.cards[my_pos + 1].ability.extra
            and type(G.jokers.cards[my_pos + 1].ability.extra) == 'table' and G.jokers.cards[my_pos + 1].ability.extra.suit
            and G.jokers.cards[my_pos + 1].ability.extra.suit == 'Hearts' and G.jokers.cards[my_pos + 1].ability.extra.energy then
                G.jokers.cards[my_pos + 1].ability.extra.energy = G.jokers.cards[my_pos + 1].ability.extra.energy + matches
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            card.ability.extra.card = { rank = 'Ace', id = 14 }
            local valid_jynx_cards = {}
            for _, playing_card in ipairs(G.playing_cards) do
                if not SMODS.has_no_rank(playing_card) then
                    valid_jynx_cards[#valid_jynx_cards + 1] = playing_card
                end
            end
            local jynx_card = pseudorandom_element(valid_jynx_cards, 'pokes_jynx' .. G.GAME.round_resets.ante)
            if jynx_card then
                card.ability.extra.card.rank = jynx_card.base.value
                card.ability.extra.card.id = jynx_card.base.id
            end
        end

        --Move1
        if context.joker_main and card.ability.extra.energy >= 10 then
            if G.hand and G.hand.cards[1] then
                local xmult = 1
                local _scored = {}
                for _,v in pairs(G.play.cards) do
                    local _continue = false
                    for _,u in pairs(_scored) do
                        if v:get_id() == u:get_id() then
                            _continue = true
                            break
                        end
                    end

                    if not _continue then
                        _scored[# _scored+1] = v
                        for _,u in pairs(G.hand.cards) do
                            if v:get_id() == u:get_id() then
                                xmult = xmult + card.ability.extra.add 
                            end
                        end
                    end
                end

                if xmult > 1 then
                    return { xmult = xmult }
                end
            end
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 10 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context,card)

  ---Extra--- 
    end
}
SMODS.Joker {
    key = "125", --Electabuzz
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Diamond',
    cost = 6,
    pos = { x = 25, y = 2 },-- spritex
    config = { extra = { stage = 'Electabuzz', stagef = 'Electabuzz', suit = 'Diamonds',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 25, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         add = 1, }},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_diamond'}
        --Extra
            
            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                                                                 --Extra
                               card.ability.extra.add,                                                                                  
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 5), --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 10), --Move2
                                }, colours = { HEX('FF0037'), HEX('FFFFFF')},
                            },-- key = stage_key
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
        and context.other_card:is_suit(card.ability.extra.suit) 
        then
                card.ability.extra.energy = card.ability.extra.energy + 1
        end

        --Move1
        if ( context.before or ( context.discard and context.other_card == context.full_hand[#context.full_hand] ) )
        and card.ability.extra.energy >= 5 then
            for _,v in pairs(G.jokers.cards) do
                if v.ability and v.ability.extra and type(v) == 'table' and v.ability.extra.energy then
                    v.ability.extra.energy = v.ability.extra.energy + card.ability.extra.add
                end
            end
        end

        --Move2
        while card.ability.extra.energy >= 10 and G.GAME.last_hand_played
            and (#G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables) do
            card.ability.extra.energy = card.ability.extra.energy - 10
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            if G.consumeables.config.card_limit > #G.consumeables.cards then
                                play_sound('timpani')
                                card:juice_up(0.3, 0.5)
                                
                                    local _planet = nil
                                    for k, v in pairs(G.P_CENTER_POOLS.Planet) do
                                        if v.config.hand_type == G.GAME.last_hand_played then
                                            _planet = v.key
                                        end
                                    end
                                    if _planet then
                                        SMODS.add_card({ key = _planet })
                                    end
                            end
                            return true
                        end
                    }))
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 5 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= 10 and card.ability.extra.activem2 == false then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context,card)

  ---Extra--- 
    end
}
SMODS.Joker {
    key = "126", --Magmar
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Heart',
    cost = 7,
    pos = { x = 26, y = 2 },-- spritex
    config = { extra = { stage = 'Magmar', stagef = 'Magmar', suit = 'Hearts',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 26, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         cash = 1, type = 'face', types = { 'face', 'non-face', 'even', 'odd', 'suit', 'rank' }, card = { rank = 'Ace', suit = 'Hearts', id = 14 }}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_heart'}
        --Extra
            local type = card.ability.extra.type
            if type == 'suit' then
                type = card.ability.extra.card.suit
            elseif type == 'rank' then
                type = card.ability.extra.card.rank
            end
            
            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                                                                 --Extra
                               card.ability.extra.cash, type,                                                                              
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 3), --Move1
                                }, colours = { HEX('FF0037'), HEX('FFFFFF')},
                            },-- key = stage_key
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
        and context.other_card:is_suit(card.ability.extra.suit) 
        then
                card.ability.extra.energy = card.ability.extra.energy + 1
        end

        --Move1
        if card.ability.extra.energy >=3 and
        context.individual and context.cardarea == G.hand and not context.end_of_round then
            local _type = card.ability.extra.type
            local id =  context.other_card:get_id()
            local earn = false
            if _type == 'face' and context.other_card:is_face() then
                earn = true
            elseif _type == 'non-face' and not context.other_card:is_face() then
                earn = true
            elseif _type == 'even' and id <= 10 and id >= 0 and id % 2 == 0 then
                earn = true
            elseif _type == 'odd' and ( (id <= 10 and id >= 0 and id % 2 == 1) or (id == 14) ) then
                earn = true
            elseif _type == 'suit' and context.other_card:is_suit(card.ability.extra.card.suit) then
                earn = true
            elseif _type == 'rank' and context.other_card:get_id() == card.ability.extra.card.id then
                earn = true
            end

            if earn then
                if context.other_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED
                    }
                else
                    G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.cash
                    return {
                        dollars = card.ability.extra.cash,
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
            end
        end

        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
                    card.ability.extra.type = pseudorandom_element(card.ability.extra.types, 'pokes_magmar')
                    card.ability.extra.card = { rank = 'Ace', suit = 'Hearts', id = 14 }
                    local valid_magmar_cards = {}
                    for _, playing_card in ipairs(G.playing_cards) do
                        if not SMODS.has_no_suit(playing_card) and not SMODS.has_no_rank(playing_card) then
                            valid_magmar_cards[#valid_magmar_cards + 1] = playing_card
                        end
                    end
                    local magmar_card = pseudorandom_element(valid_magmar_cards, 'pokes_magmar' .. G.GAME.round_resets.ante)
                    if magmar_card then
                        card.ability.extra.card.rank = magmar_card.base.value
                        card.ability.extra.card.suit = magmar_card.base.suit
                        card.ability.extra.card.id = magmar_card.base.id
                    end
        end
                    
        --Message after getting access to move
        if card.ability.extra.energy >= 3 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context,card)

  ---Extra--- 
    end
}
SMODS.Joker {
    key = "127", --Pinsir
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Club',
    cost = 4,
    pos = { x = 27, y = 2 },-- spritex
    config = { extra = { stage = 'Pinsir', stagef = 'Pinsir', suit = 'Clubs',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 27, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                         -- Extra
                             }},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club'}
        --Extra
            
            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                                                                 --Extra
                                                                                                                 
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 1), --Move1
                                }, colours = { HEX('FF0037'), HEX('FFFFFF')},
                            },-- key = stage_key
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
        and context.other_card:is_suit(card.ability.extra.suit) 
        then
                card.ability.extra.energy = card.ability.extra.energy + 1
        end

        --Move1
        if context.remove_playing_cards and not context.blueprint and card.ability.extra.energy >= 1 then
            card.ability.extra_value = card.ability.extra_value + #(context.removed)
            card:set_cost()
            card:juice_up(0.8,0.8) 
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
    remove_from_deck = function(self, card, from_debuff) 

        if card then
        local value =  card.sell_cost
           if value > 0 then
                local _self = copy_card(card, nil, nil, nil)
                _self:set_edition()
                _self.ability.extra_value = -2
                _self.ability.extra.energy = 0
                _self:set_cost()
                _self:add_to_deck()
                G.jokers:emplace(_self)

                if G.jokers.cards[1] and G.jokers.cards[1].ability and G.jokers.cards[1].ability.extra
                and type(G.jokers.cards[1].ability.extra) == 'table' and G.jokers.cards[1] ~= _self
                and G.jokers.cards[1].ability.extra.energy then
                    G.jokers.cards[1].ability.extra.energy = G.jokers.cards[1].ability.extra.energy + value
                end
           end 
        end
    end,
    }
SMODS.Joker {
    key = "128", --Tauros
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Normal',
    cost = 5,
    pos = { x = 28, y = 2 },-- spritex
    config = { extra = { stage = 'Tauros', stagef = 'Tauros', suit = 'Normal',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 28, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                         -- Extra
                         add = 1, move2 = false    }},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_normal'}
        --Extra
            local chips = 0
            if G.jokers and G.jokers.cards then
            for _,v in pairs(G.jokers.cards) do
                if v.ability and v.ability.extra and type(v.ability.extra) == 'table' and v.ability.extra.energy and v.ability.extra.energy > 0 then
                    chips = chips + v.ability.extra.energy
                end
            end
            end
            
            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                                                                 --Extra
                               chips, card.ability.extra.add,                                                                                  
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 5), --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 10), --Move2
                                }, colours = { HEX('FF0037'), HEX('FFFFFF')},
                            },-- key = stage_key
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
        --and context.other_card:is_suit(card.ability.extra.suit) 
        then
                card.ability.extra.energy = card.ability.extra.energy + 1
        end

        --Move1
        if context.joker_main and card.ability.extra.energy >= 5 then
            local chips = 0
            for _,v in pairs(G.jokers.cards) do
                if v.ability and v.ability.extra and type(v.ability.extra) == 'table' and v.ability.extra.energy and v.ability.extra.energy > 0 then
                    chips = chips + v.ability.extra.energy
                end
            end
            if chips > 0 then
                --chips = chips * card.ability.extra.add
                return { chips = chips }
            end
        end
        
        --Move2
        if G.GAME.current_round.hands_left == 1 and not card.ability.extra.move2
        and card.ability.extra.energy >= 10 then
            card.ability.extra.move2 = true
            if #G.deck.cards > G.hand.config.card_limit then
            local j = math.min( (#G.deck.cards-G.hand.config.card_limit),5 )
                for i = 1,j,1 do
                    draw_card(G.deck,G.hand)
                end
            end
        end
        if context.setting_blind and card.ability.extra.move2 then
            card.ability.extra.move2 = false
        end
                    
        --Message after getting access to move
        if card.ability.extra.energy >= 5 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= 10 and card.ability.extra.activem2 == false then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context,card)

  ---Extra--- 
    end,
    }
SMODS.Joker {
    key = "129", --Magikarp/Gyarados
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Club',
    cost = 4,
    pos = { x = 29, y = 2 },-- spritex
    config = { extra = { stage = 'Magikarp', stagef = 'Magikarp', suit = 'Clubs',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 29, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                         -- Extra
                          repeats = {}, cost = 1 }},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club'}
        --Extra
        local stage_key = 'j_pokes_129'
        if card.ability.extra.stage == 'Gyarados' then
            stage_key = 'j_pokes_130'
        end
            
            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                                                                 --Extra
                                                                                                                 
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, card.ability.extra.cost), --Move1
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
                    card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})
                end
            return true
            end
        }))
    end,

    calculate = function(self, card, context)
        -- Get energy from discards
        if context.discard and not context.blueprint and not context.other_card.debuff
        and context.other_card:is_suit(card.ability.extra.suit) 
        then
                card.ability.extra.energy = card.ability.extra.energy + 1
        end

        -- Evolution
        if context.pokes_tag129 and card.ability.extra.stage == 'Magikarp' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Gyarados'                                                            -- Set current stage
            card.ability.extra.spritex = 30                                                                -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra  
            card.ability.extra.cost = 4
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message   
        end

        --Move1a
        if context.modify_scoring_hand and not context.blueprint and card.ability.extra.stage == 'Magikarp' and card.ability.extra.energy >= 1
        and context.full_hand ~= context.scoring_hand then
            local not_scoring = {}
            for _,v in pairs(context.full_hand) do
                local add = true
                for _,u in pairs(context.scoring_hand) do
                    if u == v then add = false break end
                end
                if add then not_scoring[#not_scoring+1] = v end
            end
            if not_scoring and not_scoring[1] and not_scoring[1] == context.other_card then
                card.ability.extra.repeats[#card.ability.extra.repeats+1] = context.other_card
                return {
                    add_to_hand = true
                }
            end
        end
        --Move1b
        if context.modify_scoring_hand and not context.blueprint and card.ability.extra.stage == 'Gyarados' and card.ability.extra.energy >= 4 then
            local not_scoring = true
            for _,v in pairs(context.scoring_hand) do
                if v == context.other_card then not_scoring = false break end
            end
            if not_scoring then
                card.ability.extra.repeats[#card.ability.extra.repeats+1] = context.other_card
                return {
                    add_to_hand = true
                }
            end
            return {
                add_to_hand = true
            }
        end
        
        if context.repetition and context.cardarea == G.play
        and ( (card.ability.extra.energy >= 1 and card.ability.extra.stage == 'Magikarp')
        or (card.ability.extra.energy >=4 and card.ability.extra.stage == 'Gyarados') ) then
            local _repeat = false
            for _,v in pairs(card.ability.extra.repeats) do
                if v == context.other_card then _repeat = true break end
            end
            if context.other_card == context.full_hand[#context.full_hand] then card.ability.extra.repeats = {} end
            if _repeat then
                return {
                    repetitions = 2
                }
            end
        end
                    
        --Message after getting access to move
        if ( (card.ability.extra.stage == 'Magikarp' and card.ability.extra.energy >= 1)
        or (card.ability.extra.stage == 'Gyarados' and card.ability.extra.energy >= 4) ) and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context,card)

  ---Extra--- 
    end,
}
SMODS.Joker {
    key = "131", --Lapras
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Club',
    cost = 5,
    pos = { x = 31, y = 2 },-- spritex
    config = { extra = { stage = 'Lapras', stagef = 'Lapras', suit = 'Clubs',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 31, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                         -- Extra
                             }},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club'}
        --Extra
            
            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                                                                 --Extra                    
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 2), --Move1
                                }, colours = { HEX('FF0037'), HEX('FFFFFF')},
                            },-- key = stage_key
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
        and context.other_card:is_suit(card.ability.extra.suit) 
        then
                card.ability.extra.energy = card.ability.extra.energy + 1
        end

        --Ability
        if context.before then
            for _,v in pairs(context.full_hand) do
                if v:is_face() then
                    v:set_ability('m_pokes_freeze', nil, true)
                end
            end
        end
        
        --Move1
        if context.repetition and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_pokes_freeze')
        and card.ability.extra.energy >= 2 then
            return { repetitions = 1 }
        end
                    
        --Message after getting access to move
        if card.ability.extra.energy >= 2 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context,card)

  ---Extra--- 
    end,
    }
SMODS.Joker {
    key = "132", --Ditto
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Normal',
    cost = 7,
    pos = { x = 32, y = 2 },-- spritex
    config = { extra = { stage = 'Ditto', stagef = 'Ditto', suit = 'Normal',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 32, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                         -- Extra
                          convert = true   }},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_normal'}
        --Extra
        local ante_text
            if card.ability.extra.convert == true then
               ante_text = 'Active!'
            else
                ante_text = 'Not active'
            end
            
            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                                                                 --Extra        
                                ante_text,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 1), --Move1
                                }, colours = { HEX('FF0037'), HEX('FFFFFF')},
                            },-- key = stage_key
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
        --and context.other_card:is_suit(card.ability.extra.suit) 
        then
                card.ability.extra.energy = card.ability.extra.energy + 1
        end

        --Move1
        if context.ante_change and not card.ability.extra.convert then
            card.ability.extra.convert = true
        end
        if context.before and G.GAME.current_round.hands_played == 0 and #context.full_hand == 1 and card.ability.extra.energy >= 1
        and card.ability.extra.convert then 
            card.ability.extra.convert = false
            local random_edition = SMODS.poll_edition { key = "pokes_seed", guaranteed = true, no_negative = true }
            local _edition
            if random_edition == 'e_foil' then
                _edition = 'm_pokes_ditto_foil'
            elseif random_edition == 'e_holo' then
                _edition = 'm_pokes_ditto_holo'
            else
                _edition = 'm_pokes_ditto_poly'
            end
            context.full_hand[1]:set_ability(_edition, nil, true)
            context.full_hand[1]:juice_up(0.7,0.7)
            play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)            
        end
        if context.first_hand_drawn and not context.blueprint and card.ability.extra.convert then
            local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
                    
        --Message after getting access to move
        if card.ability.extra.energy >= 1 and card.ability.extra.activem1 == false and card.ability.extra.convert then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context,card)

  ---Extra--- 
    end,
    }
SMODS.Joker {
    key = "133", --Eevee
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Normal',
    cost = 4,
    pos = { x = 33, y = 2 },-- spritex
    config = { extra = { stage = 'Eevee', stagef = 'Eevee', suit = 'Normal',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 33, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                         -- Extra
                          rarity = 'pokes_Normal',
                          mult = 2, chips = 22, cost1 = 2, cost2 = 4, move2 = false, --Eevee
                          xmult = 1, add = 0.2, --Vaporeon
                          xmult_jolteon = 2,
                          xmult_umbreon = 1, add_umbreon = 0.05, id = 14, rank = 'Ace'  }},
    loc_vars = function(self, info_queue, card)
        --Extra
        if card.ability.extra.rarity ~= card.config.center.rarity then
            card.config.center.rarity = card.ability.extra.rarity
        end
        local stage_key = 'j_pokes_133'
        if card.ability.extra.stage == 'Vaporeon' then
            stage_key = 'j_pokes_134'
            info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club'}
        elseif card.ability.extra.stage == 'Jolteon' then
            stage_key = 'j_pokes_135'
            info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_diamond'}
        elseif card.ability.extra.stage == 'Flareon' then
            stage_key = 'j_pokes_136'
            info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_heart'}
        elseif card.ability.extra.stage == 'Espeon' then
            stage_key = 'j_pokes_133d'
            info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_heart'}
        elseif card.ability.extra.stage == 'Umbreon' then
            stage_key = 'j_pokes_133e'
            info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_spade'}
        end

        if card.ability.extra.stage == 'Eevee' then    
            info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_normal'}
        end

            
            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                                                                 --Extra   
                               card.ability.extra.mult, card.ability.extra.chips,  
                               card.ability.extra.xmult, card.ability.extra.add,   
                               card.ability.extra.xmult_jolteon,
                               card.ability.extra.xmult_umbreon, card.ability.extra.add_umbreon, card.ability.extra.rank,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, card.ability.extra.cost1), --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, card.ability.extra.cost2), --Move1
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
                    card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})
                end
            return true
            end
        }))
    end,

    calculate = function(self, card, context)
        -- Get energy from discards
        if context.discard and not context.blueprint and not context.other_card.debuff
        and (context.other_card:is_suit(card.ability.extra.suit) or card.ability.extra.stage == 'Eevee' )
        then
                card.ability.extra.energy = card.ability.extra.energy + 1
        end

        -- Evolution
        if context.pokes_tag133a and card.ability.extra.stage == 'Eevee' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Vaporeon'                                                          -- Set current stage
            card.ability.extra.spritex = 34                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra     
            card.ability.extra.suit = 'Clubs'
            card.config.center.rarity = 'pokes_Club'
            card.ability.extra.rarity = 'pokes_Club'
            card.ability.extra.cost1 = 4
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message    
        elseif context.pokes_tag133b and card.ability.extra.stage == 'Eevee' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Jolteon'                                                          -- Set current stage
            card.ability.extra.spritex = 35                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra     
            card.ability.extra.suit = 'Diamonds'
            card.config.center.rarity = 'pokes_Diamond'
            card.ability.extra.rarity = 'pokes_Diamond'
            card.ability.extra.cost1 = 5
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message    
        elseif context.pokes_tag133c and card.ability.extra.stage == 'Eevee' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Flareon'                                                          -- Set current stage
            card.ability.extra.spritex = 36                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra     
            card.ability.extra.suit = 'Hearts'
            card.config.center.rarity = 'pokes_Heart'
            card.ability.extra.rarity = 'pokes_Heart'
            card.ability.extra.cost1 = 2
            card.ability.extra.cost2 = 10
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message    
        elseif context.pokes_tag133d and card.ability.extra.stage == 'Eevee' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Espeon'                                                          -- Set current stage
            card.ability.extra.spritex = 35                                                                 -- Get proper sprite
            card.ability.extra.spritey = 3
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra     
            card.ability.extra.suit = 'Hearts'
            card.config.center.rarity = 'pokes_Heart'
            card.ability.extra.rarity = 'pokes_Heart'
            card.ability.extra.cost1 = 5
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message     
        elseif context.pokes_tag133e and card.ability.extra.stage == 'Eevee' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Umbreon'                                                          -- Set current stage
            card.ability.extra.spritex = 36                                                                 -- Get proper sprite
            card.ability.extra.spritey = 3
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra     
            card.ability.extra.suit = 'Spades'
            card.config.center.rarity = 'pokes_Spade'
            card.ability.extra.rarity = 'pokes_Spade'
            card.ability.extra.cost1 = 10
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message   
        end

        --Eevee
        --Move1
        if context.individual and context.cardarea == G.play and card.ability.extra.energy >= card.ability.extra.cost1
        and card.ability.extra.stage == 'Eevee' then
            local id = context.other_card:get_id()
            if id <= 10 and id >= 0 and id % 2 == 0 then
                return {
                    mult = card.ability.extra.mult,
                    chips = card.ability.extra.chips
                }
            end
        end
        --[[Move2
        if G.GAME.current_round.hands_left == 1 and not card.ability.extra.move2
        and card.ability.extra.energy >= card.ability.extra.cost2 and card.ability.extra.stage == 'Eevee' then
            card.ability.extra.move2 = true
            if #G.deck.cards > G.hand.config.card_limit then
            local j = math.min( (#G.deck.cards-G.hand.config.card_limit),4 )
                for i = 1,j,1 do
                    draw_card(G.deck,G.hand)
                end
            end
        end]]

        --Vaporeon
        --Ability
        if context.skip_blind and not context.blueprint and card.ability.extra.stage == 'Vaporeon' then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag({ key = 'tag_ethereal' })
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))
        end
        --Move1
        if context.ante_change and card.ability.extra.xmult > 1 and card.ability.extra.stage == 'Vaporeon' then
            card.ability.extra.xmult = 1
        end
        if context.using_consumeable and context.consumeable.ability.set == 'Spectral'
        and card.ability.extra.stage == 'Vaporeon' then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.add
        end
        if context.individual and context.cardarea == G.play 
        and card.ability.extra.energy >= card.ability.extra.cost1 and card.ability.extra.stage == 'Vaporeon' then
            local id = context.other_card:get_id()
            if id <= 10 and id >= 0 and id % 2 == 0 then
                return {xmult = card.ability.extra.xmult}
            end
        end

        --Jolteon
        --Move1
        if context.individual and context.cardarea == G.play 
        and card.ability.extra.energy >= card.ability.extra.cost1 and card.ability.extra.stage == 'Jolteon' then
            local id = context.other_card:get_id()
            if id <= 10 and id >= 0 and id % 2 == 0 then
                assert(SMODS.modify_rank(context.other_card, 1))
                return { xmult = card.ability.extra.xmult_jolteon }
            end
        end

        --Flareon
        --Move1
        if context.individual and context.cardarea == G.play 
        and card.ability.extra.energy >= card.ability.extra.cost1 and card.ability.extra.stage == 'Flareon' then
                SMODS.calculate_context({ other_card = context.other_card, cardarea = G.hand, full_hand = context.full_hand,
                scoring_hand = context.scoring_hand, scoring_name = context.scoring_name, poker_hands = context.poker_hands,
                individual = true})
        end
        --Move2
        if context.repetition and context.cardarea == G.hand and (next(context.card_effects[1]) or #context.card_effects > 1)
        and card.ability.extra.stage == 'Flareon' and card.ability.extra.energy >= card.ability.extra.cost2 then
            local id = context.other_card:get_id()
            if id <= 10 and id >= 0 and id % 2 == 0 then
                return {
                    repetitions = 1
                }
            end
        end

        --Espeon
        --Ability
        if context.discard and not context.blueprint and context.other_card == context.full_hand[#context.full_hand]
        and card.ability.extra.stage == 'Espeon' then
            local odd = false
            for _,v in pairs(context.full_hand) do
                local id = v:get_id()
                if (id <= 10 and id >= 0 and id % 2 == 1) or (id <= 14 and id >= 11 ) then
                    odd = true
                    break
                end
            end
            if not odd then
                card:juice_up(0.2,0.2)
                card.ability.extra.energy = card.ability.extra.energy + 2
            end
        end
        --Move1
        if context.repetition and context.cardarea == G.hand and (next(context.card_effects[1]) or #context.card_effects > 1)
        and card.ability.extra.stage == 'Espeon' and card.ability.extra.energy >= card.ability.extra.cost1 
        and G.hand and G.hand.cards and context.other_card == G.hand.cards[1] then
            local _rep = math.floor( ( card.ability.extra.energy ) / 5 )
                return {
                    repetitions = _rep
                }
        end

        --Umbreon
        if context.discard and not context.blueprint and card.ability.extra.stage == 'Umbreon' then
            --Ability
            local id = context.other_card:get_id()
            if id <= 10 and id >= 0 and id % 2 == 0 then
                card.ability.extra.energy = card.ability.extra.energy + 1
                card:juice_up(0.1,0.1)
            end

            --Move1
            if card.ability.extra.energy >= card.ability.extra.cost1 and id == card.ability.extra.id then
                card.ability.extra.id = card.ability.extra.id - 1
                if card.ability.extra.id == 1 then card.ability.extra.id = 14 end
                if card.ability.extra.id == 14 then card.ability.extra.rank = 'Ace'
                elseif card.ability.extra.id == 13 then card.ability.extra.rank = 'King'
                elseif card.ability.extra.id == 12 then card.ability.extra.rank = 'Queen'
                elseif card.ability.extra.id == 11 then card.ability.extra.rank = 'Jack'
                else card.ability.extra.rank = card.ability.extra.id end

                card.ability.extra.xmult_umbreon = card.ability.extra.xmult_umbreon + card.ability.extra.add_umbreon
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult_umbreon } },
                    colour = G.C.RED,
                    delay = 0.30
                }    
            end
        end
        if context.joker_main and card.ability.extra.stage == 'Umbreon' and card.ability.extra.xmult_umbreon > 1 then
            return {xmult=card.ability.extra.xmult_umbreon}
        end

                    
        --Message after getting access to move
        if card.ability.extra.energy >= card.ability.extra.cost1 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= card.ability.extra.cost2 and card.ability.extra.activem2 == false
        and card.ability.extra.stage ~= 'Vaporeon' and card.ability.extra.stage ~= 'Jolteon'
        and card.ability.extra.stage ~= 'Espeon' and card.ability.extra.stage ~= 'Umbreon'
        and card.ability.extra.stage ~= 'Eevee' then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context,card)

  ---Extra--- 
    end,
    }
SMODS.Joker {
    key = "137", --Porygon
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Normal',
    cost = 4,
    pos = { x = 37, y = 2 },-- spritex
    config = { extra = { stage = 'Porygon', stagef = 'Porygon', suit = 'Normal',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 37, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                         -- Extra
                           move1 = false, xcash = 1  }},
    loc_vars = function(self, info_queue, card)
            info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_normal'}
        --Extra
            
            local _active
            if card.ability.extra.energy >= 10 or card.ability.extra.move1 then
                _active = 'Active!'
            else
                _active = 'Not active'
            end

            local stage_key = 'j_pokes_137'
            if card.ability.extra.stage == 'Porygon2' then
                stage_key = 'j_pokes_137a'
            end

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                                                                 --Extra     
                                _active,                                                                                 
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 15), --Move1
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
                    card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})
                end
            return true
            end
        }))
    end,

    calculate = function(self, card, context)
        -- Get energy from discards
        if context.discard and not context.blueprint and not context.other_card.debuff
        --and context.other_card:is_suit(card.ability.extra.suit) 
        then
                card.ability.extra.energy = card.ability.extra.energy + 1
        end

        -- Evolution
        if context.pokes_tag137 and card.ability.extra.stage == 'Porygon' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Porygon2'                                                          -- Set current stage
            card.ability.extra.spritey = 3                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            card.ability.extra.xcash = 2
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message    
        end

        --Move1
        if context.setting_blind and card.ability.extra.move1 then
            card.ability.extra.move1 = false
        end
        if context.ending_shop and card.ability.extra.move1 then
            ease_dollars(G.GAME.current_round.reroll_cost * card.ability.extra.xcash)
        end

           
        --Message after getting access to move
        if card.ability.extra.energy >= 15 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end

        if context.end_of_round and card.ability.extra.energy >= 15 then
            card.ability.extra.move1 = true
        end
        ENERGY_RESET(context,card)

  ---Extra--- 
    end,
    }
SMODS.Joker {
    key = "143", --Snorlax
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Normal',
    cost = 7,
    pos = { x = 43, y = 2 },-- spritex
    config = { extra = { stage = 'Snorlax', stagef = 'Snorlax', suit = 'Normal',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 43, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                         -- Extra
                         xmult = 1, add = 0.1, cash = 2    }},
    loc_vars = function(self, info_queue, card)
            info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_normal'}
        --Extra
            
            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                                                                 --Extra
                              card.ability.extra.xmult, card.ability.extra.add, card.ability.extra.cash,                                                                               
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 5), --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 25), --Move2
                                }, colours = { HEX('FF0037'), HEX('FFFFFF')},
                            },-- key = stage_key
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
        --and context.other_card:is_suit(card.ability.extra.suit) 
        then
                card.ability.extra.energy = card.ability.extra.energy + 1
        end

        --Move1
        if context.using_consumeable and card.ability.extra.energy >=5 then
            ease_dollars(card.ability.extra.cash)
            card:juice_up(1.2,1.2)
        end

        --Move2
        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "pokes_Trainer" then
            card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.add
        end
        if context.joker_main and card.ability.extra.energy >=25 then
            return {xmult = card.ability.extra.xmult}
        end
                    
        --Message after getting access to move
        if card.ability.extra.energy >= 5 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end
        if card.ability.extra.energy >= 25 and card.ability.extra.activem2 == false then
            card.ability.extra.activem2 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context,card)

  ---Extra--- 
    end,
    }
SMODS.Joker {
    key = "144", --Articuno
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Club',
    cost = 8,
    pos = { x = 44, y = 2 },-- spritex
    config = { extra = { stage = 'Articuno', stagef = 'Articuno', suit = 'Clubs',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 43, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                         -- Extra
                         xmult = 1}},
    loc_vars = function(self, info_queue, card)
            info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club'}
        --Extra
            
            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                                                                 --Extra
                              card.ability.extra.xmult,                                                                                
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 31), --Move1
                                }, colours = { HEX('FF0037'), HEX('FFFFFF')},
                            },-- key = stage_key
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
        and context.other_card:is_suit(card.ability.extra.suit) 
        then
                card.ability.extra.energy = card.ability.extra.energy + 1
        end

        --Move1
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 11
        and card.ability.extra.energy >= 31 then
            local xmult = 0
            for _,v in pairs(context.scoring_hand) do
                if v:get_id() ~= 11 then
                    xmult = card.ability.extra.xmult + xmult
                end
            end
            if xmult > 1 then
                return { xmult = xmult }
            end
        end
                    
        --Message after getting access to move
        if card.ability.extra.energy >= 31 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context,card)

  ---Extra--- 
    end,
    }
SMODS.Joker {
    key = "145", --Zapdos
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Diamond',
    cost = 6,
    pos = { x = 45, y = 2 },-- spritex
    config = { extra = { stage = 'Zapdos', stagef = 'Zapdos', suit = 'Diamonds',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 45, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                         -- Extra
                         odds = 2, active = false }},
    loc_vars = function(self, info_queue, card)
            info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_diamond'}
        --Extra
        local _text
            if card.ability.extra.active == true then
                _text = 'Active!'
            else
                _text = 'Not active'
            end
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'pokes_zapdos')
            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                                                                 --Extra
                              denominator, _text, numerator,                                                                            
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 32), --Move1
                                }, colours = { HEX('FF0037'), HEX('FFFFFF')},
                            },-- key = stage_key
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
        and context.other_card:is_suit(card.ability.extra.suit) 
        then
                card.ability.extra.energy = card.ability.extra.energy + 1
        end

        --Move1
        if context.first_hand_drawn and card.ability.extra.active then
            card.ability.extra.active = false
            local already_drawn = {}
            for _,v in pairs(context.hand_drawn) do
                if v:get_id() == 12 then
                    already_drawn[#already_drawn+1] = v
                end
            end

            for _,v in pairs(G.deck.cards) do
                if v:get_id() == 12 and SMODS.pseudorandom_probability(card, 'pokes_zapdos', 1, card.ability.extra.odds) then
                    local draw_to_hand = true
                    for _,u in pairs(already_drawn) do
                        if v == u then draw_to_hand = false break end
                    end

                    draw_card(G.deck, G.hand, 90, 'up', true, v)

                end
            end
        end
        
                    
        --Message after getting access to move
        if card.ability.extra.energy >= 32 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end

        if context.end_of_round then
            if card.ability.extra.energy >=32 then
                card.ability.extra.active = true
            end

            ENERGY_RESET(context,card)
        end

  ---Extra--- 
    end,
    }
SMODS.Joker {
    key = "146", --Moltres
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Heart',
    cost = 8,
    pos = { x = 46, y = 2 },-- spritex
    config = { extra = { stage = 'Moltres', stagef = 'Moltres', suit = 'Hearts',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 46, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                         -- Extra
                         xmult = 3 }},
    loc_vars = function(self, info_queue, card)
            info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_heart'}
        --Extra
            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                                                                 --Extra
                              card.ability.extra.xmult,                                                                            
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 33), --Move1
                                }, colours = { HEX('FF0037'), HEX('FFFFFF')},
                            },-- key = stage_key
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
        and context.other_card:is_suit(card.ability.extra.suit) 
        then
                card.ability.extra.energy = card.ability.extra.energy + 1
        end

        --Move1
        if context.before and card.ability.extra.energy >= 33 then
                local kings = {}
                local to_discard = G.hand.cards
                for _,v in pairs(G.hand.cards) do
                    if v:get_id() == 13 then kings[#kings+1] = v end
                end

                if kings[1] then
                    local j = math.min(#kings, #G.hand.cards)
                    for i=1,j,1 do
                        local selected_card, card_index = pseudorandom_element(to_discard, 'pokes_moltres')
                        G.hand.config.highlighted_limit = G.hand.config.highlighted_limit + 1
                        G.hand:add_to_highlighted(selected_card) 
                        G.FUNCS.discard_cards_from_highlighted(nil, true)      
                        G.hand:remove_from_highlighted(selected_card) 
                        G.hand.config.highlighted_limit = G.hand.config.highlighted_limit - 1  
                        table.remove(to_discard, card_index)          
                    end
                play_sound('timpani') 
                card:juice_up(12.5,2.5)  -- XDDDDDDDD
                end  

        end

        if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:get_id() == 13
        and card.ability.extra.energy >= 33 then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else

                return {
                    x_mult = card.ability.extra.xmult
                }
            end
        end
        
                    
        --Message after getting access to move
        if card.ability.extra.energy >= 33 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context,card)

  ---Extra--- 
    end,
    }
SMODS.Joker {
    key = "147", --Dratini
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Normal', --change to Dragon when more Dragon pkmns
    cost = 6,
    pos = { x = 47, y = 2 },-- spritex
    config = { extra = { stage = 'Dratini', stagef = 'Dratini', suit = 'Normal',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 47, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                         -- Extra
                         odds = 3, repetitions = 1, 
                        energy2 = 0}},
    loc_vars = function(self, info_queue, card)

        if card.ability.extra.stage == 'Dratini' then
            info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_normal'}
        else
            info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_club_diamond'}
        end
        
        --Extra
        local stage_key = 'j_pokes_147'
        if card.ability.extra.stage == 'Dragonair' then
            stage_key = 'j_pokes_148'
        elseif card.ability.extra.stage == 'Dragonite' then
            stage_key = 'j_pokes_149'
        end
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'pokes_dragonite')

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                                                                 --Extra
                              card.ability.extra.repetitions, numerator, denominator,                                                                         
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 4), --Move1
                                            DRAGON_MOVE({card.ability.extra.energy, card.ability.extra.energy2}, {'Clubs','Diamonds'}, {2,2}), --Move1 alt
                                            DRAGON_CURRENT({card.ability.extra.energy, card.ability.extra.energy2}, {'Clubs','Diamonds'}), --Current energy alt
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
                    card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})
                end
            return true
            end
        }))
    end,

    calculate = function(self, card, context)
        -- Get energy from discards
        if context.discard and not context.blueprint and not context.other_card.debuff and card.ability.extra.stage == 'Dratini'
        --and context.other_card:is_suit(card.ability.extra.suit) 
        then
            card.ability.extra.energy = card.ability.extra.energy + 1
        elseif context.discard and not context.blueprint and not context.other_card.debuff
        and context.other_card:is_suit('Clubs') then
            card.ability.extra.energy = card.ability.extra.energy + 1
        end
        if context.discard and not context.blueprint and not context.other_card.debuff and card.ability.extra.stage ~= 'Dratini'
        and context.other_card:is_suit('Diamonds') then
            card.ability.extra.energy2 = card.ability.extra.energy2 + 1
        end

        -- Evolution
        if context.pokes_tag147 and card.ability.extra.stage == 'Dratini' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Dragonair'                                                          -- Set current stage
            card.ability.extra.spritex = 48                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            card.ability.extra.suit = 'Dragon'
            card.config.center.rarity = 'pokes_Dragon'
            card.ability.extra.repetitions = 2
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message
        elseif context.pokes_tag148 and card.ability.extra.stage == 'Dragonair' then-- custom context
            -- Stage 1
            card.ability.extra.stage = 'Dragonite'                                                          -- Set current stage
            card.ability.extra.spritex = 49                                                                 -- Get proper sprite
            card.children.center:set_sprite_pos({x=card.ability.extra.spritex,y=card.ability.extra.spritey})-- Set sprite
                                                                                                            -- Extra
            return { delay = 0.8, message = '^', colour = HEX('83F1F7') }                                   -- Message
        end

        --Move1
        if context.repetition and context.cardarea == G.play 
        and ((card.ability.extra.energy >= 4 and card.ability.extra.stage == 'Dratini')
        or (card.ability.extra.energy >= 2 and card.ability.extra.energy2 >=2) )
        and context.other_card.ability.mail then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end

        --Ability
        if context.modify_shop_card and card.ability.extra.stage == 'Dragonite' then
            G.E_MANAGER:add_event(Event({
            trigger = 'before',
            func = function()
                    if context.card and context.card.edition and context.card.edition.key == 'e_pokes_item'
                    and SMODS.pseudorandom_probability(card, 'pokes_dragonite', 1, card.ability.extra.odds) then
                        local editionless = {'j_pokes_item10', 'j_pokes_item11', 'j_pokes_item12', 'j_pokes_item13',
                                             'j_pokes_item33',}
                        for _,v in pairs(editionless) do
                            if v == context.card.config.center.key then
                                return true
                            end
                        end

                        local rand_roll = pseudorandom('pokes_dragonite_roll',1,40)
                        local edition
                        if rand_roll >= 20 then edition = 'e_pokes_item_foil'
                        elseif rand_roll >= 6 then edition = 'e_pokes_item_holo'
                        elseif rand_roll > 1 then edition = 'e_pokes_item_poly'
                        else edition = 'e_pokes_item_negative' end
                        
                        context.card:set_edition(edition)
                        card:juice_up(0.5,0.5)
                    end
                    return true
            end
            }))   
        end
                    
        --Message after getting access to move
        if ((card.ability.extra.energy >= 4 and card.ability.extra.stage == 'Dratini')
        or (card.ability.extra.energy >=2 and card.ability.extra.energy2 >=2 and card.ability.extra.stage ~= 'Dratini')) 
        and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end

        if context.end_of_round and card.ability.extra.stage == 'Dratini' then
            ENERGY_RESET(context,card)
        elseif context.end_of_round then
            DRAGON_RESET(context,card)
        end

  ---Extra--- 
    end,
    }
SMODS.Joker {
    key = "150", -- Mewtwo
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Heart',
    cost = 8,
    pos = { x = 50, y = 2 },-- spritex
    config = { extra = { stage = 'Mewtwo', stagef = 'Mewtwo', suit = 'Hearts',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 50, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                         activem3 = false,
                         -- ExtraF
                         xmult = 1.5, odds = 2 }},
    loc_vars = function(self, info_queue, card)
            info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_heart'}
        --Extra
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds,
            'pokes_mewtwo1')

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                                                                 --Extra
                              card.ability.extra.xmult, numerator, denominator,                                                                       
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 5), --Move1
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 15), --Move2
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 35), --Move3
                                }, colours = { HEX('FF0037'), HEX('FFFFFF')},
                            },-- key = stage_key
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
        and context.other_card:is_suit(card.ability.extra.suit) 
        then
                card.ability.extra.energy = card.ability.extra.energy + 1
        end

        --Move1
        if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:is_suit("Hearts")
        and SMODS.pseudorandom_probability(card, 'pokes_mewtwo1', 1, card.ability.extra.odds)
        and card.ability.extra.energy >= 5 then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                return {
                    x_mult = card.ability.extra.xmult
                }
            end
        end
        
        --Move2
        if context.repetition and context.cardarea == G.hand and (next(context.card_effects[1]) or #context.card_effects > 1)
        and SMODS.pseudorandom_probability(card, 'pokes_mewtwo2', 1, card.ability.extra.odds)
        and card.ability.extra.energy >= 15 then
            return {
                repetitions = 1
            }
        end

        --Move3
        if context.other_consumeable and SMODS.pseudorandom_probability(card, 'pokes_mewtwo3', 1, card.ability.extra.odds)
        and card.ability.extra.energy >= 35 then
            return {
                x_mult = card.ability.extra.xmult,
                message_card = context.other_consumeable
            }
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
        if card.ability.extra.energy >= 35 and card.ability.extra.activem3 == false then
            card.ability.extra.activem3 = true
            return {
            message = localize('k_level_up_ex') }
        end

        if context.end_of_round then
            if card.ability.extra.activem3 then card.ability.extra.activem3 = false end
            ENERGY_RESET(context,card)
        end

  ---Extra--- 
    end,
}
SMODS.Joker {
    key = "151", -- Mew
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Heart',
    cost = 5,
    pos = { x = 51, y = 2 },-- spritex
    config = { extra = { stage = 'Mew', stagef = 'Mew', suit = 'Hearts',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 51, spritey = 2, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                         -- ExtraF
                         energymew = 0, repetitions = 1 }},
    loc_vars = function(self, info_queue, card)
        --Extra
            local _energy = 0
            if G.jokers and G.jokers.cards then
                for _,v in pairs(G.jokers.cards) do
                    if v.ability and v.ability.extra and type(v.ability.extra) == 'table' and v.ability.extra.energy
                    and v ~= card then
                        _energy = _energy + v.ability.extra.energy
                    end
                end
            end

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                                                                 --Extra
                              card.ability.extra.repetitions,                                                                       
                               elements = { ENERGY_CURRENT(_energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(_energy, card.ability.extra.suit, 30), --Move1
                                }, colours = { HEX('FF0037'), HEX('FFFFFF')},
                            },-- key = stage_key
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
        --[[ Get energy from discards
        if context.discard and not context.blueprint and not context.other_card.debuff
        and context.other_card:is_suit(card.ability.extra.suit) 
        then
                card.ability.extra.energy = card.ability.extra.energy + 1
        end]]



        --Move1
        if context.repetition and context.cardarea == G.hand and (next(context.card_effects[1]) or #context.card_effects > 1) then
            local _energy = 0
            for _,v in pairs(G.jokers.cards) do
                if v.ability and v.ability.extra and type(v.ability.extra) == 'table' and v.ability.extra.energy
                and v ~= card then
                    _energy = _energy + v.ability.extra.energy
                end
            end
            if _energy >= 30 then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
                    
        --[[Message after getting access to move
        if card.ability.extra.energymew >= 30 and card.ability.extra.activem1 == false then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end

            ENERGY_RESET(context,card)]]

  ---Extra--- 
    end,
}
    
    
    
    
    
    
    
    
    