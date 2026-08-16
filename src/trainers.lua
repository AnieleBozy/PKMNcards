SMODS.ConsumableType {
    key = 'pokes_Trainer',
    default = 'c_pokes_pokeball',
    primary_colour = G.C.UI.TEXT_LIGHT,
    secondary_colour =  G.C.JOKER_GREY,
    collection_rows = { 5, 5 },
    shop_rate = 0.3,
}

-- Pokeball
SMODS.Consumable {
    key = 'pokeball',
    set = 'pokes_Trainer',
    atlas = 'pokes_trainers',
    pos = { x = 0, y = 0 },
    discovered = true,
    config = { extra = { seal = 'pokes_pokeball' }, max_highlighted = 1 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conv_card:set_seal(card.ability.extra.seal, nil, true)
                return true
            end
        }))

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,
}
-- Lorelei
SMODS.Consumable {
    key = 'lorelei',
    set = 'pokes_Trainer',
    atlas = 'pokes_trainers',
    pos = { x = 0, y = 1 },
    config = { max_highlighted = 3, mod_conv = 'm_pokes_energy_club' },
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}
-- Bruno
SMODS.Consumable {
    key = 'bruno',
    set = 'pokes_Trainer',
    atlas = 'pokes_trainers',
    pos = { x = 1, y = 1 },
    config = { max_highlighted = 3, mod_conv = 'm_pokes_energy_diamond' },
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}
-- Agatha
SMODS.Consumable {
    key = 'agatha',
    set = 'pokes_Trainer',
    atlas = 'pokes_trainers',
    pos = { x = 2, y = 1 },
    config = { max_highlighted = 3, mod_conv = 'm_pokes_energy_spade' },
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}
-- Flannery
SMODS.Consumable {
    key = 'flannery',
    set = 'pokes_Trainer',
    atlas = 'pokes_trainers',
    pos = { x = 3, y = 1 },
    config = { max_highlighted = 3, mod_conv = 'm_pokes_energy_heart' },
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}
-- Rocket Grunt
SMODS.Consumable {
    key = 'rocket_grunt',
    set = 'pokes_Trainer',
    atlas = 'pokes_trainers',
    pos = { x = 5, y = 0 },
    discovered = true,
    config = { max_highlighted = 1 },
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local aura_card = G.hand.highlighted[1]
                aura_card:set_edition('e_pokes_team_rocket', true)
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted <= card.ability.max_highlighted and #G.hand.highlighted > 0 and
            (not G.hand.highlighted[1].edition)
    end
}
-- Giovanni
SMODS.Consumable {
    key = 'giovanni',
    set = 'pokes_Trainer',
    atlas = 'pokes_trainers',
    pos = { x = 4, y = 0 },
    discovered = true,
    use = function(self, card, area, copier)
        local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers, true)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                local eligible_card = pseudorandom_element(editionless_jokers, 'pokes_giovanni')
                eligible_card:set_edition("e_pokes_team_rocket")

                local _first_dissolve = nil
                for _, joker in ipairs(G.jokers.cards) do
                    if joker ~= eligible_card and not SMODS.is_eternal(joker, card) then
                        joker:start_dissolve(nil, _first_dissolve)
                        _first_dissolve = true
                    end
                end

                card:juice_up(0.3, 0.5)
                return true
            end
        }))
    end,
    can_use = function(self, card)
        return next(SMODS.Edition:get_edition_cards(G.jokers, true))
    end,
}
-- Brock
SMODS.Consumable {
    key = 'brock',
    set = 'pokes_Trainer',
    atlas = 'pokes_trainers',
    pos = { x = 1, y = 0 },
    config = { max_highlighted = 1, mod_conv = 'm_pokes_stone_brock' },
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}
-- Misty
SMODS.Consumable {
    key = 'misty',
    set = 'pokes_Trainer',
    atlas = 'pokes_trainers',
    pos = { x = 2, y = 0 },
    config = { max_highlighted = 1, mod_conv = 'm_pokes_lucky_misty' },
    discovered = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}
-- Sabrina
SMODS.Consumable {
    key = 'sabrina',
    set = 'pokes_Trainer',
    atlas = 'pokes_trainers',
    pos = { x = 3, y = 0 },
    discovered = true,
    config = { extra = { seal = 'pokes_Redsabrina' }, max_highlighted = 1 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conv_card:set_seal(card.ability.extra.seal, nil, true)
                return true
            end
        }))

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,
}
-- Tate and Liza
SMODS.Consumable {
    key = 'tateandliza',
    set = 'pokes_Trainer',
    atlas = 'pokes_trainers',
    pos = { x = 6, y = 0 },
    discovered = true,
    config = { extra = { seal = 'pokes_purple_tateliza' }, max_highlighted = 1 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return { vars = { card.ability.max_highlighted } }
    end,
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conv_card:set_seal(card.ability.extra.seal, nil, true)
                return true
            end
        }))

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,
}