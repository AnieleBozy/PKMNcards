SMODS.Joker {
    key = "049", --Venonat/Venomoth
    atlas = "sprites",
    pos = {
        x = 49,
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
            SMODS.calculate_context({ pokes_tag048 = true })
            
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
        return IS_POOL('Venonat')-- Previous stage name
    end,
}SMODS.Joker {
    key = "051", --Diglett/Dugtrio
    atlas = "sprites",
    pos = {
        x = 51,
        y = 0
    },
    rarity = 2,
    cost = 5,
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
            SMODS.calculate_context({ pokes_tag050 = true })
            
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
        return IS_POOL('Diglett')-- Previous stage name
    end,
}
SMODS.Joker {
    key = "053", --Meowth/Persian
    atlas = "sprites",
    pos = {
        x = 53,
        y = 0
    },
    rarity = 2,
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
            SMODS.calculate_context({ pokes_tag052 = true })
            
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
        return IS_POOL('Meowth')-- Previous stage name
    end,
}
SMODS.Joker {
    key = "055", --Psyduck/Golduck
    atlas = "sprites",
    pos = {
        x = 55,
        y = 0
    },
    rarity = 2,
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
            SMODS.calculate_context({ pokes_tag054 = true })
            
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
        return IS_POOL('Psyduck')-- Previous stage name
    end,
}

SMODS.Joker {
    key = "057", --Mankey/Primeape
    atlas = "sprites",
    pos = {
        x = 57,
        y = 0
    },
    rarity = 2,
    cost = 5,
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
            SMODS.calculate_context({ pokes_tag056 = true })
            
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
        return IS_POOL('Mankey')-- Previous stage name
    end,
}
SMODS.Joker {
    key = "059", --Growlithe/Arcanine
    atlas = "sprites",
    pos = {
        x = 59,
        y = 0
    },
    rarity = 2,
    cost = 5,
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
            SMODS.calculate_context({ pokes_tag058 = true })
            
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
        return IS_POOL('Growlithe')-- Previous stage name
    end,
}