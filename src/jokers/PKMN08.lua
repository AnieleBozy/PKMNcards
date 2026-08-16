SMODS.Joker {
    key = "ex1", --Pikachu
    atlas = 'sprites',
    discovered = 'true',
    blueprint_compat = false,
    rarity = 4,
    cost = 20,
    pos = { x = 25, y = 0 },-- spritex
    config = { extra = { stage = 'Pikachu_ex', stagef = 'Pikachu_ex', suit = 'Diamonds',-- Stage of PKMN, First stage of PKMN, Suit of PKMN,
                         spritex = 25, spritey = 0, energy = 0, activem1 = false, activem2 = false,-- Which sprite to get for you PKMN?, Current energy
                         -- Extra
                         cash = 10    }},
    loc_vars = function(self, info_queue, card)
        --Extra
local ex_symbol = {n = G.UIT.O, config = { object = SMODS.create_sprite( 0, 0, 0.5, 0.5, "pokes_ex", {x = 0, y = 0} ) } }
        info_queue[#info_queue+1] = {set = 'Other', key ='pokes_rarity_diamond'}

            return { vars = { 'Pikachu',                                                          --Stage
                                                                                                                 --Extra  
                               card.ability.extra.cash,
                               elements = { ENERGY_CURRENT(card.ability.extra.energy, card.ability.extra.suit),  --Current energy
                                            ENERGY_MOVE(card.ability.extra.energy, card.ability.extra.suit, 5), --Move1
                                            ex_symbol,
                                }, colours = { HEX('FF0037'), HEX('FFFFFF')},
                            },-- key = stage_key
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
        -- Get energy from discards
        if context.discard and not context.blueprint and not context.other_card.debuff
        and context.other_card:is_suit(card.ability.extra.suit) 
        then
                card.ability.extra.energy = card.ability.extra.energy + 1
        end

        --Ability
        if context.modify_shop_card then
            context.card:set_edition('e_negative')
        end
        if context.starting_shop then 
            if G.jokers and G.jokers.cards then
                for _,v in pairs(G.jokers.cards) do
                    if v ~= card then
                        SMODS.destroy_cards(v)
                    end
                end
            end
        end

        --Move1
        if context.selling_card and card.ability.extra.energy >=5 then
            ease_dollars(card.ability.extra.cash)
        end

        --Message after getting access to move
        if card.ability.extra.energy >= 5 and card.ability.extra.activem1 == false and card.ability.extra.convert then
            card.ability.extra.activem1 = true
            return {
            message = localize('k_level_up_ex') }
        end

        ENERGY_RESET(context,card)

  ---Extra--- 
    end,
    }