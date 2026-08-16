function IS_POOL(stage)
        for k, v in pairs(G.jokers.cards) do
                if v.ability.extra then
                    if type(v.ability.extra) == 'table' then
                    for j, k in pairs(v.ability.extra) do
                        if v.ability.extra['stage'] == stage then
                            return true
                        end
                    end
                    end
                end
        end
        return false
end
