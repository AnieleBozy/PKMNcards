SMODS.Rarity {
    key = "Normal",
    default_weight = 0.35,
    badge_colour = HEX('BCC9DA'),
    pools = {["Joker"] = true},
    get_weight = function(self, weight, object_type)
        return weight
    end,
}
SMODS.Rarity {
    key = "Heart",
    default_weight = 0.35,
    badge_colour = G.C.SUITS.Hearts,
    pools = {["Joker"] = true},
    get_weight = function(self, weight, object_type)
        return weight
    end,
}
SMODS.Rarity {
    key = "Diamond",
    default_weight = 0.35,
    badge_colour = G.C.SUITS.Diamonds,
    pools = {["Joker"] = true},
    get_weight = function(self, weight, object_type)
        return weight
    end,
}
SMODS.Rarity {
    key = "Spade",
    default_weight = 0.35,
    badge_colour = G.C.SUITS.Spades,
    pools = {["Joker"] = true},
    get_weight = function(self, weight, object_type)
        return weight
    end,
}
SMODS.Rarity {
    key = "Club",
    default_weight = 0.35,
    badge_colour = G.C.SUITS.Clubs,
    pools = {["Joker"] = true},
    get_weight = function(self, weight, object_type)
        return weight
    end,
}
SMODS.Rarity {
    key = "Dragon",
    default_weight = 0,
    badge_colour = G.C.MONEY,
    pools = {["Joker"] = true},
    get_weight = function(self, weight, object_type)
        return weight
    end,
}
--[[
SMODS.Rarity {
    key = "Evolution",
    default_weight = 0,
    badge_colour = HEX('83F1F7'),
    --pools = {["Joker"] = true},
    get_weight = function(self, weight, object_type)
        return weight
    end,
} --]]