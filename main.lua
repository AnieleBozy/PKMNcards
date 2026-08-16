
SMODS.Atlas {
    key = 'sprites',
    path = 'sprites.png',
    px=71,
    py= 95
}

SMODS.Atlas {
    key = 'suitSprite',
    path = 'suits.png',
    px = 160,
    py = 160,
}

SMODS.Atlas {
    key = 'items',
    path = 'items.png',
    px = 65,
    py = 95,
}

SMODS.Atlas {
    key = 'enh',
    path = 'enh.png',
    px = 71,
    py = 95,
}
SMODS.Atlas {
    key = 'blinds',
    path = 'blinds.png',
    px = 34,
    py = 34,
}
SMODS.Atlas {
    key = 'mailed',
    path = 'mailed.png',
    px = 32,
    py = 32,
}
SMODS.Atlas {
    key = 'pokes_boosters',
    path = 'boosters.png',
    px = 71,
    py = 96,
}
SMODS.Atlas {
    key = 'pokes_trainers',
    path = 'trainers.png',
    px = 71,
    py = 95,
}
SMODS.Atlas {
    key = 'ex',
    path = 'ex.png',
    px = 15,
    py = 11,
}


local main_menu = Game.main_menu
function Game.main_menu(change_context)
    local ret = main_menu(change_context)
    G.pokes_sprite = Sprite(0, 0, 71, 95, G.ASSET_ATLAS['pokes_mailed'], {x = 0, y = 0})
    G.pokes_sprite_teamrocket = Sprite(0, 0, 71, 95, G.ASSET_ATLAS['pokes_enh'], {x = 8, y = 1})
    
    return ret
end

SMODS.DrawStep {
    key = 'team_rocket',
    order = 1,
    func = function(self, layer)
        if G.pokes_sprite_teamrocket and self.edition and self.edition.key == 'e_pokes_team_rocket' then
            G.pokes_sprite_teamrocket:draw_shader('dissolve', nil, nil, nil, self.children.center)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}
SMODS.DrawStep {
    key = 'mailed',
    order = 1,
    func = function(self, layer)
        if G.pokes_sprite and self.ability and self.ability.mail then
            G.pokes_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center, nil, nil, 0.5, -0.4)
            if math.floor(3 * G.TIMERS.REAL) % 2 == 0 then
                G.pokes_sprite:set_sprite_pos({x = 1, y = 0})
            else
                G.pokes_sprite:set_sprite_pos({x = 0, y = 0})
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

SMODS.current_mod.optional_features = {
    quantum_enhancements = true,
}
SMODS.current_mod.custom_card_areas = function(g)
    g.pokes_can_evolve = CardArea(
        0,
        -200,
        0,
        0,
        {
        }
    )
end


pokes_config = SMODS.current_mod.config
local atpref = SMODS.add_to_pool
function SMODS.add_to_pool(prototype, args)
    if prototype.set == "Joker" and not prototype.original_mod
    and not pokes_config.vanilla_jokers then
        return false
    end
    return atpref(prototype, args)
end

local card_highlight_ref = Card.highlight
function Card:highlight(is)
    local ret = card_highlight_ref(self, is)
    
    if self.area == G.hand and is then
        SMODS.calculate_context({
           pokes_select = true,
           pokes_selected = self,
        })
    end

    return ret
end

local copycard_ref = copy_card
function copy_card(other, new_card, card_scale, playing_card, strip_edition)

    local give_back = false
    if other and other.ability and other.ability.mail and other.ability.set == 'Default'
    and not (other.area == G.deck) then
        other.ability.mail = false 
        give_back = true
    end

    local ret = copycard_ref(other, new_card, card_scale, playing_card, strip_edition)
    --if new_card and new_card.ability and new_card.ability.mail then new_card.ability.mail = false end
    if give_back then other.ability.mail = true end
    
    return ret
end

local jokers_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/jokers")
for _, file in ipairs(jokers_src) do
    assert(SMODS.load_file("src/jokers/" .. file))()
end
assert(SMODS.load_file("src/functions/func_pkmn.lua"))()
assert(SMODS.load_file("src/functions/func_evo.lua"))()
assert(SMODS.load_file("src/enh.lua"))()
assert(SMODS.load_file("src/editions.lua"))()
assert(SMODS.load_file("src/rarities.lua"))()
assert(SMODS.load_file("src/blinds.lua"))()
assert(SMODS.load_file("src/boosters.lua"))()
assert(SMODS.load_file("src/trainers.lua"))()
assert(SMODS.load_file("src/pages.lua"))()

--vanilla changes
if not pokes_config.vanilla_jokers then

    -- The Water
    SMODS.Blind:take_ownership('bl_water', {
        key = "water",
        dollars = 5,
        mult = 2,
        pos = { x = 0, y = 14 },
        boss = { min = 2 },
        boss_colour = HEX("c6e0eb"),
        calculate = function(self, blind, context)
            if context.blind_disabled then
                ease_discard(blind.effect.discards_sub)
            end

            if blind.disabled then return end

            if context.setting_blind then
                local add_discard = true
                if G.GAME.current_round.discards_left == 0 then
                    add_discard = false
                end
                blind.effect.discards_sub = G.GAME.current_round.discards_left
                ease_discard(-blind.effect.discards_sub)
                
                if add_discard then
                    G.E_MANAGER:add_event(Event({
                    blockable = false,
                    trigger = 'after',
                    delay = 2.5,
                    func = function()
                        ease_discard(1)
                    return true
                    end
                    }))
                end
            end
        end
    }, false)

    -- Judgement
    SMODS.Consumable:take_ownership('c_judgement', {
        key = 'judgement',
        set = 'Tarot',
        pos = { x = 0, y = 2 },
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('timpani')
                    --if SMODS.current_mod.config.vanilla_jokers then
                    local _rarity = pseudorandom_element({'pokes_Heart','pokes_Diamond','pokes_Club','pokes_Spade'})
                    SMODS.add_card({ set = 'Joker', rarity = _rarity, key_append = "jud" })
                    --else
                    -- SMODS.add_card({ set = 'Joker', key_append = "jud" })
                    --end
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            delay(0.6)
        end,
        can_use = function(self, card)
            card.key = 'c_judgement'
            return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
        end
    }, false ) 
    -- Top-up Tag
    SMODS.Tag:take_ownership('tag_top_up', {
        key = "top_up",
        min_ante = 1,
        pos = { x = 4, y = 1 },
        config = { spawn_jokers = 2 },
        loc_vars = function(self, info_queue, tag)
            return { vars = { tag.config.spawn_jokers } }
        end,
        apply = function(self, tag, context)
            if context.type == 'immediate' then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true
                tag:yep('+', G.C.PURPLE, function()
                    for _ = 1, tag.config.spawn_jokers do
                        if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
                            local _rarity = pseudorandom_element({'pokes_Heart','pokes_Diamond','pokes_Club','pokes_Spade'})
                            SMODS.add_card {
                                set = "Joker",
                                rarity = _rarity,
                                key_append = "top"
                            }
                        end
                    end
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                tag.triggered = true
                return true
            end
        end
    }, false )
    --Wraith
    SMODS.Consumable:take_ownership('c_wraith', {
        key = 'wraith',
        set = 'Spectral',
        pos = { x = 5, y = 4 },
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('timpani')
                    local _rarity = pseudorandom_element({'pokes_Heart','pokes_Diamond','pokes_Club','pokes_Spade'})
                    local _edition = SMODS.poll_edition { key = "pokes_wra", guaranteed = true, no_negative = false }
                    SMODS.add_card({ set = 'Joker', rarity = _rarity, edition = _edition, key_append = 'wra' })
                    card:juice_up(0.3, 0.5)
                    if G.GAME.dollars ~= 0 then
                        ease_dollars(-G.GAME.dollars, true)
                    end
                    return true
                end
            }))
            delay(0.6)
        end,
        can_use = function(self, card)
            return #G.jokers.cards < G.jokers.config.card_limit or card.area == G.jokers
        end,
        draw = function(self, card, layer)
            if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
                card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
            end
        end
    }, false)
end
