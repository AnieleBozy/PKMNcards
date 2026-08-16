
--SMODS.Shader({
--   key = 'evolution',
--   path = ''
--
--})

SMODS.Edition {
    key = 'evolution',
    shader = false,
    --shader = 'evolution',--'evolution',
    config = { extra_slots_used = -1},
    in_shop = false,
    weight = 0,
    extra_cost = 0,
    no_collection = true,
    sound = { vol = 0 },

    loc_vars = function(self, info_queue, card)
       return { vars = { card.edition.card_limit, colours = { HEX('83F1F7'), G.C.UI.TEXT_LIGHT } } }
    end,
    get_weight = function(self)
        return self.weight
    end,
   -- draw = function(self, card, layer)
       -- if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' and (card.config.center.discovered or card.bypass_discovery_center) then
            --card.children.center:draw_shader('negative', nil, card.ARGS.send_to_shader)
       -- end
   -- end
}

SMODS.Edition {
    key = 'item',
    shader = false,
    --shader = 'item
    config = { extra_slots_used = -1},
    in_shop = false,
    weight = 0,
    extra_cost = 0,
    no_collection = true,

    loc_vars = function(self, info_queue, card)
       return { vars = { card.edition.card_limit, colours = { HEX('83F1F7'), G.C.UI.TEXT_LIGHT } } }
    end,
    get_weight = function(self)
        return self.weight
    end,
}
SMODS.Edition {
    key = 'item_foil',
    shader = 'foil',
    prefix_config = {
        shader = false
    },
    config = { extra_slots_used = -1},
    in_shop = false,
    weight = 0,
    extra_cost = 2,
    no_collection = true,

    loc_vars = function(self, info_queue, card)
       return { vars = { card.edition.card_limit, colours = { HEX('83F1F7'), G.C.UI.TEXT_LIGHT } } }
    end,
    get_weight = function(self)
        return self.weight
    end,
}
SMODS.Edition {
    key = 'item_holo',
    shader = 'holo',
    prefix_config = {
        shader = false
    },
    config = { extra_slots_used = -1},
    in_shop = false,
    weight = 0,
    extra_cost = 3,
    no_collection = true,

    loc_vars = function(self, info_queue, card)
       return { vars = { card.edition.card_limit, colours = { HEX('83F1F7'), G.C.UI.TEXT_LIGHT } } }
    end,
    get_weight = function(self)
        return self.weight
    end,
}
SMODS.Edition {
    key = 'item_poly',
    shader = 'polychrome',
    prefix_config = {
        shader = false
    },
    config = { extra_slots_used = -1},
    in_shop = false,
    weight = 0,
    extra_cost = 5,
    no_collection = true,

    loc_vars = function(self, info_queue, card)
       return { vars = { card.edition.card_limit, colours = { HEX('83F1F7'), G.C.UI.TEXT_LIGHT } } }
    end,
    get_weight = function(self)
        return self.weight
    end,
}
SMODS.Edition {
    key = 'item_negative',
    shader = 'negative',
    prefix_config = {
        shader = false
    },
    config = { extra_slots_used = -1},
    in_shop = false,
    weight = 0,
    extra_cost = 5,
    no_collection = true,

    loc_vars = function(self, info_queue, card)
       return { vars = { card.edition.card_limit, colours = { HEX('83F1F7'), G.C.UI.TEXT_LIGHT } } }
    end,
    get_weight = function(self)
        return self.weight
    end,
}
SMODS.Edition {
    key = 'fakenegative',
    shader = 'negative',
    prefix_config = {
        shader = false
    },
    --config = { card_limit = 0, extra = { copied = 0 } },
    in_shop = false,
    weight = 0,
    extra_cost = 5,
    no_collection = true,

    loc_vars = function(self, info_queue, card)
       return { vars = { card.edition.card_limit, colours = { HEX('83F1F7'), G.C.UI.TEXT_LIGHT } } }
    end,
    get_weight = function(self)
        return self.weight
    end,
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' and (card.config.center.discovered or card.bypass_discovery_center) then
            card.children.center:draw_shader('negative', nil, card.ARGS.send_to_shader)
            if card.children.front and card.ability.effect ~= 'Stone Card' then
                card.children.front:draw_shader('negative', nil, card.ARGS.send_to_shader)
            end
            card.children.center:draw_shader('negative_shine', nil, card.ARGS.send_to_shader)
        end
    end,

    on_apply = function(card)
               
            G.E_MANAGER:add_event(Event({
                    func = (function()
                        if G.OVERLAY_MENU == nil then
                            --print(card.ability.card_limit)
                            if card.ability.card_limit == 0 then
                                card.ability.card_limit = 1
                            else 
                                card.ability.card_limit = 0
                                card:set_edition()
                            end
                        end
                        return true
                    end)
                }))

    end,
    on_remove = function (card)
        card.ability.card_limit = 0
    end
        
}
SMODS.Edition {
    key = 'team_rocket',
    shader = false,
    prefix_config = {
        shader = false
    },
    in_shop = false,
    weight = 0,
    extra_cost = 10,
    --no_collection = true,

    loc_vars = function(self,info_queue,card)
            local text1 = '<<<'
            local colour1 = mix_colours( G.C.JOKER_GREY, G.C.JOKER_GREY, 0.8)
            local text2 = '>>>'
            local colour2 = mix_colours( G.C.JOKER_GREY, G.C.JOKER_GREY, 0.8)
        
           if G.jokers and G.jokers.cards and card.ability.set == 'Joker' then
                local my_pos = nil
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] == card then
                        my_pos = i
                        break
                    end
                end
                if my_pos then 
                    if G.jokers.cards[my_pos-1] and G.jokers.cards[my_pos-1].edition then
                        if G.jokers.cards[my_pos-1].edition.key == 'e_foil' then
                            text1 = '+50 Chips'
                            colour1 = mix_colours(G.C.BLUE, G.C.JOKER_GREY, 0.8)
                        elseif G.jokers.cards[my_pos-1].edition.key == 'e_holo' then
                            text1 = '+10 Mult'
                            colour1 = mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8)
                        elseif G.jokers.cards[my_pos-1].edition.key == 'e_polychrome' then
                            text1 = 'X1.5 Mult'
                            colour1 = mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8)
                        elseif G.jokers.cards[my_pos-1].edition.key == 'e_negative' then
                            text1 = '+1 Joker slot'
                            colour1 = mix_colours(G.C.PURPLE, G.C.JOKER_GREY, 0.8)
                        end
                    end
                    if G.jokers.cards[my_pos+1] and G.jokers.cards[my_pos+1].edition then
                        if G.jokers.cards[my_pos+1].edition.key == 'e_foil' then
                            text2 = '+50 Chips'
                            colour2 = mix_colours(G.C.BLUE, G.C.JOKER_GREY, 0.8)
                        elseif G.jokers.cards[my_pos+1].edition.key == 'e_holo' then
                            text2 = '+10 Mult'
                            colour2 = mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8)
                        elseif G.jokers.cards[my_pos+1].edition.key == 'e_polychrome' then
                            text2 = 'X1.5 Mult'
                            colour2 = mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8)
                        elseif G.jokers.cards[my_pos+1].edition.key == 'e_negative' then
                            text2 = '+1 Joker slot'
                            colour2 = mix_colours(G.C.PURPLE, G.C.JOKER_GREY, 0.8)
                        end
                    end
                end
            end

            local element1 = 
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = colour1, r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = text1, colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
            local element2 = 
                        {
                            n = G.UIT.C,
                            config = { ref_table = card, align = "m", colour = colour2, r = 0.05, padding = 0.06 },
                            nodes = {
                                { n = G.UIT.T, config = { text = text2, colour = G.C.UI.TEXT_LIGHT, scale = 0.32 * 0.8 } },
                            }
                        }
            return { vars = { elements = { element1, element2 }, },  }
    end,

    calculate = function(self, card, context)

        if G.jokers and G.jokers.cards then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end

            if my_pos and 
            ((G.jokers.cards[my_pos + 1] and G.jokers.cards[my_pos + 1].edition
            and G.jokers.cards[my_pos + 1].edition.key == 'e_negative') 
            or (G.jokers.cards[my_pos - 1] and G.jokers.cards[my_pos - 1].edition
            and G.jokers.cards[my_pos - 1].edition.key == 'e_negative'))  then
                
                local _card_limit = 0
                if G.jokers.cards[my_pos + 1] and G.jokers.cards[my_pos + 1].edition and G.jokers.cards[my_pos + 1].edition.key == 'e_negative' then
                    _card_limit = _card_limit + 1
                end
                if G.jokers.cards[my_pos - 1] and G.jokers.cards[my_pos - 1].edition and G.jokers.cards[my_pos - 1].edition.key == 'e_negative' then
                    _card_limit = _card_limit + 1
                end
                
                card.ability.card_limit = _card_limit
            else
                card.ability.card_limit = 0
            end

                local destroy = #G.jokers.cards - G.jokers.config.card_limit
                if destroy > 0 then
                    local i = 0
                    local removed = 0
                    local _first_dissolve = nil
                    while i <= destroy - 1 or removed <= destroy - 1 do
                        if not ( G.jokers.cards[ #G.jokers.cards - i ].edition
                        and G.jokers.cards[ #G.jokers.cards - i ].edition.key == 'e_negative' ) then
                            removed = removed + 1
                            G.jokers.cards[ #G.jokers.cards - i ]:start_dissolve(nil, _first_dissolve)
                            _first_dissolve = true

                        end
                        i = i + 1
                    end
                end
        end

        if context.post_joker and card.ability.set == 'Joker' then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end

            if (my_pos and G.jokers and G.jokers.cards)
            and ( (G.jokers.cards[my_pos - 1] and G.jokers.cards[my_pos - 1].edition) 
            or    (G.jokers.cards[my_pos + 1] and G.jokers.cards[my_pos + 1].edition) ) then 
                local chips = 0
                local mult = 0
                local x_mult = 1
                if G.jokers.cards[my_pos - 1] and G.jokers.cards[my_pos - 1].edition then
                    if G.jokers.cards[my_pos - 1].edition.key == 'e_foil' then
                        chips = chips + 50
                    elseif G.jokers.cards[my_pos - 1].edition.key == 'e_holo' then
                        mult = mult + 10
                    elseif G.jokers.cards[my_pos - 1].edition.key == 'e_polychrome' then
                        x_mult = x_mult * 1.5
                    end

                end 
                if G.jokers.cards[my_pos + 1] and G.jokers.cards[my_pos + 1].edition then

                    if G.jokers.cards[my_pos + 1].edition.key == 'e_foil' then
                        chips = chips + 50
                    elseif G.jokers.cards[my_pos + 1].edition.key == 'e_holo' then
                        mult = mult + 10
                    elseif G.jokers.cards[my_pos + 1].edition.key == 'e_polychrome' then
                        x_mult = x_mult * 1.5
                    end
                end

                if chips ~= 0 and mult ~= 0 then
                    return { chips = chips, mult = mult, x_mult = x_mult }
                elseif chips ~= 0 then
                    return { chips = chips, x_mult = x_mult }
                elseif mult ~= 0 then
                    return { mult = mult, x_mult = x_mult }
                elseif x_mult ~= 1 then
                    return { x_mult = x_mult }
                end
            end
        elseif (context.main_scoring and context.cardarea == G.play) and card.ability.set ~= 'Joker' then
            local my_pos = nil
            for i = 1, #context.full_hand do
                if context.full_hand[i] == card then
                    my_pos = i
                    break
                end
            end

            if (my_pos and G.play and G.play.cards)
            and ( ( G.play.cards[my_pos - 1] and  G.play.cards[my_pos - 1].edition) 
            or    ( G.play.cards[my_pos + 1] and  G.play.cards[my_pos + 1].edition) ) then 
                local chips = 0
                local mult = 0
                local x_mult = 1
                if  G.play.cards[my_pos - 1] and G.play.cards[my_pos - 1].edition then
                    if G.play.cards[my_pos - 1].edition.key == 'e_foil' then
                        chips = chips + 50
                    elseif G.play.cards[my_pos - 1].edition.key == 'e_holo' then
                        mult = mult + 10
                    elseif G.play.cards[my_pos - 1].edition.key == 'e_polychrome' then
                        x_mult = x_mult * 1.5
                    end

                end 
                if G.play.cards[my_pos + 1] and G.play.cards[my_pos + 1].edition then

                    if G.play.cards[my_pos + 1].edition.key == 'e_foil' then
                        chips = chips + 50
                    elseif G.play.cards[my_pos + 1].edition.key == 'e_holo' then
                        mult = mult + 10
                    elseif G.play.cards[my_pos + 1].edition.key == 'e_polychrome' then
                        x_mult = x_mult * 1.5
                    end
                end

                if chips ~= 0 and mult ~= 0 then
                    return { chips = chips, mult = mult, x_mult = x_mult }
                elseif chips ~= 0 then
                    return { chips = chips, x_mult = x_mult }
                elseif mult ~= 0 then
                    return { mult = mult, x_mult = x_mult }
                elseif x_mult ~= 1 then
                    return { x_mult = x_mult }
                end
            end
        end

    end
}