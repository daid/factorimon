if settings.global["fm-debug"].value then

    script.on_init(function()
        --Do not have enemies attack the player.
        --Players can still attack enemies.
        game.forces["enemy"].set_cease_fire(game.forces["player"], true)
    end)

    --Replace our starting ammo with stun ammo.
    script.on_event(defines.events.on_player_created, function(event)
        local player = game.players[event.player_index]
        player.insert{name="fm-stun-ammo", count=player.remove_item{name="firearm-magazine", count=player.get_item_count("firearm-magazine")}}

        --When debugging is enabled, give the player some starting equipment to quickly get going in testing things.
        player.insert("fm-breeder")
        player.insert("fm-arena")
        player.insert("solar-panel")
        player.insert("small-electric-pole")
        player.insert("fm-hatchery")
        player.insert("fm-alien-sensor")
        player.insert("stone-wall")
        player.insert("fm-stunned-small-biter-MA")
        player.insert("fm-stunned-small-biter-FA")
        
        player.insert("iron-plate")
        player.insert("copper-plate")
        player.insert("steel-plate")
        player.insert("electronic-circuit")
        player.insert("iron-gear-wheel")
    end)
    script.on_event(defines.events.on_player_respawned, function(event)
        local player = game.players[event.player_index]
        player.insert{name="fm-stun-ammo", count=player.remove_item{name="firearm-magazine", count=player.get_item_count("firearm-magazine")}}
    end)

end
