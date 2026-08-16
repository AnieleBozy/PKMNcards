--[[SMODS.Joker {
    key = "025", --Pichu/Pikachu
    atlas = "sprites",
    pos = {
        x = 25,
        y = 0
    },
    rarity = 2,
    cost = 4,
    blueprint_compat = false,
    discovered = true,
    no_collection = true,
    eternal_compat = false,
    perishable_compat = false,

        loc_vars = function(self, info_queue, card)
            -- Set description
            return { key = 'j_pokes_002' }
        end,
        set_ability = function(self, card) card:set_edition('e_pokes_evolution') -- Make it buyable if joker slots are full
            G.E_MANAGER:add_event(Event({
            blockable = false,
            trigger = 'after',
            func = function()
                if card.ability.rental then
                    card:remove_sticker('rental')
                    card:set_cost(card.base_cost)
                end
                return true
            end
        }))
        end, 

        add_to_deck = function(self, card, from_debuff) 
            
            -- Evolve PKMN when added
            SMODS.calculate_context({ pokes_tag025 = true })
            
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            trigger = 'after',
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self)
        -- Appear if only previous stage present
        return IS_POOL('Pichu')-- Previous stage name
    end,
}--]]
SMODS.Joker {
    key = "026", --Pichu/Pikachu/Raichu
    atlas = "sprites",
    pos = {
        x = 26,
        y = 0
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    discovered = true,
    no_collection = true,
    eternal_compat = false,
    perishable_compat = false,

        loc_vars = function(self, info_queue, card)
            -- Set description
            return { key = 'j_pokes_002' }
        end,
        set_ability = function(self, card) card:set_edition('e_pokes_evolution') -- Make it buyable if joker slots are full
            G.E_MANAGER:add_event(Event({
            blockable = false,
            trigger = 'after',
            func = function()
                if card.ability.rental then
                    card:remove_sticker('rental')
                    card:set_cost(card.base_cost)
                end
                return true
            end
        }))
        end, 

        add_to_deck = function(self, card, from_debuff) 
            
            -- Evolve PKMN when added
            SMODS.calculate_context({ pokes_tag026 = true })
            
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            trigger = 'after',
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self)
        -- Appear if only previous stage present
        return IS_POOL('Pikachu')-- Previous stage name
    end,
}
SMODS.Joker {
    key = "028", --Sandshrew to Sandslash
    atlas = "sprites",
    pos = {
        x = 28,
        y = 0
    },
    rarity = 2,
    cost = 4,
    blueprint_compat = false,
    discovered = true,
    no_collection = true,
    eternal_compat = false,
    perishable_compat = false,

        loc_vars = function(self, info_queue, card)
            -- Set description
            return { key = 'j_pokes_002' }
        end,
        set_ability = function(self, card) card:set_edition('e_pokes_evolution') -- Make it buyable if joker slots are full
            G.E_MANAGER:add_event(Event({
            blockable = false,
            trigger = 'after',
            func = function()
                if card.ability.rental then
                    card:remove_sticker('rental')
                    card:set_cost(card.base_cost)
                end
                return true
            end
        }))
        end, 

        add_to_deck = function(self, card, from_debuff) 
            
            -- Evolve PKMN when added
            SMODS.calculate_context({ pokes_tag027 = true })
            
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            trigger = 'after',
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self)
        -- Appear if only previous stage present
        return IS_POOL('Sandshrew')-- Previous stage name
    end,
}
SMODS.Joker {
    key = "030", --NidoranF/Nidorina/Nidoqueen
    atlas = "sprites",
    pos = {
        x = 30,
        y = 0
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    discovered = true,
    no_collection = true,
    eternal_compat = false,
    perishable_compat = false,

        loc_vars = function(self, info_queue, card)
            -- Set description
            return { key = 'j_pokes_002' }
        end,
        set_ability = function(self, card) card:set_edition('e_pokes_evolution') -- Make it buyable if joker slots are full
            G.E_MANAGER:add_event(Event({
            blockable = false,
            trigger = 'after',
            func = function()
                if card.ability.rental then
                    card:remove_sticker('rental')
                    card:set_cost(card.base_cost)
                end
                return true
            end
        }))
        end, 

        add_to_deck = function(self, card, from_debuff) 
            
            -- Evolve PKMN when added
            SMODS.calculate_context({ pokes_tag029 = true })
            
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            trigger = 'after',
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self)
        -- Appear if only previous stage present
        return IS_POOL('NidoranF')-- Previous stage name
    end,
}
SMODS.Joker {
    key = "031", --NidoranF/Nidorina/Nidoqueen
    atlas = "sprites",
    pos = {
        x = 31,
        y = 0
    },
    rarity = 3,
    cost = 7,
    blueprint_compat = false,
    discovered = true,
    no_collection = true,
    eternal_compat = false,
    perishable_compat = false,

        loc_vars = function(self, info_queue, card)
            -- Set description
            return { key = 'j_pokes_002' }
        end,
        set_ability = function(self, card) card:set_edition('e_pokes_evolution') -- Make it buyable if joker slots are full
            G.E_MANAGER:add_event(Event({
            blockable = false,
            trigger = 'after',
            func = function()
                if card.ability.rental then
                    card:remove_sticker('rental')
                    card:set_cost(card.base_cost)
                end
                return true
            end
        }))
        end, 

        add_to_deck = function(self, card, from_debuff) 
            
            -- Evolve PKMN when added
            SMODS.calculate_context({ pokes_tag030 = true })
            
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            trigger = 'after',
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self)
        -- Appear if only previous stage present
        return IS_POOL('Nidorina')-- Previous stage name
    end,
}
SMODS.Joker {
    key = "033", --Nidoranm/Nidorino/
    atlas = "sprites",
    pos = {
        x = 33,
        y = 0
    },
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    no_collection = true,
    eternal_compat = false,
    perishable_compat = false,

        loc_vars = function(self, info_queue, card)
            -- Set description
            return { key = 'j_pokes_002' }
        end,
        set_ability = function(self, card) card:set_edition('e_pokes_evolution') -- Make it buyable if joker slots are full
            G.E_MANAGER:add_event(Event({
            blockable = false,
            trigger = 'after',
            func = function()
                if card.ability.rental then
                    card:remove_sticker('rental')
                    card:set_cost(card.base_cost)
                end
                return true
            end
        }))
        end, 

        add_to_deck = function(self, card, from_debuff) 
            
            -- Evolve PKMN when added
            SMODS.calculate_context({ pokes_tag032 = true })
            
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            trigger = 'after',
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self)
        -- Appear if only previous stage present
        return IS_POOL('NidoranM')-- Previous stage name
    end,
}
SMODS.Joker {
    key = "034", --Nidoranm/Nidorino/Nidoking
    atlas = "sprites",
    pos = {
        x = 34,
        y = 0
    },
    rarity = 3,
    cost = 8,
    blueprint_compat = false,
    no_collection = true,
    eternal_compat = false,
    perishable_compat = false,

        loc_vars = function(self, info_queue, card)
            -- Set description
            return { key = 'j_pokes_002' }
        end,
        set_ability = function(self, card) card:set_edition('e_pokes_evolution') -- Make it buyable if joker slots are full
            G.E_MANAGER:add_event(Event({
            blockable = false,
            trigger = 'after',
            func = function()
                if card.ability.rental then
                    card:remove_sticker('rental')
                    card:set_cost(card.base_cost)
                end
                return true
            end
        }))
        end, 

        add_to_deck = function(self, card, from_debuff) 
            
            -- Evolve PKMN when added
            SMODS.calculate_context({ pokes_tag033 = true })
            
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            trigger = 'after',
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self)
        -- Appear if only previous stage present
        return IS_POOL('Nidorino')-- Previous stage name
    end,
}
SMODS.Joker {
    key = "036", --Nidoranm/Nidorino/Nidoking
    atlas = "sprites",
    pos = {
        x = 36,
        y = 0
    },
    rarity = 2,
    cost = 7,
    blueprint_compat = false,
    no_collection = true,
    eternal_compat = false,
    perishable_compat = false,

        loc_vars = function(self, info_queue, card)
            -- Set description
            return { key = 'j_pokes_002' }
        end,
        set_ability = function(self, card) card:set_edition('e_pokes_evolution') -- Make it buyable if joker slots are full
            G.E_MANAGER:add_event(Event({
            blockable = false,
            trigger = 'after',
            func = function()
                if card.ability.rental then
                    card:remove_sticker('rental')
                    card:set_cost(card.base_cost)
                end
                return true
            end
        }))
        end, 

        add_to_deck = function(self, card, from_debuff) 
            
            -- Evolve PKMN when added
            SMODS.calculate_context({ pokes_tag035 = true })
            
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            trigger = 'after',
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self)
        -- Appear if only previous stage present
        return IS_POOL('Clefairy')-- Previous stage name
    end,
}
SMODS.Joker {
    key = "38", --Vulpix/Ninetales
    atlas = "sprites",
    pos = {
        x = 38,
        y = 0
    },
    rarity = 2,
    cost = 4,
    blueprint_compat = false,
    discovered = true,
    no_collection = true,
    eternal_compat = false,
    perishable_compat = false,

        loc_vars = function(self, info_queue, card)
            -- Set description
            return { key = 'j_pokes_002' }
        end,
        set_ability = function(self, card) card:set_edition('e_pokes_evolution') -- Make it buyable if joker slots are full
            G.E_MANAGER:add_event(Event({
            blockable = false,
            trigger = 'after',
            func = function()
                if card.ability.rental then
                    card:remove_sticker('rental')
                    card:set_cost(card.base_cost)
                end
                return true
            end
        }))
        end, 

        add_to_deck = function(self, card, from_debuff) 
            
            -- Evolve PKMN when added
            SMODS.calculate_context({ pokes_tag037 = true })
            
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            trigger = 'after',
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self)
        -- Appear if only previous stage present
        return IS_POOL('Vulpix')-- Previous stage name
    end,
}