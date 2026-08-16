
-- The Thunder
SMODS.Blind {
    key = "thunder",
    dollars = 5,
    mult = 2,
    atlas = 'blinds',
    pos = { x = 0, y = 0 },
    boss = { min = 2 },
    discovered = true,
    boss_colour = HEX("f7cc4a"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.discard and
        context.other_card:is_suit('Diamonds')
        and pseudorandom('pokes_boss_para0',1,2) == 2 then
            context.other_card:set_ability('m_pokes_para')
            SMODS.calculate_effect({message = 'Paralyzed', }, context.other_card)
        end
    end,

}
-- The Soul
SMODS.Blind {
    key = "soul",
    dollars = 5,
    mult = 2,
    atlas = 'blinds',
    pos = { x = 1, y = 0 },
    boss = { min = 2 },
    discovered = true,
    boss_colour = HEX("fc7cd6"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.discard and
        context.other_card:is_suit('Spades') then
                    context.other_card:set_ability('m_pokes_psn')
            SMODS.calculate_effect({message = 'Poisoned', }, context.other_card)
        end
    end
}
-- The Glacier
SMODS.Blind {
    key = "glacier",
    dollars = 5,
    mult = 2,
    atlas = 'blinds',
    pos = { x = 2, y = 0 },
    boss = { min = 2 },
    discovered = true,
    boss_colour = HEX("51b3e0"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.discard and
        context.other_card:is_suit('Clubs') then
                    context.other_card:set_ability('m_pokes_freeze')
            SMODS.calculate_effect({message = 'Freezed', }, context.other_card)
        end
    end
}
-- The Volcano
SMODS.Blind {
    key = "volcano",
    dollars = 5,
    mult = 2,
    atlas = 'blinds',
    pos = { x = 3, y = 0 },
    boss = { min = 2 },
    discovered = true,
    boss_colour = HEX("d13b4a"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.discard and
        context.other_card:is_suit('Hearts') then
                    context.other_card:set_ability('m_pokes_burn')
            SMODS.calculate_effect({message = 'Burned', }, context.other_card)
        end
    end
}
-- The Plain
SMODS.Blind {
    key = "plain",
    dollars = 5,
    mult = 2,
    atlas = 'blinds',
    pos = { x = 4, y = 0 },
    boss = { min = 3 },
    discovered = true,
    boss_colour = HEX("a19d8a"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.discard and
        next(SMODS.get_enhancements(context.other_card)) then
                    context.other_card:set_ability('m_pokes_sleep')
            SMODS.calculate_effect({message = 'Yawn...', }, context.other_card)
        end
    end
}

--
-- 
--

-- The Balance
SMODS.Blind {
    key = "balance",
    dollars = 5,
    mult = 2,
    atlas = 'blinds',
    pos = { x = 4, y = 1 },
    boss = { min = 3 },
    discovered = true,
    boss_colour = HEX("8f676d"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.hand_drawn and
        G.GAME.current_round.hands_left <= 2 then
            for i,j in pairs(context.hand_drawn) do
                j:set_ability('m_pokes_sleep')  
                SMODS.calculate_effect({message = 'Yawn...', delay = 0.5 }, j)              
            end
        end
 
    end
}
-- The Hive
SMODS.Blind {
    key = "hive",
    dollars = 5,
    mult = 2,
    atlas = 'blinds',
    pos = { x = 2, y = 1 },
    boss = { min = 3 },
    discovered = true,
    boss_colour = HEX("60bf9f"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.hand_drawn and
        G.GAME.current_round.hands_left <= 2 then
            for i,j in pairs(context.hand_drawn) do
                j:set_ability('m_pokes_freeze')  
                SMODS.calculate_effect({message = 'Freezed', delay = 0.5 }, j)              
            end
        end
 
    end
}
-- The Fog
SMODS.Blind {
    key = "fog",
    dollars = 5,
    mult = 2,
    atlas = 'blinds',
    pos = { x = 1, y = 1 },
    boss = { min = 3 },
    discovered = true,
    boss_colour = HEX("5747a8"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.hand_drawn and
        G.GAME.current_round.hands_left <= 2 then
            for i,j in pairs(context.hand_drawn) do
                j:set_ability('m_pokes_psn')  
                SMODS.calculate_effect({message = 'Poisoned', delay = 0.5 }, j)              
            end
        end
 
    end
}
-- The Storm
SMODS.Blind {
    key = "storm",
    dollars = 5,
    mult = 2,
    atlas = 'blinds',
    pos = { x = 0, y = 1 },
    boss = { min = 3 },
    discovered = true,
    boss_colour = HEX("a87634"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.hand_drawn and
        G.GAME.current_round.hands_left <= 2 then
            for i,j in pairs(context.hand_drawn) do
                if pseudorandom('pokes_boss_para',1,2) == 2 then
                    j:set_ability('m_pokes_para')  
                    SMODS.calculate_effect({message = 'Paralyzed', delay = 0.5 }, j)      
                end
            end
        end
 
    end
}
-- The Mind
SMODS.Blind {
    key = "mind",
    dollars = 5,
    mult = 2,
    atlas = 'blinds',
    pos = { x = 3, y = 1 },
    boss = { min = 3 },
    discovered = true,
    boss_colour = HEX("f095dd"),
    calculate = function(self, blind, context)
        if blind.disabled then return end

        if context.hand_drawn and
        G.GAME.current_round.hands_left <= 2 then
            for i,j in pairs(context.hand_drawn) do
                j:set_ability('m_pokes_burn')  
                SMODS.calculate_effect({message = 'Burned', delay = 0.5 }, j)              
            end
        end
 
    end

}

--Porygon
-- Trick Room
SMODS.Blind {
    key = "trickroom",
    dollars = 5,
    mult = 2,
    atlas = 'blinds',
    pos = { x = 0, y = 2 },
    boss = { min = 1 },
    boss_colour = HEX("f095ee"),
    discovered = true,
    modifies_draw = true,
    calculate = function(self, blind, context)
        if blind.disabled then return end
        if context.drawing_cards and (G.GAME.current_round.hands_played ~= 0 or G.GAME.current_round.discards_used ~= 0) then
            return {
                cards_to_draw = 5
            }
        end
    end,
    in_pool = function(self)
        if G.jokers and G.jokers.cards then
        for _,v in pairs(G.jokers.cards) do
            if v.config.center.key == 'j_pokes_137' then
                return true
            end
        end
        end
        return false
    end,
}
-- Trick Room 2
SMODS.Blind {
    key = "trickrooma",
    dollars = 5,
    mult = 2,
    atlas = 'blinds',
    pos = { x = 0, y = 2 },
    boss = { min = 1 },
    boss_colour = HEX("f095ee"),
    discovered = true,
    modifies_draw = true,
    no_collection = true,
    calculate = function(self, blind, context)
        if blind.disabled then return end
        if context.drawing_cards and (G.GAME.current_round.hands_played ~= 0 or G.GAME.current_round.discards_used ~= 0) then
            return {
                cards_to_draw = 5
            }
        end
    end,
    in_pool = function(self)
        if G.jokers and G.jokers.cards then
        for _,v in pairs(G.jokers.cards) do
            if v.config.center.key == 'j_pokes_137' then
                return true
            end
        end
        end
        return false
    end,
}
-- Trick Room 3
SMODS.Blind {
    key = "trickroomb",
    dollars = 5,
    mult = 2,
    atlas = 'blinds',
    pos = { x = 0, y = 2 },
    boss = { min = 1 },
    boss_colour = HEX("f095ee"),
    discovered = true,
    modifies_draw = true,
    no_collection = true,
    calculate = function(self, blind, context)
        if blind.disabled then return end
        if context.drawing_cards and (G.GAME.current_round.hands_played ~= 0 or G.GAME.current_round.discards_used ~= 0) then
            return {
                cards_to_draw = 5
            }
        end
    end,
    in_pool = function(self)
        if G.jokers and G.jokers.cards then
        for _,v in pairs(G.jokers.cards) do
            if v.config.center.key == 'j_pokes_137' then
                return true
            end
        end
        end
        return false
    end,
}
-- Trick Room 4
SMODS.Blind {
    key = "trickroomc",
    dollars = 5,
    mult = 2,
    atlas = 'blinds',
    pos = { x = 0, y = 2 },
    boss = { min = 1 },
    boss_colour = HEX("f095ee"),
    discovered = true,
    modifies_draw = true,
    no_collection = true,
    calculate = function(self, blind, context)
        if blind.disabled then return end
        if context.drawing_cards and (G.GAME.current_round.hands_played ~= 0 or G.GAME.current_round.discards_used ~= 0) then
            return {
                cards_to_draw = 5
            }
        end
    end,
    in_pool = function(self)
        if G.jokers and G.jokers.cards then
        for _,v in pairs(G.jokers.cards) do
            if v.config.center.key == 'j_pokes_137' then
                return true
            end
        end
        end
        return false
    end,
}
-- Trick Room 5
SMODS.Blind {
    key = "trickroomd",
    dollars = 5,
    mult = 2,
    atlas = 'blinds',
    pos = { x = 0, y = 2 },
    boss = { min = 1 },
    boss_colour = HEX("f095ee"),
    discovered = true,
    modifies_draw = true,
    no_collection = true,
    calculate = function(self, blind, context)
        if blind.disabled then return end
        if context.drawing_cards and (G.GAME.current_round.hands_played ~= 0 or G.GAME.current_round.discards_used ~= 0) then
            return {
                cards_to_draw = 5
            }
        end
    end,
    in_pool = function(self)
        if G.jokers and G.jokers.cards then
        for _,v in pairs(G.jokers.cards) do
            if v.config.center.key == 'j_pokes_137' then
                return true
            end
        end
        end
        return false
    end,
}