
local enhs = { G.P_CENTER_POOLS.Enhanced[1].key,G.P_CENTER_POOLS.Enhanced[2].key,G.P_CENTER_POOLS.Enhanced[3].key,G.P_CENTER_POOLS.Enhanced[4].key,
               G.P_CENTER_POOLS.Enhanced[5].key,G.P_CENTER_POOLS.Enhanced[6].key,G.P_CENTER_POOLS.Enhanced[7].key,G.P_CENTER_POOLS.Enhanced[8].key }

function ITEM_ANTY_RENTAL(card)
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
end

-- Mail pool
SMODS.ObjectType({
    key = "pokes_Pokemail",
    default = "j_pokes_item01",
    cards = {
            j_pokes_item01		 = true,
            j_pokes_item02		 = true,
            j_pokes_item03		 = true,
            j_pokes_item04		 = true,
            j_pokes_item05		 = true,
            j_pokes_item06		 = true,
            j_pokes_item07		 = true,
            j_pokes_item08		 = true,
            j_pokes_item09		 = true,
            j_pokes_item10		 = true,
            j_pokes_item11		 = true,
            j_pokes_item12		 = true,
            j_pokes_item13		 = true,
            j_pokes_item14		 = true,
            j_pokes_item15		 = true,
            j_pokes_item16		 = true,
            j_pokes_item17		 = true,
            j_pokes_item18		 = true,
            j_pokes_item19		 = true,
            j_pokes_item20		 = true,
            j_pokes_item21		 = true,
            j_pokes_item22		 = true,
            j_pokes_item23		 = true,
            j_pokes_item24		 = true,
            j_pokes_item25		 = true,
            j_pokes_item26		 = true,
            j_pokes_item27		 = true,
            j_pokes_item28		 = true,
            j_pokes_item29		 = true,
            j_pokes_item30		 = true,
            j_pokes_item31		 = true,
            j_pokes_item32		 = true,
            j_pokes_item33		 = true,
            j_pokes_item34		 = true,
            j_pokes_item35		 = true,
            j_pokes_item36		 = true,
            j_pokes_item37		 = true,
    },
})

SMODS.Joker {
    key = "item01",-- retro mail
    atlas = "items",
    pos = {
        x = 0,
        y = 0
    },
    rarity = 2,
    cost = 3, --1/3/5
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
    rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
                    ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                    
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,



        add_to_deck = function(self, card, from_debuff) 
            
            -- Item effect
            local ed
            if card.edition then
                if card.edition.key == 'e_pokes_item_foil' then
                    ed = 'e_foil'
                elseif card.edition.key == 'e_pokes_item_holo' then
                    ed = 'e_holo'
                elseif card.edition.key == 'e_pokes_item_poly' then
                    ed = 'e_polychrome'
                elseif card.edition.key == 'e_pokes_item_negative' then
                    ed = 'e_negative'
                end
            end

                for i=1,3 do
                    local suit_rarity = pseudorandom_element({"pokes_Club","pokes_Spade","pokes_Heart","pokes_Diamond"})
                    if G.jokers and #G.jokers.cards < G.jokers.config.card_limit
                    and (card.edition == nil) then
                            SMODS.add_card {
                                set = "Joker",
                                rarity = suit_rarity,
                            }
                    elseif G.jokers and #G.jokers.cards < G.jokers.config.card_limit and card.edition ~= nil then
                            SMODS.add_card {
                                set = "Joker",
                                rarity = suit_rarity,
                                edition = ed,
                            }
                    end
                end
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta' or args.source == 'rta' or args.source == 'uta'
    end

}

SMODS.Joker {
    key = "item02",-- mail space
    atlas = "items",
    pos = {
        x = 1,
        y = 0
    },
    rarity = 3,
    cost = 5,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
    rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
                    ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,



        add_to_deck = function(self, card, from_debuff) 
            
            -- Item effect
            local neg = true
            for i=1,4,1 do
                SMODS.add_card{
                    set = "Enhanced",--"Playing Card", 
                    suit = 'Spades',
                    area = G.deck,
                    enhancement = pseudorandom_element(enhs),
                }
                
                if card.edition and card.edition.key == 'e_pokes_item_foil' then
                        G.deck.cards[1].ability.perma_bonus = 50 + G.deck.cards[1].ability.perma_bonus
                    elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                        G.deck.cards[1].ability.perma_mult = 10 + G.deck.cards[1].ability.perma_mult
                    elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                            local xmult = math.pow( 0.5, G.deck.cards[1].ability.perma_x_mult + 1 )
                            xmult = math.floor(xmult * 100 + 0.5) / 100
                            G.deck.cards[1].ability.perma_x_mult = xmult + G.deck.cards[1].ability.perma_x_mult
                    elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                    and neg == true then
                        G.deck.cards[1]:set_edition('e_pokes_fakenegative')
                        neg = false
                end
                --G.deck.cards[1]:add_sticker('pokes_mailed')
                G.deck.cards[1].ability['mail'] = true --Delivered by mail

            end
            
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}

SMODS.Joker {
    key = "item03",-- heart mail
    atlas = "items",
    pos = {
        x = 2,
        y = 0
    },
    rarity = 3,
    cost = 5,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
    rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
                    ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,



        add_to_deck = function(self, card, from_debuff) 
            
            -- Item effect
            local neg = true
            for i=1,4,1 do
                SMODS.add_card{ -- Unenhanced Ace of Hearts
                set = "Base",
                suit = 'Hearts',
                rank = "Ace",
                area = G.deck }

                if card.edition and card.edition.key == 'e_pokes_item_foil' then
                        G.deck.cards[1].ability.perma_bonus = 50 + G.deck.cards[1].ability.perma_bonus
                    elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                        G.deck.cards[1].ability.perma_mult = 10 + G.deck.cards[1].ability.perma_mult
                    elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                            local xmult = math.pow( 0.5, G.deck.cards[1].ability.perma_x_mult + 1 )
                            xmult = math.floor(xmult * 100 + 0.5) / 100
                            G.deck.cards[1].ability.perma_x_mult = xmult + G.deck.cards[1].ability.perma_x_mult
                    elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                    and neg == true then
                        G.deck.cards[1]:set_edition('e_pokes_fakenegative')
                        neg = false
                end
                G.deck.cards[1].ability['mail'] = true --Delivered by mail
            end
            
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}
SMODS.Joker {
    key = "item04",-- bubble mail
    atlas = "items",
    pos = {
        x = 3,
        y = 0
    },
    rarity = 3,
    cost = 5,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
    rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
                    ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,



        add_to_deck = function(self, card, from_debuff) 
            -- Item effect
            local neg = true
            for i=1,4,1 do
                local random_edition = SMODS.poll_edition {  guaranteed = true, no_negative = true }
                SMODS.add_card{ -- random editions clubs
                set = 'Base',
                edition = random_edition,
                suit = 'Clubs',
                area = G.deck }

                if card.edition and card.edition.key == 'e_pokes_item_foil' then
                        G.deck.cards[1].ability.perma_bonus = 50 + G.deck.cards[1].ability.perma_bonus
                    elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                        G.deck.cards[1].ability.perma_mult = 10 + G.deck.cards[1].ability.perma_mult
                    elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                            local xmult = math.pow( 0.5, G.deck.cards[1].ability.perma_x_mult + 1 )
                            xmult = math.floor(xmult * 100 + 0.5) / 100
                            G.deck.cards[1].ability.perma_x_mult = xmult + G.deck.cards[1].ability.perma_x_mult
                    elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                    and neg == true then
                        G.deck.cards[1]:set_edition('e_pokes_fakenegative')
                        neg = false
                end
                G.deck.cards[1].ability['mail'] = true --Delivered by mail
            end

            
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}

SMODS.Joker {
    key = "item05",-- brick mail
    atlas = "items",
    pos = {
        x = 4,
        y = 0
    },
    rarity = 3,
    cost = 5,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
    rental_compat = false,
    config = { extra = { rcard = nil, set = true } },
        set_ability = function(self,card)
                    ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,



        add_to_deck = function(self, card, from_debuff) 
            -- Item effect
            local neg = true

        G.E_MANAGER:add_event(Event({
            func = function()    
                
            local rcards = {}
            for _, playing_card in ipairs(G.playing_cards) do
                rcards[#rcards + 1] = playing_card
            end
            card.ability.extra.rcard = pseudorandom_element(rcards)
            card.ability.extra.rcard = SMODS.change_base(card.ability.extra.rcard, "Diamonds")

            if not (card.ability.extra.rcard == nil) then

                local new_cards = {}
                for i = 1, 4 do

                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    local _card = copy_card( card.ability.extra.rcard , nil, nil, nil)
                    _card:add_to_deck()
                    
                    table.insert(G.playing_cards, _card)   
                    G.deck:emplace(_card)  
                    _card:start_materialize()
                    
                    new_cards[#new_cards + 1] = _card

                    if card.edition and card.edition.key == 'e_pokes_item_foil' then
                            G.deck.cards[1].ability.perma_bonus = 50 + G.deck.cards[1].ability.perma_bonus
                        elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                            G.deck.cards[1].ability.perma_mult = 10 + G.deck.cards[1].ability.perma_mult
                        elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                            local xmult = math.pow( 0.5, G.deck.cards[1].ability.perma_x_mult + 1 )
                            xmult = math.floor(xmult * 100 + 0.5) / 100
                            G.deck.cards[1].ability.perma_x_mult = xmult + G.deck.cards[1].ability.perma_x_mult
                        elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                        and neg == true then
                            G.deck.cards[1]:set_edition('e_pokes_fakenegative')
                            neg = false
                    end
                    G.deck.cards[1].ability['mail'] = true --Delivered by mail
                end
                SMODS.calculate_context({ playing_card_added = true, cards = new_cards })
                return true
            end
            end
        }))

            
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}

SMODS.Joker {
    key = "item06",-- shadow mail
    atlas = "items",
    pos = {
        x = 5,
        y = 0
    },
    rarity = 2,
    cost = 3,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
     rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
                    ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,


        add_to_deck = function(self, card, from_debuff) 
            -- Item effect
            local neg = true
            for i=1,4 do
                local cards = {}
                for _, playing_card in ipairs(G.playing_cards) do
                    if not (playing_card.base.suit == 'Spades') then
                        cards[#cards + 1] = playing_card
                    end
                end
                local _card = pseudorandom_element(cards)
                if _card then
                    SMODS.change_base(_card, 'Spades')

                    if card.edition and card.edition.key == 'e_pokes_item_foil' then
                            _card.ability.perma_bonus = 50 + _card.ability.perma_bonus
                        elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                            _card.ability.perma_mult = 10 + _card.ability.perma_mult
                        elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                            local xmult = math.pow( 0.5, _card.ability.perma_x_mult + 1 )
                            xmult = math.floor(xmult * 100 + 0.5) / 100
                            _card.ability.perma_x_mult = xmult + _card.ability.perma_x_mult
                        elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                        and neg == true then
                            _card:set_edition('e_pokes_fakenegative')
                            neg = false
                    end
                    _card.ability['mail'] = true --Delivered by mail
                end
            end
            
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}
SMODS.Joker {
    key = "item07",-- fab mail
    atlas = "items",
    pos = {
        x = 6,
        y = 0
    },
    rarity = 2,
    cost = 3,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
     rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
                    ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,


        add_to_deck = function(self, card, from_debuff) 
            -- Item effect
            local neg = true
            for i=1,4 do
                local cards = {}
                for _, playing_card in ipairs(G.playing_cards) do
                    if not (playing_card.base.suit == 'Hearts') then
                        cards[#cards + 1] = playing_card
                    end
                end
                local _card = pseudorandom_element(cards)
                if _card then
                    SMODS.change_base(_card, 'Hearts')

                    if card.edition and card.edition.key == 'e_pokes_item_foil' then
                            _card.ability.perma_bonus = 50 + _card.ability.perma_bonus
                        elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                            _card.ability.perma_mult = 10 + _card.ability.perma_mult
                        elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                            local xmult = math.pow( 0.5, _card.ability.perma_x_mult + 1 )
                            xmult = math.floor(xmult * 100 + 0.5) / 100
                            _card.ability.perma_x_mult = xmult + _card.ability.perma_x_mult
                        elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                        and neg == true then
                            _card:set_edition('e_pokes_fakenegative')
                            neg = false
                    end
                _card.ability['mail'] = true --Delivered by mail
                end
            end
            
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}

SMODS.Joker {
    key = "item08",-- glitter mail
    atlas = "items",
    pos = {
        x = 7,
        y = 0
    },
    rarity = 2,
    cost = 3,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
     rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
                    ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,


        add_to_deck = function(self, card, from_debuff) 
            -- Item effect
            local neg = true
            for i=1,4 do
                local cards = {}
                for _, playing_card in ipairs(G.playing_cards) do
                    if not (playing_card.base.suit == 'Diamonds') then
                        cards[#cards + 1] = playing_card
                    end
                end
                local _card = pseudorandom_element(cards)
                if _card then
                    SMODS.change_base(_card, 'Diamonds')
                    if card.edition and card.edition.key == 'e_pokes_item_foil' then
                            _card.ability.perma_bonus = 50 + _card.ability.perma_bonus
                        elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                            _card.ability.perma_mult = 10 + _card.ability.perma_mult
                        elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                            local xmult = math.pow( 0.5, _card.ability.perma_x_mult + 1 )
                            xmult = math.floor(xmult * 100 + 0.5) / 100
                            _card.ability.perma_x_mult = xmult + _card.ability.perma_x_mult
                        elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                        and neg == true then
                            _card:set_edition('e_pokes_fakenegative')
                            neg = false
                    end
                _card.ability['mail'] = true --Delivered by mail
                end
            end
            
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}


SMODS.Joker {
    key = "item09",-- wave mail
    atlas = "items",
    pos = {
        x = 8,
        y = 0
    },
    rarity = 2,
    cost = 3,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
     rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
                    ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,


        add_to_deck = function(self, card, from_debuff) 
            -- Item effect
            local neg = true

            for i=1,4 do
                local cards = {}
                for _, playing_card in ipairs(G.playing_cards) do
                    if not (playing_card.base.suit == 'Clubs') then
                        cards[#cards + 1] = playing_card
                    end
                end
                local _card = pseudorandom_element(cards)
                if _card then
                    SMODS.change_base(_card, 'Clubs')

                    if card.edition and card.edition.key == 'e_pokes_item_foil' then
                            _card.ability.perma_bonus = 50 + _card.ability.perma_bonus
                        elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                            _card.ability.perma_mult = 10 + _card.ability.perma_mult
                        elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                            local xmult = math.pow( 0.5, _card.ability.perma_x_mult + 1 )
                            xmult = math.floor(xmult * 100 + 0.5) / 100
                            _card.ability.perma_x_mult = xmult + _card.ability.perma_x_mult
                        elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                        and neg == true then
                            _card:set_edition('e_pokes_fakenegative')
                            neg = false
                    end
                _card.ability['mail'] = true --Delivered by mail
                end

            end
            
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}
SMODS.Joker {
    key = "item10",-- liteblue mail
    atlas = "items",
    pos = {
        x = 0,
        y = 1
    },
    rarity = 1,
    cost = 1,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
     rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self, card)
            ITEM_ANTY_RENTAL(card)
            card:set_edition('e_pokes_item',true,true)
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,


        add_to_deck = function(self, card, from_debuff) 
            -- Item effect
                local cards = {}
                for _, playing_card in ipairs(G.playing_cards) do
                    if (playing_card.base.suit == 'Spades') then
                        cards[#cards + 1] = playing_card
                    end
                end
                local _card = pseudorandom_element(cards)
                if _card then
                    SMODS.destroy_cards(_card)                    
                end
            
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}
SMODS.Joker {
    key = "item11",-- lovely mail
    atlas = "items",
    pos = {
        x = 1,
        y = 1
    },
    rarity = 1,
    cost = 1,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
     rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self, card)
            ITEM_ANTY_RENTAL(card)
            card:set_edition('e_pokes_item',true,true)
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,


        add_to_deck = function(self, card, from_debuff) 
            -- Item effect
                local cards = {}
                for _, playing_card in ipairs(G.playing_cards) do
                    if (playing_card.base.suit == 'Hearts') then
                        cards[#cards + 1] = playing_card
                    end
                end
                local _card = pseudorandom_element(cards)
                if _card then
                    SMODS.destroy_cards(_card)                    
                end
            
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}
SMODS.Joker {
    key = "item12",-- portrait mail
    atlas = "items",
    pos = {
        x = 2,
        y = 1
    },
    rarity = 1,
    cost = 1,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
     rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self, card)
            ITEM_ANTY_RENTAL(card)
            card:set_edition('e_pokes_item',true,true)
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,


        add_to_deck = function(self, card, from_debuff) 
            -- Item effect
                local cards = {}
                for _, playing_card in ipairs(G.playing_cards) do
                    if (playing_card.base.suit == 'Diamonds') then
                        cards[#cards + 1] = playing_card
                    end
                end
                local _card = pseudorandom_element(cards)
                if _card then
                    SMODS.destroy_cards(_card)                    
                end
            
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}
SMODS.Joker {
    key = "item13",-- mirage mail
    atlas = "items",
    pos = {
        x = 3,
        y = 1
    },
    rarity = 1,
    cost = 1,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
     rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self, card)
            ITEM_ANTY_RENTAL(card)
            card:set_edition('e_pokes_item',true,true)
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,


        add_to_deck = function(self, card, from_debuff) 
            -- Item effect
                local cards = {}
                for _, playing_card in ipairs(G.playing_cards) do
                    if (playing_card.base.suit == 'Clubs') then
                        cards[#cards + 1] = playing_card
                    end
                end
                local _card = pseudorandom_element(cards)
                if _card then
                    SMODS.destroy_cards(_card)                    
                end
            
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}
SMODS.Joker {
    key = "item23",-- wood mail
    atlas = "items",
    pos = {
        x = 3,
        y = 2
    },
    rarity = 2,
    cost = 3,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
     rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
            ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,


        add_to_deck = function(self, card, from_debuff) 
            -- Item effect
            local neg = true
            for _, area in ipairs({ G.consumeables }) do
                for _, other_card in ipairs(area.cards) do
                    if other_card.set_cost then
                        other_card.ability.extra_value = (other_card.ability.extra_value or 0) +
                            15
                        other_card:set_cost()

                        if other_card.edition == nil then
                            if card.edition and card.edition.key == 'e_pokes_item_foil' then
                                    other_card:set_edition('e_foil')
                                elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                                    other_card:set_edition('e_holo')
                                elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                                    other_card:set_edition('e_polychrome')
                                elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                                and neg == true then
                                    other_card:set_edition('e_negative')
                                    neg = false
                            end
                        end
                    other_card.ability['mail'] = true --Delivered by mail
                    end
                end
            end
            
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}

--[[
SMODS.Joker {
    key = "item15",-- space mail
    atlas = "items",
    pos = {
        x = 0,
        y = 0
    },
    config = { extra = { rcard = nil } },
    rarity = 3,
    cost = 10,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
     rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self, card)
            card:set_edition('e_foil',true,true)
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,


        add_to_deck = function(self, card, from_debuff) 
            -- Item effect       
            for k, v in pairs(G.jokers.cards) do
                if v.config.center.rarity == 1 then
                    if not ( v.edition and v.edition.key == "e_negative") then
                        v:set_edition('e_negative')
                        break
                    end
                end
           end
            
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}
--]]
SMODS.Joker {
    key = "item15",-- grass mail
    atlas = "items",
    pos = {
        x = 5,
        y = 1
    },
    rarity = 3,
    cost = 5,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
     rental_compat = false,
     no_edition = true,
    config = { extra = { set = true } },
        set_ability = function(self,card)
                    ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,


        add_to_deck = function(self, card, from_debuff) 
            -- Item effect
            local neg = true
                for _, playing_card in ipairs(G.playing_cards) do
                    if (playing_card.base.suit == 'Clubs') then
                        local _suit = pseudorandom_element({'Hearts','Spades','Diamonds'})
                        SMODS.change_base(playing_card, _suit)
                        if card.edition and card.edition.key == 'e_pokes_item_foil' then
                                playing_card.ability.perma_bonus = 50 + playing_card.ability.perma_bonus
                            elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                                playing_card.ability.perma_mult = 10 + playing_card.ability.perma_mult
                            elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                                local xmult = math.pow( 0.5, playing_card.ability.perma_x_mult + 1 )
                                xmult = math.floor(xmult * 100 + 0.5) / 100
                                playing_card.ability.perma_x_mult = xmult + playing_card.ability.perma_x_mult
                            elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                            and neg == true then
                                playing_card:set_edition('e_pokes_fakenegative')
                                neg = false
                        end
                    playing_card.ability['mail'] = true --Delivered by mail

                    end
                end      

            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}

SMODS.Joker {
    key = "item14",-- air mail
    atlas = "items",
    pos = {
        x = 4,
        y = 1
    },
    rarity = 3,
    cost = 5,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
     rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
                    ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,


        add_to_deck = function(self, card, from_debuff) 
            -- Item effect
            local neg = true
                for _, playing_card in ipairs(G.playing_cards) do
                    if (playing_card.base.suit == 'Diamonds') then
                        local _suit = pseudorandom_element({'Hearts','Spades','Clubs'})
                        SMODS.change_base(playing_card, _suit)
                        if card.edition and card.edition.key == 'e_pokes_item_foil' then
                                playing_card.ability.perma_bonus = 50 + playing_card.ability.perma_bonus
                            elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                                playing_card.ability.perma_mult = 10 + playing_card.ability.perma_mult
                            elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                                local xmult = math.pow( 0.5, playing_card.ability.perma_x_mult + 1 )
                                xmult = math.floor(xmult * 100 + 0.5) / 100
                                playing_card.ability.perma_x_mult = xmult + playing_card.ability.perma_x_mult
                            elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                            and neg == true then
                                playing_card:set_edition('e_pokes_fakenegative')
                                neg = false
                        end
                    playing_card.ability['mail'] = true --Delivered by mail

                    end
                end            
            

            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}
SMODS.Joker {
    key = "item16",-- flame mail
    atlas = "items",
    pos = {
        x = 6,
        y = 1
    },
    rarity = 3,
    cost = 5,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
     rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
                    ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,


        add_to_deck = function(self, card, from_debuff) 
            -- Item effect
            local neg = true
                for _, playing_card in ipairs(G.playing_cards) do
                    if (playing_card.base.suit == 'Hearts') then
                        local _suit = pseudorandom_element({'Diamonds','Spades','Clubs'})
                        SMODS.change_base(playing_card, _suit)
                        if card.edition and card.edition.key == 'e_pokes_item_foil' then
                                playing_card.ability.perma_bonus = 50 + playing_card.ability.perma_bonus
                            elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                                playing_card.ability.perma_mult = 10 + playing_card.ability.perma_mult
                            elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                                local xmult = math.pow( 0.5, playing_card.ability.perma_x_mult + 1 )
                                xmult = math.floor(xmult * 100 + 0.5) / 100
                                playing_card.ability.perma_x_mult = xmult + playing_card.ability.perma_x_mult
                            elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                            and neg == true then
                                playing_card:set_edition('e_pokes_fakenegative')
                                neg = false
                        end
                    playing_card.ability['mail'] = true --Delivered by mail

                    end
                end      

            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}

SMODS.Joker {
    key = "item17",-- snow mail
    atlas = "items",
    pos = {
        x = 7,
        y = 1
    },
    rarity = 3,
    cost = 5,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
     rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
                    ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,


        add_to_deck = function(self, card, from_debuff) 
            -- Item effect
            local neg = true
                for _, playing_card in ipairs(G.playing_cards) do
                    if (playing_card.base.suit == 'Spades') then
                        local _suit = pseudorandom_element({'Hearts','Diamonds','Clubs'})
                        SMODS.change_base(playing_card, _suit)
                        if card.edition and card.edition.key == 'e_pokes_item_foil' then
                                playing_card.ability.perma_bonus = 50 + playing_card.ability.perma_bonus
                            elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                                playing_card.ability.perma_mult = 10 + playing_card.ability.perma_mult
                            elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                                local xmult = math.pow( 0.5, playing_card.ability.perma_x_mult + 1 )
                                xmult = math.floor(xmult * 100 + 0.5) / 100
                                playing_card.ability.perma_x_mult = xmult + playing_card.ability.perma_x_mult
                            elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                            and neg == true then
                                playing_card:set_edition('e_pokes_fakenegative')
                                neg = false
                        end
                    playing_card.ability['mail'] = true --Delivered by mail

                    end
                end      

            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}

SMODS.Joker {
    key = "item18",-- tunnel mail
    atlas = "items",
    pos = {
        x = 8,
        y = 1
    },
    rarity = 3,
    cost = 5,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
     rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
            ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,


        add_to_deck = function(self, card, from_debuff) 
            -- Item effect
            local neg = true

                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                    for _, _card in pairs(G.playing_cards) do
                        if _card then
                            if not next(SMODS.get_enhancements(_card)) then
                                _card:set_ability('m_bonus')

                                
                                if card.edition and card.edition.key == 'e_pokes_item_foil' then
                                        _card.ability.perma_bonus = 50 + _card.ability.perma_bonus
                                    elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                                        _card.ability.perma_mult = 10 + _card.ability.perma_mult
                                    elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                                        local xmult = math.pow( 0.5, _card.ability.perma_x_mult + 1 )
                                        xmult = math.floor(xmult * 100 + 0.5) / 100
                                        _card.ability.perma_x_mult = xmult + _card.ability.perma_x_mult
                                    elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                                    and neg == true then
                                        _card:set_edition('e_pokes_fakenegative')
                                        neg = false
                                end
                            _card.ability['mail'] = true --Delivered by mail
                            end
                        end
                    end
                    G.hand:change_size(-1)
                    return true
                    end
                }))

            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}
SMODS.Joker {
    key = "item19",-- bloom mail
    atlas = "items",
    pos = {
        x = 9,
        y = 1
    },
    rarity = 3,
    cost = 5,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
     rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
            ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,


        add_to_deck = function(self, card, from_debuff) 
            -- Item effect
            local neg = true
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                    for _, _card in pairs(G.playing_cards) do
                        if _card then
                            if not next(SMODS.get_enhancements(_card)) then
                                _card:set_ability('m_mult')
                                
                                
                                if card.edition and card.edition.key == 'e_pokes_item_foil' then
                                        _card.ability.perma_bonus = 50 + _card.ability.perma_bonus
                                    elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                                        _card.ability.perma_mult = 10 + _card.ability.perma_mult
                                    elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                                        local xmult = math.pow( 0.5, _card.ability.perma_x_mult + 1 )
                                        xmult = math.floor(xmult * 100 + 0.5) / 100
                                        _card.ability.perma_x_mult = xmult + _card.ability.perma_x_mult
                                    elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                                    and neg == true then
                                        _card:set_edition('e_pokes_fakenegative')
                                        neg = false
                                end
                            _card.ability['mail'] = true --Delivered by mail
                            end
                        end
                    end
                    G.hand:change_size(-1)
                    return true
                    end
                }))

            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}
SMODS.Joker {
    key = "item20",-- mosaic mail
    atlas = "items",
    pos = {
        x = 0,
        y = 2
    },
    rarity = 3,
    cost = 5,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
     rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
            ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,


        add_to_deck = function(self, card, from_debuff) 
            -- Item effect
            local neg = true
            local card_changed
            function edition_get(_card)
                if not _card.edition then
                    local random_edition = SMODS.poll_edition { guaranteed = true, no_negative = true } 
                    _card:set_edition(random_edition)
                    _card.ability['mail'] = true --Delivered by mail
                end

                if card.edition and card_changed == false then 
                    if card.edition.key == 'e_pokes_item_foil' 
                     and card_changed == false then
                                        _card.ability.perma_bonus = 50 + _card.ability.perma_bonus
                                    elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                                        _card.ability.perma_mult = 10 + _card.ability.perma_mult
                                    elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                                        local xmult = math.pow( 0.5, _card.ability.perma_x_mult + 1 )
                                        xmult = math.floor(xmult * 100 + 0.5) / 100
                                        _card.ability.perma_x_mult = xmult + _card.ability.perma_x_mult
                                    elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                                    and neg == true then
                                        _card:set_edition('e_pokes_fakenegative')
                                        neg = false
                    end
                    card_changed = true
                end
            end

        G.E_MANAGER:add_event(Event({
            trigger = 'immediate',
            func = function()
            for _, _card in pairs(G.playing_cards) do
                if _card then
                    card_changed = false
                    if next(SMODS.get_enhancements(_card)) then
                        local random_enhancement = SMODS.poll_enhancement {guaranteed = true}
                        _card:set_ability(random_enhancement)
                        edition_get(_card)
                    end
                    if _card.seal then
                        local random_seal = SMODS.poll_seal {guaranteed = true}
                        _card:set_seal(random_seal)
                        edition_get(_card)
                    end
                end
            end
            return true
            end
        }))

            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}

SMODS.Joker {
    key = "item21",-- steel mail
    atlas = "items",
    pos = {
        x = 1,
        y = 2
    },
    rarity = 3,
    cost = 5,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
     rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
            ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,


        add_to_deck = function(self, card, from_debuff) 
            -- Item effect
            local neg = true

        G.E_MANAGER:add_event(Event({
            func = function()    
                card:set_edition('e_pokes_item_poly',true,true)
            local new_cards = {}
            for _, playing_card in ipairs(G.playing_cards) do
                if not (playing_card == nil) and not (next(SMODS.get_enhancements(playing_card)) == 'm_steel') then

                        G.deck.config.card_limit = G.deck.config.card_limit + 1
                        local _card = copy_card( playing_card , nil, nil, nil)
                        _card:set_ability('m_steel')
                        _card:add_to_deck()
                        
                        table.insert(G.playing_cards, _card)   
                        G.deck:emplace(_card)  
                        _card:start_materialize()
                        
                        new_cards[#new_cards + 1] = _card

                            if card.edition and card.edition.key == 'e_pokes_item_foil' then
                                _card.ability.perma_bonus = 50 + _card.ability.perma_bonus
                            elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                                _card.ability.perma_mult = 10 + _card.ability.perma_mult
                            elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                                local xmult = math.pow( 0.5, _card.ability.perma_x_mult + 1 )
                                xmult = math.floor(xmult * 100 + 0.5) / 100
                                _card.ability.perma_x_mult = xmult + _card.ability.perma_x_mult
                            elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                            and neg == true then
                                _card:set_edition('e_pokes_fakenegative')
                                neg = false
                            end
                        _card.ability['mail'] = true --Delivered by mail
                    end
            end
            SMODS.calculate_context({ playing_card_added = true, cards = new_cards })
            return true

            end
        }))

            
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}

SMODS.Joker {
    key = "item22",-- bead mail
    atlas = "items",
    pos = {
        x = 2,
        y = 2
    },
    rarity = 2,
    cost = 3,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
     rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
            ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,


        add_to_deck = function(self, card, from_debuff) 

        -- Item effect
        local neg = true
        local rcards = {}
        for _, playing_card in ipairs(G.playing_cards) do
            if not next(SMODS.get_enhancements(playing_card)) then
                rcards[#rcards + 1] = playing_card
            end
        end
        if rcards then
            local j = G.GAME.hands['Three of a Kind'].level
            for i=1,j do
                local _card = pseudorandom_element(rcards)
                _card:set_ability('m_gold')

                if card.edition and card.edition.key == 'e_pokes_item_foil' then
                                _card.ability.perma_bonus = 50 + _card.ability.perma_bonus
                            elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                                _card.ability.perma_mult = 10 + _card.ability.perma_mult
                            elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                                local xmult = math.pow( 0.5, _card.ability.perma_x_mult + 1 )
                                xmult = math.floor(xmult * 100 + 0.5) / 100
                                _card.ability.perma_x_mult = xmult + _card.ability.perma_x_mult
                            elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                            and neg == true then
                                _card:set_edition('e_pokes_fakenegative')
                                neg = false
                end
                _card.ability['mail'] = true --Delivered by mail             
            end
        end

            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}


SMODS.Joker {
    key = "item24",-- orange mail
    atlas = "items",
    pos = {
        x = 4,
        y = 2
    },
    rarity = 2,
    cost = 3,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
     rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
            ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,


        add_to_deck = function(self, card, from_debuff) 

        -- Item effect
        local neg = true
        local rcards = {}
        for _, playing_card in ipairs(G.playing_cards) do
            if not next(SMODS.get_enhancements(playing_card)) then
                rcards[#rcards + 1] = playing_card
            end
        end
        if rcards then
            local j = G.GAME.hands['Straight Flush'].level
            for i=1,j do
                local _card = pseudorandom_element(rcards)
                _card:set_ability('m_lucky')

                if card.edition and card.edition.key == 'e_pokes_item_foil' then
                                _card.ability.perma_bonus = 50 + _card.ability.perma_bonus
                            elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                                _card.ability.perma_mult = 10 + _card.ability.perma_mult
                            elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                                local xmult = math.pow( 0.5, _card.ability.perma_x_mult + 1 )
                                xmult = math.floor(xmult * 100 + 0.5) / 100
                                _card.ability.perma_x_mult = xmult + _card.ability.perma_x_mult
                            elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                            and neg == true then
                                _card:set_edition('e_pokes_fakenegative')
                                neg = false
                end
                _card.ability['mail'] = true --Delivered by mail             
            end
        end
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}
SMODS.Joker {
    key = "item25",-- mech mail
    atlas = "items",
    pos = {
        x = 5,
        y = 2
    },
    rarity = 2,
    cost = 3,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
     rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
            ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,

        add_to_deck = function(self, card, from_debuff) 
        -- Item effect
        local neg = true
        for i=1,3 do
            local rcards = {}
            local active = false
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:get_id() < 10 then
                    rcards[#rcards + 1] = playing_card
                    active = true
                end
            end
            if active == true then
                local _card = pseudorandom_element(rcards)
                SMODS.modify_rank(_card, 2)

                
                if card.edition and card.edition.key == 'e_pokes_item_foil' then
                                _card.ability.perma_bonus = 50 + _card.ability.perma_bonus
                            elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                                _card.ability.perma_mult = 10 + _card.ability.perma_mult
                            elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                                local xmult = math.pow( 0.5, _card.ability.perma_x_mult + 1 )
                                xmult = math.floor(xmult * 100 + 0.5) / 100
                                _card.ability.perma_x_mult = xmult + _card.ability.perma_x_mult
                            elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                            and neg == true then
                                _card:set_edition('e_pokes_fakenegative')
                                neg = false
                end 
                _card.ability['mail'] = true --Delivered by mail
            end
        end

            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}
SMODS.Joker {
    key = "item26",-- harbor mail
    atlas = "items",
    pos = {
        x = 6,
        y = 2
    },
    rarity = 2,
    cost = 3,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
    rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
            ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,




        add_to_deck = function(self, card, from_debuff) 
        -- Item effect
        local active = false
        local rcards = {}
        local neg = true
        for _, playing_card in ipairs(G.playing_cards) do
            rcards[#rcards + 1] = playing_card
            active = true
        end
        if active == true then
            for i=1,2 do
                    local _card = pseudorandom_element(rcards)
                    _card.ability.perma_bonus = (_card.ability.perma_bonus or 0) + 20

                    
                if card.edition and card.edition.key == 'e_pokes_item_foil' then
                                _card.ability.perma_bonus = 50 + _card.ability.perma_bonus
                            elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                                _card.ability.perma_mult = 10 + _card.ability.perma_mult
                            elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                                local xmult = math.pow( 0.5, _card.ability.perma_x_mult + 1 )
                                xmult = math.floor(xmult * 100 + 0.5) / 100
                                _card.ability.perma_x_mult = xmult + _card.ability.perma_x_mult
                            elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                            and neg == true then
                                _card:set_edition('e_pokes_fakenegative')
                                neg = false
                end
                _card.ability['mail'] = true --Delivered by mail
            end
        end

            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}
SMODS.Joker {
    key = "item27",-- dream mail
    atlas = "items",
    pos = {
        x = 7,
        y = 2
    },
    rarity = 2,
    cost = 3,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
    rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
            ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,

        add_to_deck = function(self, card, from_debuff) 
        -- Item effect
        local active = false
        local rcards = {}
        local neg = true
        for _, playing_card in ipairs(G.playing_cards) do
            rcards[#rcards + 1] = playing_card
            active = true
        end
        if active == true then
            for i=1,2 do
                    local _card = pseudorandom_element(rcards)
                    _card.ability.perma_mult = (_card.ability.perma_mult or 0) + 3

                     
                if card.edition and card.edition.key == 'e_pokes_item_foil' then
                                _card.ability.perma_bonus = 50 + _card.ability.perma_bonus
                            elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                                _card.ability.perma_mult = 10 + _card.ability.perma_mult
                            elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                                local xmult = math.pow( 0.5, _card.ability.perma_x_mult + 1 )
                                xmult = math.floor(xmult * 100 + 0.5) / 100
                                _card.ability.perma_x_mult = xmult + _card.ability.perma_x_mult
                            elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                            and neg == true then
                                _card:set_edition('e_pokes_fakenegative')
                                neg = false
                end
                _card.ability['mail'] = true --Delivered by mail
            end
        end

            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}
SMODS.Joker {
    key = "item33",-- surf mail
    atlas = "items",
    pos = {
        x = 0,
        y = 3
    },
    rarity = 1,
    cost = 1,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
    rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self, card)
            ITEM_ANTY_RENTAL(card)
            card:set_edition('e_pokes_item',true,true)
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,

        add_to_deck = function(self, card, from_debuff) 
        -- Item effect
        local booster_key = pseudorandom_element({ 'p_pokes_pkmn_pack1','p_pokes_pkmn_pack2','p_pokes_pkmn_pack3','p_pokes_pkmn_pack4',
                                                   "p_pokes_pkmn_mail1","p_pokes_pkmn_mail2",
                                                   'p_pokes_trainer_pack1', 'p_pokes_trainer_pack2' })
        SMODS.add_booster_to_shop(booster_key)

            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}
SMODS.Joker {
    key = "item28",-- bluesky mail
    atlas = "items",
    pos = {
        x = 1,
        y = 3
    },
    rarity = 1,
    cost = 1,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
    rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
            ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,

        add_to_deck = function(self, card, from_debuff) 
        -- Item effect
        local ed
        if card.edition then
                if card.edition.key == 'e_pokes_item_foil' then
                    ed = 'e_foil'
                elseif card.edition.key == 'e_pokes_item_holo' then
                    ed = 'e_holo'
                elseif card.edition.key == 'e_pokes_item_poly' then
                    ed = 'e_polychrome'
                elseif card.edition.key == 'e_pokes_item_negative' then
                    ed = 'e_negative'
                end
        end

        for i=1,2 do
            local _rarity = pseudorandom_element({'pokes_Heart','pokes_Club','pokes_Spade','pokes_Diamond'})

            local _card
            if card.edition == nil then
                _card = SMODS.create_card {
                    set = "Joker",
                    rarity = _rarity,
                    area = G.shop_jokers,
                    key_append = "pokes_bluesky"
                }
            else 
                _card = SMODS.create_card {
                    set = "Joker",
                    rarity = _rarity,
                    edition = ed,
                    area = G.shop_jokers,
                    key_append = "pokes_bluesky"
                }
            end

            G.shop_jokers:emplace(_card)
            create_shop_card_ui(_card, 'Joker', G.shop_jokers)
        end

            --Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
           }))    

    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}
SMODS.Joker {
    key = "item29",-- eon mail
    atlas = "items",
    pos = {
        x = 2,
        y = 3
    },
    rarity = 1,
    cost = 1,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
    rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
            ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,

        add_to_deck = function(self, card, from_debuff) 
        -- Item effect
            local neg = true
            
            for i=1,2 do
            SMODS.add_card{
                 --   set = "Base",--"Playing Card", 
                    suit = 'Hearts',
                    area = G.deck
                }

            if card.edition and card.edition.key == 'e_pokes_item_foil' then
                        G.deck.cards[1].ability.perma_bonus = 50 + G.deck.cards[1].ability.perma_bonus
                    elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                        G.deck.cards[1].ability.perma_mult = 10 + G.deck.cards[1].ability.perma_mult
                    elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                            local xmult = math.pow( 0.5, G.deck.cards[1].ability.perma_x_mult + 1 )
                            xmult = math.floor(xmult * 100 + 0.5) / 100
                            G.deck.cards[1].ability.perma_x_mult = xmult + G.deck.cards[1].ability.perma_x_mult
                    elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                    and neg == true then
                        G.deck.cards[1]:set_edition('e_pokes_fakenegative')
                        neg = false
            end     
            G.deck.cards[1].ability['mail'] = true --Delivered by mail    
            end

            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
        
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}
SMODS.Joker {
    key = "item30",-- flower mail
    atlas = "items",
    pos = {
        x = 3,
        y = 3
    },
    rarity = 1,
    cost = 1,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
    rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
            ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,

        add_to_deck = function(self, card, from_debuff) 
        -- Item effect
            local neg = true
            
            for i=1,2 do
            SMODS.add_card{
                   -- set = "Base",--"Playing Card", 
                    suit = 'Clubs',
                    area = G.deck
                }
 
                if card.edition and card.edition.key == 'e_pokes_item_foil' then
                        G.deck.cards[1].ability.perma_bonus = 50 + G.deck.cards[1].ability.perma_bonus
                    elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                        G.deck.cards[1].ability.perma_mult = 10 + G.deck.cards[1].ability.perma_mult
                    elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                            local xmult = math.pow( 0.5, G.deck.cards[1].ability.perma_x_mult + 1 )
                            xmult = math.floor(xmult * 100 + 0.5) / 100
                            G.deck.cards[1].ability.perma_x_mult = xmult + G.deck.cards[1].ability.perma_x_mult
                    elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                    and neg == true then
                        G.deck.cards[1]:set_edition('e_pokes_fakenegative')
                        neg = false
                end
            G.deck.cards[1].ability['mail'] = true --Delivered by mail  
            end
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
        
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}
SMODS.Joker {
    key = "item31",-- morph mail
    atlas = "items",
    pos = {
        x = 4,
        y = 3
    },
    rarity = 1,
    cost = 1,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
    rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
            ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,

        add_to_deck = function(self, card, from_debuff) 
        -- Item effect
        local neg = true

            for i=1,2 do
            SMODS.add_card{
                   -- set = "Base",--"Playing Card", 
                    suit = 'Spades',
                    area = G.deck
                }
 
                if card.edition and card.edition.key == 'e_pokes_item_foil' then
                        G.deck.cards[1].ability.perma_bonus = 50 + G.deck.cards[1].ability.perma_bonus
                    elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                        G.deck.cards[1].ability.perma_mult = 10 + G.deck.cards[1].ability.perma_mult
                    elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                            local xmult = math.pow( 0.5, G.deck.cards[1].ability.perma_x_mult + 1 )
                            xmult = math.floor(xmult * 100 + 0.5) / 100
                            G.deck.cards[1].ability.perma_x_mult = xmult + G.deck.cards[1].ability.perma_x_mult
                    elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                    and neg == true then
                        G.deck.cards[1]:set_edition('e_pokes_fakenegative')
                        neg = false
                end
            G.deck.cards[1].ability['mail'] = true --Delivered by mail  
            end

            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
        
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}
SMODS.Joker {
    key = "item32",-- music mail
    atlas = "items",
    pos = {
        x = 5,
        y = 3
    },
    rarity = 1,
    cost = 1,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
    rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
            ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,

        add_to_deck = function(self, card, from_debuff) 
        -- Item effect
            local neg = true
            
            for i=1,2 do
            SMODS.add_card{
                    --set = "Base",--"Playing Card", 
                    suit = 'Diamonds',
                    area = G.deck
                }
 
                if card.edition and card.edition.key == 'e_pokes_item_foil' then
                        G.deck.cards[1].ability.perma_bonus = 50 + G.deck.cards[1].ability.perma_bonus
                    elseif card.edition and card.edition.key == 'e_pokes_item_holo' then
                        G.deck.cards[1].ability.perma_mult = 10 + G.deck.cards[1].ability.perma_mult
                    elseif card.edition and card.edition.key == 'e_pokes_item_poly' then
                            local xmult = math.pow( 0.5, G.deck.cards[1].ability.perma_x_mult + 1 )
                            xmult = math.floor(xmult * 100 + 0.5) / 100
                            G.deck.cards[1].ability.perma_x_mult = xmult + G.deck.cards[1].ability.perma_x_mult
                    elseif card.edition and card.edition.key == 'e_pokes_item_negative' 
                    and neg == true then
                        G.deck.cards[1]:set_edition('e_pokes_fakenegative')
                        neg = false
                end

                G.deck.cards[1].ability['mail'] = true --Delivered by mail
                end

            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
        
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}
SMODS.Joker {
    key = "item34",-- greet mail
    atlas = "items",
    pos = {
        x = 6,
        y = 3
    },
    rarity = 1,
    cost = 1,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
    rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
            ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,

        add_to_deck = function(self, card, from_debuff) 
        -- Item effect
            local ed
            if card.edition then
                if card.edition.key == 'e_pokes_item_foil' then
                    ed = 'e_foil'
                elseif card.edition.key == 'e_pokes_item_holo' then
                    ed = 'e_holo'
                elseif card.edition.key == 'e_pokes_item_poly' then
                    ed = 'e_polychrome'
                elseif card.edition.key == 'e_pokes_item_negative' then
                    ed = 'e_negative'
                end
            end

        if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then   
            if card.edition == nil then
                SMODS.add_card {
                    set = "Joker",
                    rarity = "pokes_Diamond",
                }
            else 
                SMODS.add_card {
                    set = "Joker",
                    rarity = "pokes_Diamond",
                    edition = ed,
                }
            end
        end
            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
        
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}
SMODS.Joker {
    key = "item35",-- rvsp  mail
    atlas = "items",
    pos = {
        x = 7,
        y = 3
    },
    rarity = 1,
    cost = 1,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
    rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
            ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,

        add_to_deck = function(self, card, from_debuff) 
        -- Item effect
            local ed
            if card.edition then
                if card.edition.key == 'e_pokes_item_foil' then
                    ed = 'e_foil'
                elseif card.edition.key == 'e_pokes_item_holo' then
                    ed = 'e_holo'
                elseif card.edition.key == 'e_pokes_item_poly' then
                    ed = 'e_polychrome'
                elseif card.edition.key == 'e_pokes_item_negative' then
                    ed = 'e_negative'
                end
            end

        if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then    
            if card.edition == nil then        
                SMODS.add_card {
                    set = "Joker",
                    rarity = "pokes_Heart",
                }
            else      
                SMODS.add_card {
                    set = "Joker",
                    rarity = "pokes_Heart",
                    edition = ed,
                }
            end
        end

            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
        
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}
SMODS.Joker {
    key = "item36",-- like mail
    atlas = "items",
    pos = {
        x = 8,
        y = 3
    },
    rarity = 1,
    cost = 1,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
    rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
            ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,

        add_to_deck = function(self, card, from_debuff) 
        -- Item effect
            local ed
            if card.edition then
                if card.edition.key == 'e_pokes_item_foil' then
                    ed = 'e_foil'
                elseif card.edition.key == 'e_pokes_item_holo' then
                    ed = 'e_holo'
                elseif card.edition.key == 'e_pokes_item_poly' then
                    ed = 'e_polychrome'
                elseif card.edition.key == 'e_pokes_item_negative' then
                    ed = 'e_negative'
                end
            end

        if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
            if card.edition == nil then
                SMODS.add_card {
                    set = "Joker",
                    rarity = "pokes_Spade",
                }
            else 
                SMODS.add_card {
                    set = "Joker",
                    rarity = "pokes_Spade",
                    edition = ed,
                }
            end
        end

            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
        
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}
SMODS.Joker {
    key = "item37",-- favored  mail
    atlas = "items",
    pos = {
        x = 9,
        y = 3
    },
    rarity = 1,
    cost = 1,
    blueprint_compat = false,
    discovered = true,
    eternal_compat = false,
    perishable_compat = false,
    rental_compat = false,
    config = { extra = { set = true } },
        set_ability = function(self,card)
            ITEM_ANTY_RENTAL(card)
                    G.E_MANAGER:add_event(Event({
                        
                        func = function()
                            if card.edition and card.edition.key == 'e_foil' then
                                card:set_edition('e_pokes_item_foil',true,true)
                            elseif card.edition and card.edition.key == 'e_holo' then
                                card:set_edition('e_pokes_item_holo',true,true)
                            elseif card.edition and card.edition.key == 'e_polychrome' then
                                card:set_edition('e_pokes_item_poly',true,true)
                            elseif card.edition and card.edition.key == 'e_negative' then
                                card:set_edition('e_pokes_item_negative',true,true)
                            elseif card.edition == nil then 
                                card:set_edition('e_pokes_item',true,true)
                            end
                            return true
                        end
                    }))
        end,
        get_weight = function(self)
        	return {  weight = 0.5 }--0.1 * self.weight
        end,

        add_to_deck = function(self, card, from_debuff) 
        -- Item effect
            local ed
            if card.edition then
                if card.edition.key == 'e_pokes_item_foil' then
                    ed = 'e_foil'
                elseif card.edition.key == 'e_pokes_item_holo' then
                    ed = 'e_holo'
                elseif card.edition.key == 'e_pokes_item_poly' then
                    ed = 'e_polychrome'
                elseif card.edition.key == 'e_pokes_item_negative' then
                    ed = 'e_negative'
                end
            end
            
                    if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
                        if card.edition == nil then
                            SMODS.add_card {
                                set = "Joker",
                                rarity = "pokes_Club",
                            }
                        else
                            SMODS.add_card {
                                set = "Joker",
                                rarity = "pokes_Club",
                                edition = ed
                            }
                        end
                    end

            -- Destroy itself afterwards
            G.E_MANAGER:add_event(Event({
            blockable = false,
            
            func = function()
                SMODS.destroy_cards(card, nil, nil, true)
            return true
            end
        }))
        
    end,

    in_pool = function(self, args)
        return not args or args.source == "sho" or args.source == 'buf' -- Don't appear from Judgment etc.
        or args.source == "pokes_mail1" or args.source == "pokes_mail2" or args.source == 'rta' or args.source == 'uta'
    end

}