function GET_SUIT(suit)
    if suit == 'Hearts' then
        return 1
    elseif suit == 'Diamonds' then
        return 2
    elseif suit == 'Spades' then
        return 3
    elseif suit == 'Clubs' then
        return 4
    elseif suit == 'Normal' then
        return 0
    elseif suit == 'Dragon' then
        return 5
    elseif suit == 'Baby' then
        return 6
    end
end

function ENERGY_MOVE(energy, suit, max)
    local energy4 = {}
    local energyp
    local energytxt
    local suitx
    local suity

    suitx = GET_SUIT(suit)
    if energy >= max then
        suity = 0
    else
        suity = 1
    end

    if max > 4 then
        energytxt = {n=G.UIT.T, config={text = tostring(max)..'x', colour = G.C.UI.TEXT_DARK, scale = 0.24, font = G.FONTS[8]}}
        energyp = {n = G.UIT.O, config = { object = SMODS.create_sprite( 0, 0, 0.3, 0.3, "pokes_suitSprite", {x = suitx, y = suity} ) } }
        return {n = G.UIT.C, config = {w=1, h=1}, nodes = { 
            {n = G.UIT.R, config = { h=1, w=4, padding = 0.08}, nodes = { 
                energytxt, energyp
            }}
         }}
    end

    for i = 1, max, 1 do
        if energy >= i then
            suity = 0
        else
            suity = 1
        end
        table.insert(energy4, {n = G.UIT.O, config = { object = SMODS.create_sprite( 0, 0, 0.3, 0.3, "pokes_suitSprite", {x = suitx, y = suity} ) } })
    end
    return {n = G.UIT.C, config = {w=1, h=1}, nodes = { 
            {n = G.UIT.R, config = { h=1, w=4, padding = 0.08}, nodes = 
            energy4
            }
         }}
end

function ENERGY_CURRENT(energy, suit)
    local energies = {}
    local energytxt
    local energyp
    local suitx = GET_SUIT(suit)
    if energy <= 4 then
        for i = 1, energy, 1 do
           table.insert(energies, {n = G.UIT.O, config = { object = SMODS.create_sprite( 0, 0, 0.3, 0.3, "pokes_suitSprite", {x = suitx, y = 0} ) } })
        end
        return {n = G.UIT.C, config = {w=1, h=1}, nodes = { 
            {n = G.UIT.R, config = { h=1, w=4, padding = 0.08}, nodes = 
                energies
            }
         }}
    elseif energy > 4 then
        energytxt = {n=G.UIT.T, config={text = tostring(energy)..'x', colour = G.C.UI.TEXT_DARK, scale = 0.24, font = G.FONTS[8] , }}
        energyp = {n = G.UIT.O, config = { object = SMODS.create_sprite( 0, 0, 0.3, 0.3, "pokes_suitSprite", {x = suitx, y = 0} ) } }
        return {n = G.UIT.C, config = {w=1, h=1,}, nodes = { 
            {n = G.UIT.R, config = { h=1, w=4, padding = 0.08}, nodes = { 
                energytxt, energyp
            }}
         },  }
    end
end

function ENERGY_RESET(context, card) 
    if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and card.ability.extra.energy > 0 then
        card.ability.extra.energy = 0
        if card.ability.extra.activem1 then
            card.ability.extra.activem1 = false
        end
        if card.ability.extra.activem2 then
            card.ability.extra.activem2 = false
        end
    end
    return card
end

function DRAGON_MOVE(energies, suits, costs)
    local energy4 = {}
    local suitx
    local suity

    for i=1,(#costs),1  do
        local suit = suits[i]
        local max = costs[i]
        local energy = energies[i]

        suitx = GET_SUIT(suit)
        if energy >= max then
            suity = 0
        else
            suity = 1
        end

        if max > 4 then
            table.insert(energy4, {n=G.UIT.T, config={text = tostring(max)..'x', colour = G.C.UI.TEXT_DARK, scale = 0.24, font = G.FONTS[8]}})
            table.insert(energy4, {n = G.UIT.O, config = { object = SMODS.create_sprite( 0, 0, 0.3, 0.3, "pokes_suitSprite", {x = suitx, y = suity} ) } })
        else

            for i = 1, max, 1 do
                if energy >= i then
                    suity = 0
                else
                    suity = 1
                end
                table.insert(energy4, {n = G.UIT.O, config = { object = SMODS.create_sprite( 0, 0, 0.3, 0.3, "pokes_suitSprite", {x = suitx, y = suity} ) } })
            end

        end
    end
        return {n = G.UIT.C, config = {w=1, h=1}, nodes = { 
                {n = G.UIT.R, config = { h=1, w=16, padding = 0.08}, nodes = 
                energy4
                }
            }}
end
function DRAGON_CURRENT(current, suits)
    local energies = {}
    local suitx
    for i=1,(#suits),1  do
        local suit = suits[i]
        local energy = current[i]

        suitx = GET_SUIT(suit)
        if energy <= 4 then
            for i = 1, energy, 1 do
            table.insert(energies, {n = G.UIT.O, config = { object = SMODS.create_sprite( 0, 0, 0.3, 0.3, "pokes_suitSprite", {x = suitx, y = 0} ) } })
            end
        elseif energy > 4 then
            table.insert(energies, {n=G.UIT.T, config={text = tostring(energy)..'x', colour = G.C.UI.TEXT_DARK, scale = 0.24, font = G.FONTS[8], }})
            table.insert(energies, {n = G.UIT.O, config = { object = SMODS.create_sprite( 0, 0, 0.3, 0.3, "pokes_suitSprite", {x = suitx, y = 0} ) } })
        end
    end
        return {n = G.UIT.C, config = {w=1, h=1}, nodes = { 
                {n = G.UIT.R, config = { h=1, w=16, padding = 0.08}, nodes = 
                energies
                }
            }}
end
function DRAGON_RESET(context, card) 
    if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and (card.ability.extra.energy > 0 or card.ability.extra.energy2 > 0) then
        card.ability.extra.energy = 0
        card.ability.extra.energy2 = 0
        if card.ability.extra.activem1 then
            card.ability.extra.activem1 = false
        end
        if card.ability.extra.activem2 then
            card.ability.extra.activem2 = false
        end
    end
    return card
end