SMODS.Joker {
    key = "025baby", --Pichu
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Diamond',
    cost = 2,
    pos = { x = 25, y = 1 },-- spritex
    config = { extra = { stage = 'Pichu', stagef = 'Pichu', suit = 'Diamonds',        -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 25, spritey = 1, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         baby = 0, cash = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_baby'}
        --Extra

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                   card.ability.extra.cash,                              --Extra
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.baby, 'Baby', 1),  --Move1
                                },  colours = { HEX('FF0037'), HEX('FFFFFF')},
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

        if context.discard and context.other_card == context.full_hand[#context.full_hand] then
            ease_dollars(card.ability.extra.cash)
        end
        
        if context.setting_blind then
            card.ability.extra.baby = 1
        end
        if context.end_of_round then
            card.ability.extra.baby = 0
        end
        ENERGY_RESET(context, card) -- Reset energy at end of round
        

  ---Extra--- 
    end,
}--[[
SMODS.Joker {
    key = "106baby", --Tyrogue
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Diamond',
    cost = 2,
    pos = { x = 6, y = 3 },-- spritex
    config = { extra = { stage = 'Tyrogue', stagef = 'Tyrogue', suit = 'Diamonds',        -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 6, spritey = 3, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         baby = 0, rank = 2 } },
    loc_vars = function(self, info_queue, card)
        --Extra

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                 --Extra
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.baby, 'Baby', 1),  --Move1
                                },  colours = { HEX('FF0037'), HEX('FFFFFF')},
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
        if context.joker_main then
            return { mult = 5 }
        end
        
        if context.setting_blind then
            card.ability.extra.baby = 1
        end
        if context.end_of_round then
            card.ability.extra.baby = 0
        end
        ENERGY_RESET(context, card) -- Reset energy at end of round

  ---Extra--- 
    end,
}]]

SMODS.Joker {
    key = "035baby", --Cleffa
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Heart',
    cost = 2,
    pos = { x = 36, y = 1 },-- spritex
    config = { extra = { stage = 'Cleffa', stagef = 'Cleffa', suit = 'Hearts',        -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 36, spritey = 1, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         baby = 0} },
    loc_vars = function(self, info_queue, card)
        --Extra
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_baby'}

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                  --Extra
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.baby, 'Baby', 1),  --Move1
                                },  colours = { HEX('FF0037'), HEX('FFFFFF')},
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

        if context.setting_blind then
            card.ability.extra.baby = 1
                    local pokerHand = pseudorandom_element(SMODS.PokerHands).original_key
                    SMODS.upgrade_poker_hands({hands = {pokerHand}, level_up = card.ability.extra.lvlup, from = card})
        end
        if context.end_of_round then
            card.ability.extra.baby = 0
        end
        ENERGY_RESET(context, card) -- Reset energy at end of round

  ---Extra--- 
    end,
}
SMODS.Joker {
    key = "039baby", --Igglybuff
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Heart',
    cost = 2,
    pos = { x = 35, y = 1 },-- spritex
    config = { extra = { stage = 'Igglybuff', stagef = 'Igglybuff', suit = 'Hearts',        -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 35, spritey = 1, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         baby = 0, rank = 1 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_baby'}
        --Extra

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                 --Extra
                                card.ability.extra.rank,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.baby, 'Baby', 1),  --Move1
                                },  colours = { HEX('FF0037'), HEX('FFFFFF')},
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

        if context.hand_drawn then
            if context.hand_drawn[1] then
                local lowid = context.hand_drawn[1]
                for _,v in pairs(context.hand_drawn) do
                    if v:get_id() < lowid:get_id() then
                        lowid = v
                    end
                end
                
                G.E_MANAGER:add_event(Event({
                    blockable = false;
                    trigger = 'after',
                    delay = 1,
                    func = function()
                        assert(SMODS.modify_rank(lowid, card.ability.extra.rank))
                        lowid:juice_up(1,1)
                        play_sound('generic1', 0.7 + math.random() * 0.03, 0.4)
                    return true
                    end
                    }))
            end
        end
        
        if context.setting_blind then
            card.ability.extra.baby = 1
        end
        if context.end_of_round then
            card.ability.extra.baby = 0
        end
        ENERGY_RESET(context, card) -- Reset energy at end of round

  ---Extra--- 
    end,
}
SMODS.Joker {
    key = "124baby", --Smoochum
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Heart',
    cost = 2,
    pos = { x = 24, y = 3 },-- spritex
    config = { extra = { stage = 'Smoochum', stagef = 'Smoochum', suit = 'Hearts',        -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 24, spritey = 3, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         add = 3,
                        baby = 0 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_baby'}
        --Extra

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                 --Extra
                                card.ability.extra.add,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.baby, 'Baby', 1),  --Move1
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

        if context.setting_blind then
            local pkmns = {}
            for _,v in pairs(G.jokers.cards) do
                if v ~= card and v.ability and v.ability.extra and type(v.ability.extra) == 'table' and v.ability.extra.energy then
                    pkmns[#pkmns+1] = v
                end
            end
            local pkmn = pseudorandom_element(pkmns, 'pokes_smoochum')
            pkmn.ability.extra.energy = pkmn.ability.extra.energy + 3
            pkmn:juice_up(0.8,0.8)
        end
        
        if context.setting_blind then
            card.ability.extra.baby = 1
        end
        if context.end_of_round then
            card.ability.extra.baby = 0
        end
        ENERGY_RESET(context, card) -- Reset energy at end of round

  ---Extra--- 
    end,
}
SMODS.Joker {
    key = "125baby", --Elekid
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Diamond',
    cost = 2,
    pos = { x = 25, y = 3 },-- spritex
    config = { extra = { stage = 'Elekid', stagef = 'Elekid', suit = 'Diamonds',        -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 25, spritey = 3, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         add = 1,
                        baby = 0 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_baby'}
        --Extra

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                 --Extra
                                card.ability.extra.add,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.baby, 'Baby', 1),  --Move1
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

        if context.before then
            for _,v in pairs(G.jokers.cards) do
                if v ~= card and v.ability and v.ability.extra and type(v.ability.extra) == 'table' and v.ability.extra.energy then
                    v.ability.extra.energy = v.ability.extra.energy + card.ability.extra.add
                end
            end
            card:juice_up(0.4,0.4)
        end
        
        if context.setting_blind then
            card.ability.extra.baby = 1
        end
        if context.end_of_round then
            card.ability.extra.baby = 0
        end
        ENERGY_RESET(context, card) -- Reset energy at end of round

  ---Extra--- 
    end,
}
SMODS.Joker {
    key = "126baby", --Magby
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 'pokes_Heart',
    cost = 2,
    pos = { x = 26, y = 3 },-- spritex
    config = { extra = { stage = 'Magby', stagef = 'Magby', suit = 'Hearts',        -- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 26, spritey = 3, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                                                                                      -- Extra
                         add = 1,
                        baby = 0 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_baby'}
        --Extra

            return { vars = { card.ability.extra.stage,                                                          --Stage
                                                                 --Extra
                                card.ability.extra.add,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.baby, 'Baby', 1),  --Move1
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

         if context.discard and context.other_card == context.full_hand[#context.full_hand] then
            for _,v in pairs(G.jokers.cards) do
                if v ~= card and v.ability and v.ability.extra and type(v.ability.extra) == 'table' and v.ability.extra.energy then
                    v.ability.extra.energy = v.ability.extra.energy + card.ability.extra.add
                end
            end
            card:juice_up(0.4,0.4)
        end
        
        if context.setting_blind then
            card.ability.extra.baby = 1
        end
        if context.end_of_round then
            card.ability.extra.baby = 0
        end
        ENERGY_RESET(context, card) -- Reset energy at end of round

  ---Extra--- 
    end,
}