SMODS.current_mod.config_tab = function() 

    
    return {
        n = G.UIT.ROOT,
        config = { r = 0.1, minw = 8, align = "tm", padding = 0.2, colour = G.C.BLACK },
        nodes = {
                                    create_toggle({
                                        label = 'Vanilla Jokers?',
                                        ref_table = pokes_config,
                                        ref_value = 'vanilla_jokers'
                                    })
         } 
    }

end