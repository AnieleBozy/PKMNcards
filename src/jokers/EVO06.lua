SMODS.Joker {
    key = "061", --Poliwag/Poliwhirl
    atlas = "sprites",
    pos = {
        x = 61,
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
            SMODS.calculate_context({ pokes_tag060 = true })
            
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
        return IS_POOL('Poliwag')-- Previous stage name
    end,}

SMODS.Joker {
    key = "062", --Poliwag/Poliwhirl/Poliwrath
    atlas = "sprites",
    pos = {
        x = 62,
        y = 0
    },
    rarity = 3,
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
            SMODS.calculate_context({ pokes_tag061 = true })
            
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
        return IS_POOL('Poliwhirl')-- Previous stage name
    end,}
SMODS.Joker {
    key = "062a", --Poliwag/Poliwhirl/Politoed
    atlas = "sprites",
    pos = {
        x = 62,
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
            SMODS.calculate_context({ pokes_tag061a = true })
            
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
        return IS_POOL('Poliwhirl')-- Previous stage name
    end,}
SMODS.Joker {
    key = "064", --Abra/Kadabra
    atlas = "sprites",
    pos = {
        x = 64,
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
            SMODS.calculate_context({ pokes_tag063 = true })
            
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
        return IS_POOL('Abra')-- Previous stage name
    end,}
SMODS.Joker {
    key = "065", --Abra/Kadabra/Alakazam
    atlas = "sprites",
    pos = {
        x = 65,
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
            SMODS.calculate_context({ pokes_tag064 = true })
            
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
        return IS_POOL('Kadabra')-- Previous stage name
    end,}
SMODS.Joker {
    key = "067", --Machop/Machoke
    atlas = "sprites",
    pos = {
        x = 67,
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
            SMODS.calculate_context({ pokes_tag066 = true })
            
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
        return IS_POOL('Machop')-- Previous stage name
    end,}
SMODS.Joker {
    key = "068", --Machop/Machoke/Machamp
    atlas = "sprites",
    pos = {
        x = 68,
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
            SMODS.calculate_context({ pokes_tag067 = true })
            
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
        return IS_POOL('Machoke')-- Previous stage name
    end,}
SMODS.Joker {
    key = "070", --Bellsprout/Weepinbell
    atlas = "sprites",
    pos = {
        x = 70,
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
            SMODS.calculate_context({ pokes_tag069 = true })
            
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
        return IS_POOL('Bellsprout')-- Previous stage name
    end,}

SMODS.Joker {
    key = "071", --Bellsprout/Weepinbell/Victreebel
    atlas = "sprites",
    pos = {
        x = 71,
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
            SMODS.calculate_context({ pokes_tag070 = true })
            
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
        return IS_POOL('Weepinbell')-- Previous stage name
    end,}

SMODS.Joker {
    key = "073", --Tentacool/Tentacruel
    atlas = "sprites",
    pos = {
        x = 73,
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
            SMODS.calculate_context({ pokes_tag072 = true })
            
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
        return IS_POOL('Tentacool')-- Previous stage name
    end,}
SMODS.Joker {
    key = "075", --Geodude/Graveler
    atlas = "sprites",
    pos = {
        x = 75,
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
            SMODS.calculate_context({ pokes_tag074 = true })
            
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
        return IS_POOL('Geodude')-- Previous stage name
    end,}
SMODS.Joker {
    key = "076", --Geodude/Graveler/Golem
    atlas = "sprites",
    pos = {
        x = 76,
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
            SMODS.calculate_context({ pokes_tag075 = true })
            
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
        return IS_POOL('Graveler')-- Previous stage name
    end,}

SMODS.Joker {
    key = "078", --Ponyta/Rapidash
    atlas = "sprites",
    pos = {
        x = 78,
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
            SMODS.calculate_context({ pokes_tag077 = true })
            
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
        return IS_POOL('Ponyta')-- Previous stage name
    end,}

SMODS.Joker {
    key = "080", --Slowpoke/Slowbro
    atlas = "sprites",
    pos = {
        x = 80,
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
            SMODS.calculate_context({ pokes_tag079 = true })
            
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
        return IS_POOL('Slowpoke')-- Previous stage name
    end,}

SMODS.Joker {
    key = "080a", --Slowpoke/Slowking
    atlas = "sprites",
    pos = {
        x = 80,
        y = 1
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
            SMODS.calculate_context({ pokes_tag079a = true })
            
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
        return IS_POOL('Slowpoke')-- Previous stage name
    end,}

SMODS.Joker {
    key = "082", --Magnemite/Magneton
    atlas = "sprites",
    pos = {
        x = 82,
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
            SMODS.calculate_context({ pokes_tag081 = true })
            
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
        return IS_POOL('Magnemite')-- Previous stage name
    end,}
SMODS.Joker {
    key = "085", --Doduo/Dodrio
    atlas = "sprites",
    pos = {
        x = 85,
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
            SMODS.calculate_context({ pokes_tag084 = true })
            
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
        return IS_POOL('Doduo')-- Previous stage name
    end,}
SMODS.Joker {
    key = "087", --Seel/Dewgon
    atlas = "sprites",
    pos = {
        x = 87,
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
            SMODS.calculate_context({ pokes_tag086 = true })
            
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
        return IS_POOL('Seel')-- Previous stage name
    end,}
SMODS.Joker {
    key = "089", --Grimer/Muk
    atlas = "sprites",
    pos = {
        x = 89,
        y = 0
    },
    rarity = 2,
    cost = 8,
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
            SMODS.calculate_context({ pokes_tag088 = true })
            
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
        return IS_POOL('Grimer')-- Previous stage name
    end,}
SMODS.Joker {
    key = "091", --Shellder/Cloyster
    atlas = "sprites",
    pos = {
        x = 91,
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
            SMODS.calculate_context({ pokes_tag090 = true })
            
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
        return IS_POOL('Shellder')-- Previous stage name
    end,}
SMODS.Joker {
    key = "093", --Gastly/Haunter
    atlas = "sprites",
    pos = {
        x = 93,
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
            SMODS.calculate_context({ pokes_tag092 = true })
            
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
        return IS_POOL('Gastly')-- Previous stage name
    end,}
SMODS.Joker {
    key = "094", --Gastly/Haunter/Gengar
    atlas = "sprites",
    pos = {
        x = 94,
        y = 0
    },
    rarity = 3, --rarity
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
            SMODS.calculate_context({ pokes_tag093 = true })
            
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
        return IS_POOL('Haunter')-- Previous stage name
    end,}
SMODS.Joker {
    key = "095a", --Onix/Steelix
    atlas = "sprites",
    pos = {
        x = 95,
        y = 1
    },
    rarity = 2, --rarity
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
            SMODS.calculate_context({ pokes_tag095 = true })
            
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
        return IS_POOL('Onix')-- Previous stage name
    end,}
SMODS.Joker {
    key = "097", --Drowzee/Hypno
    atlas = "sprites",
    pos = {
        x = 97,
        y = 0
    },
    rarity = 2, --rarity
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
            SMODS.calculate_context({ pokes_tag096 = true })
            
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
        return IS_POOL('Drowzee')-- Previous stage name
    end,}
SMODS.Joker {
    key = "099", --Krabby/Kingler
    atlas = "sprites",
    pos = {
        x = 99,
        y = 0
    },
    rarity = 2, --rarity
    cost = 9,
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
            SMODS.calculate_context({ pokes_tag098 = true })
            
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
        return IS_POOL('Krabby')-- Previous stage name
    end,}
SMODS.Joker {
    key = "101", --Voltorb/Electrode
    atlas = "sprites",
    pos = {
        x = 1,
        y = 2
    },
    rarity = 2, --rarity
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
            SMODS.calculate_context({ pokes_tag100 = true })
            
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
        return IS_POOL('Voltorb')-- Previous stage name
    end,}
SMODS.Joker {
    key = "103", --Exeggcute/Exeggutor
    atlas = "sprites",
    pos = {
        x = 3,
        y = 2
    },
    rarity = 2, --rarity
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
            SMODS.calculate_context({ pokes_tag102 = true })
            
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
        return IS_POOL('Exeggcute')-- Previous stage name
    end,}
SMODS.Joker {
    key = "105", --Cubone/Marowak
    atlas = "sprites",
    pos = {
        x = 5,
        y = 2
    },
    rarity = 2, --rarity
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
            SMODS.calculate_context({ pokes_tag104 = true })
            
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
        return IS_POOL('Cubone')-- Previous stage name
    end,}
SMODS.Joker {
    key = "106", --Tyrogue/Hitmonlee/Hitmonchan/Hitmontop
    atlas = "sprites",
    pos = {
        x = 6,
        y = 2
    },
    rarity = 2, --rarity
    cost = 8,
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
            SMODS.calculate_context({ pokes_tag106a = true })
            
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
        for k, v in pairs(G.jokers.cards) do
                if v.config and v.config.center and v.config.center.key == 'j_pokes_106a' then
                    return true
                end
        end
        return false
    end,}
SMODS.Joker {
    key = "107", --Tyrogue/Hitmonlee/Hitmonchan/Hitmontop
    atlas = "sprites",
    pos = {
        x = 7,
        y = 2
    },
    rarity = 2, --rarity
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
            SMODS.calculate_context({ pokes_tag106b = true })
            
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
        for k, v in pairs(G.jokers.cards) do
                if v.config and v.config.center and v.config.center.key == 'j_pokes_106a' then
                    return true
                end
        end
        return false
    end,}
SMODS.Joker {
    key = "107c", --Tyrogue/Hitmonlee/Hitmonchan/Hitmontop
    atlas = "sprites",
    pos = {
        x = 7,
        y = 3
    },
    rarity = 2, --rarity
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
            SMODS.calculate_context({ pokes_tag106c = true })
            
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
        for k, v in pairs(G.jokers.cards) do
                if v.config and v.config.center and v.config.center.key == 'j_pokes_106a' then
                    return true
                end
        end
        return false
    end,}
SMODS.Joker {
    key = "110", --Koffing/Weezing
    atlas = "sprites",
    pos = {
        x = 10,
        y = 2
    },
    rarity = 2, --rarity
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
            SMODS.calculate_context({ pokes_tag109 = true })
            
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
        return IS_POOL('Koffing')-- Previous stage name
    end,}
SMODS.Joker {
    key = "112", --Rhyhorn/Rhydon
    atlas = "sprites",
    pos = {
        x = 12,
        y = 2
    },
    rarity = 2, --rarity
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
            SMODS.calculate_context({ pokes_tag111 = true })
            
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
        return IS_POOL('Rhyhorn')-- Previous stage name
    end,}
SMODS.Joker {
    key = "113a", --Chansey/Blissey
    atlas = "sprites",
    pos = {
        x = 13,
        y = 3
    },
    rarity = 2, --rarity
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
            SMODS.calculate_context({ pokes_tag113 = true })
            
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
        return IS_POOL('Chansey')-- Previous stage name
    end,}
SMODS.Joker {
    key = "117", --Horsea/Seadra/Kingdra
    atlas = "sprites",
    pos = {
        x = 17,
        y = 2
    },
    rarity = 2, --rarity
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
            SMODS.calculate_context({ pokes_tag116 = true })
            
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
        return IS_POOL('Horsea')-- Previous stage name
    end,}
    
SMODS.Joker {
    key = "117a", --Horsea/Seadra/Kingdra
    atlas = "sprites",
    pos = {
        x = 17,
        y = 3
    },
    rarity = 3, --rarity
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
            SMODS.calculate_context({ pokes_tag117 = true })
            
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
        return IS_POOL('Seadra')-- Previous stage name
    end,}
SMODS.Joker {
    key = "119", --Horsea/Seadra/Kingdra
    atlas = "sprites",
    pos = {
        x = 19,
        y = 2
    },
    rarity = 2, --rarity
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
            SMODS.calculate_context({ pokes_tag118 = true })
            
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
        return IS_POOL('Goldeen')-- Previous stage name
    end,}
SMODS.Joker {
    key = "121", --Staryu/Starmie
    atlas = "sprites",
    pos = {
        x = 21,
        y = 2
    },
    rarity = 2, --rarity
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
            SMODS.calculate_context({ pokes_tag120 = true })
            
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
        return IS_POOL('Staryu')-- Previous stage name
    end,}
SMODS.Joker {
    key = "123a", --Scyther/Scizor
    atlas = "sprites",
    pos = {
        x = 23,
        y = 3
    },
    rarity = 2, --rarity
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
            SMODS.calculate_context({ pokes_tag123 = true })
            
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
        return IS_POOL('Scyther')-- Previous stage name
    end,}
SMODS.Joker {
    key = "130", --Magikarp/Gyarados
    atlas = "sprites",
    pos = {
        x = 30,
        y = 2,
        },
    rarity = 2, --rarity
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
            SMODS.calculate_context({ pokes_tag129 = true })
            
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
        return IS_POOL('Magikarp')-- Previous stage name
    end,}
SMODS.Joker {
    key = "134", --Eevee/Vaporeon
    atlas = "sprites",
    pos = {
        x = 34,
        y = 2,
        },
    rarity = 2, --rarity
    cost = 8,
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
            SMODS.calculate_context({ pokes_tag133a = true })
            
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
        return IS_POOL('Eevee')-- Previous stage name
    end,}
SMODS.Joker {
    key = "135", --Eevee/Jolteon
    atlas = "sprites",
    pos = {
        x = 35,
        y = 2,
        },
    rarity = 2, --rarity
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
            SMODS.calculate_context({ pokes_tag133b = true })
            
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
        return IS_POOL('Eevee')-- Previous stage name
    end,}
SMODS.Joker {
    key = "136", --Eevee/Flareon
    atlas = "sprites",
    pos = {
        x = 36,
        y = 2,
        },
    rarity = 2, --rarity
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
            SMODS.calculate_context({ pokes_tag133c = true })
            
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
        return IS_POOL('Eevee')-- Previous stage name
    end,}
SMODS.Joker {
    key = "133d", --Eevee/Espeon
    atlas = "sprites",
    pos = {
        x = 35,
        y = 3,
        },
    rarity = 2, --rarity
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
            SMODS.calculate_context({ pokes_tag133d = true })
            
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
        return IS_POOL('Eevee')-- Previous stage name
    end,}
SMODS.Joker {
    key = "133e", --Eevee/Umbreon
    atlas = "sprites",
    pos = {
        x = 36,
        y = 3,
        },
    rarity = 2, --rarity
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
            SMODS.calculate_context({ pokes_tag133e = true })
            
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
        return IS_POOL('Eevee')-- Previous stage name
    end,}
SMODS.Joker {
    key = "137a", --Porygon/Porygon2
    atlas = "sprites",
    pos = {
        x = 37,
        y = 3,
        },
    rarity = 2, --rarity
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
            SMODS.calculate_context({ pokes_tag137 = true })
            
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
        return IS_POOL('Porygon')-- Previous stage name
    end,}
SMODS.Joker {
    key = "148", --Dratini/Dragonair
    atlas = "sprites",
    pos = {
        x = 48,
        y = 2,
        },
    rarity = 2, --rarity
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
            SMODS.calculate_context({ pokes_tag147 = true })
            
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
        return IS_POOL('Dratini')-- Previous stage name
    end,}
SMODS.Joker {
    key = "149", --Dratini/Dragonair/Dragonite
    atlas = "sprites",
    pos = {
        x = 49,
        y = 2,
        },
    rarity = 3, --rarity
    cost = 8,
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
            SMODS.calculate_context({ pokes_tag148 = true })
            
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
        return IS_POOL('Dragonair')-- Previous stage name
    end,}