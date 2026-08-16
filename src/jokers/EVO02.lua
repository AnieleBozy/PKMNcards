SMODS.Joker {
    key = "017", --Pidgey/Pidgeotto/
    atlas = "sprites",
    pos = {
        x = 17,
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
            SMODS.calculate_context({ pokes_tag016 = true })
            
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
        return IS_POOL('Pidgey')-- Previous stage name
    end,
}

SMODS.Joker {
    key = "018", --Pidgey/Pidgeotto/Pidgeot
    atlas = "sprites",
    pos = {
        x = 18,
        y = 0
    },
    rarity = 3,
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
            SMODS.calculate_context({ pokes_tag017 = true })
            
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
        return IS_POOL('Pidgeotto')-- Previous stage name
    end,
}


SMODS.Joker {
    key = "020", --Rattata/Raticate
    atlas = "sprites",
    pos = {
        x = 20,
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
            SMODS.calculate_context({ pokes_tag019 = true })
            
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
        return IS_POOL('Rattata')-- Previous stage name
    end,
}

SMODS.Joker {
    key = "022", --Spearow/Fearow
    atlas = "sprites",
    pos = {
        x = 22,
        y = 0
    },
    rarity = 2,
    cost = 3,
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
            SMODS.calculate_context({ pokes_tag021 = true })
            
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
        return IS_POOL('Spearow')-- Previous stage name
    end,
}

SMODS.Joker {
    key = "024", --Ekans/Arbok
    atlas = "sprites",
    pos = {
        x = 24,
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
            SMODS.calculate_context({ pokes_tag023 = true })
            
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
        return IS_POOL('Ekans')-- Previous stage name
    end,
}