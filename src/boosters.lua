-- PKMN Packs
SMODS.Booster {
    key = "pkmn_pack1",
    group_key = 'pkmnpack',
    weight = 0.125,
    kind = 'pokes_pkmn',
    cost = 4,
    atlas = 'pokes_boosters',
    pos = { x = 2, y = 0 },
    config = { extra = 2, choose = 1 },
    draw_hand = false,
    discovered = true,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card
            _card = {
                set = "Joker",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "pokes_pkmn1",
                rarity = pseudorandom_element({'pokes_Diamond','pokes_Heart','pokes_Spade','pokes_Club'})
            }
        return _card
    end,
}
-- PKMN Packs
SMODS.Booster {
    key = "pkmn_pack2",
    group_key = 'pkmnpack',
    weight = 0.125,
    kind = 'pokes_pkmn',
    cost = 4,
    atlas = 'pokes_boosters',
    pos = { x = 3, y = 0 },
    config = { extra = 2, choose = 1 },
    draw_hand = false,
    discovered = true,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card
            _card = {
                set = "Joker",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "pokes_pkmn2",
                rarity = pseudorandom_element({'pokes_Diamond','pokes_Heart','pokes_Spade','pokes_Club'})
            }
        return _card
    end,
}

-- PKMN Packs
SMODS.Booster {
    key = "pkmn_pack3",
    group_key = 'pkmnpack',
    weight = 0.0625,
    kind = 'pokes_pkmn',
    cost = 8,
    atlas = 'pokes_boosters',
    pos = { x = 1, y = 0 },
    config = { extra = 4, choose = 1 },
    draw_hand = false,
    discovered = true,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card
            _card = {
                set = "Joker",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "pokes_pkmn3",
                rarity = pseudorandom_element({'pokes_Diamond','pokes_Heart','pokes_Spade','pokes_Club'})
            }
        return _card
    end,
}
-- PKMN Packs
SMODS.Booster {
    key = "pkmn_pack4",
    group_key = 'pkmnpack',
    weight = 0,03125,
    kind = 'pokes_pkmn',
    cost = 8,
    atlas = 'pokes_boosters',
    pos = { x = 0, y = 0 },
    config = { extra = 4, choose = 2 },
    draw_hand = false,
    discovered = true,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card
            _card = {
                set = "Joker",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "pokes_pkmn4",
                rarity = pseudorandom_element({'pokes_Diamond','pokes_Heart','pokes_Spade','pokes_Club'})
            }
        return _card
    end,
}


-- PokeMail Packs
SMODS.Booster {
    key = "pkmn_mail1",
    group_key = 'mailpack',
    weight = 1,
    kind = 'pokes_mailkind',
    cost = 4,
    atlas = 'pokes_boosters',
    pos = { x = 1, y = 1 },
    config = { extra = 3, choose = 1 },
    draw_hand = false,
    discovered = true,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card
            _card = {
                set = "pokes_Pokemail",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "pokes_mail1",
            }
        return _card
    end,
}
-- PokeMail Packs
SMODS.Booster {
    key = "pkmn_mail2",
    group_key = 'mailpack',
    weight = 0.5,
    kind = 'pokes_mailkind',
    cost = 8,
    atlas = 'pokes_boosters',
    pos = { x = 0, y = 1 },
    config = { extra = 5, choose = 2 },
    draw_hand = false,
    discovered = true,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card
            _card = {
                set = "pokes_Pokemail",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "pokes_mail2",
            }
        return _card
    end,
}
-- Evolution Pack
SMODS.Booster {
    key = "pkmn_evo1",
    group_key = 'evopack',
    weight = 8,
    kind = 'pokes_evo',
    cost = 4,
    atlas = 'pokes_boosters',
    pos = { x = 1, y = 2 },
    config = { extra = 3, choose = 1 },
    draw_hand = false,
    discovered = true,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card = SMODS.create_card({ set = "Joker", rarity = 'Uncommon', area = G.pack_cards, skip_materialize = true, soulable = false, key_append = "pokes_evo1" })
        if _card.edition and _card.edition.key == 'e_pokes_evolution' then
            return _card
        end
        _card:remove()
        local _rarity = pseudorandom_element({'pokes_Heart','pokes_Diamond','pokes_Club','pokes_Spade'})
        return SMODS.create_card({ set = "Joker", rarity = _rarity, area = G.pack_cards, skip_materialize = true, soulable = false, key_append = "pokes_evo1" })
        --return { set = "Joker", rarity = 'Uncommon', area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "pokes_evo1" }
    end,
    in_pool = function (self,args)
                local cards = {}
                for i=1,3 do
                        cards[ # cards + 1 ] = SMODS.create_card {
                            set = "Joker",
                            rarity = 'Uncommon',
                            area = G.pokes_can_evolve,
                            key_append = "pokes_check_evolve",
                            no_edition = true,
                            skip_materialize = true,
                            silent = true,
                        }
                end
                        local k = true
                        for _,v in pairs(cards) do
                            if not (v.edition and v.edition.key == 'e_pokes_evolution') then
                                k = false
                                --break
                            end
                            v:remove()
                        end
                
                    --SMODS.destroy_cards(cards, {immediate = true, skip_anim = true} )
                return k
        end
        
}
-- Evolution Pack
SMODS.Booster {
    key = "pkmn_evo2",
    group_key = 'evopack',
    weight = 6,
    kind = 'pokes_evo',
    cost = 8,
    atlas = 'pokes_boosters',
    pos = { x = 0, y = 2 },
    config = { extra = 1, choose = 1 },
    draw_hand = false,
    discovered = true,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card = SMODS.create_card({ set = "Joker", rarity = 'Rare', area = G.pack_cards, skip_materialize = true, soulable = false, key_append = "pokes_evo2" })
        if _card.edition and _card.edition.key == 'e_pokes_evolution' then
            return _card
        end
        _card:remove()
        local _rarity = pseudorandom_element({'pokes_Heart','pokes_Diamond','pokes_Club','pokes_Spade'})
        return SMODS.create_card({ set = "Joker", rarity = _rarity, area = G.pack_cards, skip_materialize = true, soulable = false, key_append = "pokes_evo2" })
    end,
    in_pool = function (self,args)
                local _card = SMODS.create_card {
                    set = "Joker",
                    rarity = 'Rare',
                    area = G.pokes_can_evolve,
                    key_append = "pokes_check_evolve",
                    no_edition = true,
                    skip_materialize = true,
                    silent = true,
                }
                
                if _card.edition and _card.edition.key == 'e_pokes_evolution' then
                    --SMODS.destroy_cards(_card, {immediate = true, skip_anim = true} )
                    _card.edition = nil
                    _card:remove()
                    return true
                else
                    --SMODS.destroy_cards(_card, {immediate = true, skip_anim = true} )
                    _card:remove()
                    return false
                end
    end,
        
}
-- Trainer 1 Packs
SMODS.Booster {
    key = "trainer_pack1",
    group_key = 'trainerpack',
    weight = 0.6,
    kind = 'pokes_trainer',
    cost = 4,
    atlas = 'pokes_boosters',
    pos = { x = 2, y = 1 },
    config = { extra = 3, choose = 1 },
    draw_hand = true,
    discovered = true,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card
            _card = {
                set = "pokes_Trainer",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "pokes_trainerpack",
            }
        return _card
    end,
}
-- Trainer 2 Packs
SMODS.Booster {
    key = "trainer_pack2",
    group_key = 'trainerpack',
    weight = 0.4,
    kind = 'pokes_trainer',
    cost = 8,
    atlas = 'pokes_boosters',
    pos = { x = 3, y = 1 },
    config = { extra = 5, choose = 2 },
    draw_hand = true,
    discovered = true,
    ease_background_colour = function(self)
        ease_background_colour_blind(G.STATES.TAROT_PACK)
    end,
    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
            timer = 0.015,
            scale = 0.2,
            initialize = true,
            lifespan = 1,
            speed = 1.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
            fill = true
        })
        G.booster_pack_sparkles.fade_alpha = 1
        G.booster_pack_sparkles:fade(1, 0)
    end,
    create_card = function(self, card, i)
        local _card
            _card = {
                set = "pokes_Trainer",
                area = G.pack_cards,
                skip_materialize = true,
                soulable = true,
                key_append =
                "pokes_trainerpack",
            }
        return _card
    end,
}