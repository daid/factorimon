if settings.global["fm-debug"].value then

    script.on_init(function()
        --Do not have enemies attack the player.
        --Players can still attack enemies.
        game.forces["enemy"].set_cease_fire(game.forces["player"], true)
        game.forces["player"].character_running_speed_modifier = 3.0
        game.forces["player"].manual_mining_speed_modifier = 10.0
        game.forces["player"].manual_crafting_speed_modifier = 10.0
    end)

    script.on_event(defines.events.on_player_created, function(event)
        --Replace our starting ammo with stun ammo.
        local player = game.players[event.player_index]
        player.insert{name="fm-stun-magazine", count=player.remove_item{name="firearm-magazine", count=player.get_item_count("firearm-magazine")}}

        --When debugging is enabled, give the player some starting equipment to quickly get going in testing things.
        player.insert("solar-panel")
        player.insert("small-electric-pole")
        player.insert("fm-breeder")
        player.insert("fm-arena")
        player.insert("fm-hatchery")
        player.insert("fm-alien-sensor")
        player.insert("stone-wall")
        
        player.insert("iron-plate")
        player.insert("copper-plate")
        player.insert("steel-plate")
        player.insert("electronic-circuit")
        player.insert("iron-gear-wheel")

        player.insert("fm-stunned-small-biter-MA")
        player.insert("fm-stunned-small-biter-FA")
        player.insert("fm-stunned-small-biter-MZ")
        player.insert("fm-stunned-small-biter-FZ")
    end)
end
