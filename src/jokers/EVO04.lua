SMODS.Joker {
    key = "040", --Jigglypuff/Wigglytuff
    atlas = "sprites",
    pos = {
        x = 40,
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
            SMODS.calculate_context({ pokes_tag039 = true })
            
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
        return IS_POOL('Jigglypuff')-- Previous stage name
    end,
}

SMODS.Joker {
    key = "042", --Zubat/Golabt/
    atlas = "sprites",
    pos = {
        x = 42,
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
            SMODS.calculate_context({ pokes_tag041 = true })
            
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
        return IS_POOL('Zubat')-- Previous stage name
    end,
}

SMODS.Joker {
    key = "042evo", --Zubat/Golabt/Crobat
    atlas = "sprites",
    pos = {
        x = 42,
        y = 1
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
            SMODS.calculate_context({ pokes_tag042 = true })
            
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
        return IS_POOL('Golbat')-- Previous stage name
    end,
}

SMODS.Joker {
    key = "044", --Oddish/Gloom/ Vileplume/Bellossom
    atlas = "sprites",
    pos = {
        x = 44,
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
            SMODS.calculate_context({ pokes_tag043 = true })
            
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
        return IS_POOL('Oddish')-- Previous stage name
    end,
}

SMODS.Joker {
    key = "045", --Oddish/Gloom/Vileplume/ Bellossom
    atlas = "sprites",
    pos = {
        x = 45,
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
            SMODS.calculate_context({ pokes_tag044 = true })
            
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
        return IS_POOL('Gloom')-- Previous stage name
    end,
}
SMODS.Joker {
    key = "045evo", --Oddish/Gloom/Vileplume/Bellossom
    atlas = "sprites",
    pos = {
        x = 45,
        y = 1
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
            SMODS.calculate_context({ pokes_tag044evo = true })
            
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
        return IS_POOL('Gloom')-- Previous stage name
    end,
}
SMODS.Joker {
    key = "047", --Paras/Parasect
    atlas = "sprites",
    pos = {
        x = 47,
        y = 0
    },
    rarity = 2,
    cost = 10,
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
            SMODS.calculate_context({ pokes_tag046 = true })
            
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
        return IS_POOL('Paras')-- Previous stage name
    end,
}