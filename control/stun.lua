UNIT_SEARCH_RADIUS = 0.1

script.on_event(defines.events.on_trigger_created_entity, function(event)
    if event.entity.name == "fm-stun-hit" then
        --The unit that we hit seems to be exactly on position of the hit entity. However, to future proof we do search a tiny area around it, as we have to use a find_entities anyhow.
        local position = event.entity.position
        local entities = event.entity.surface.find_entities_filtered({type="unit", area={{position.x - UNIT_SEARCH_RADIUS, position.y - UNIT_SEARCH_RADIUS}, {position.x + UNIT_SEARCH_RADIUS, position.y + UNIT_SEARCH_RADIUS}}})
        if #entities < 1 then
            return
        end
        local target = entities[1]
        --Target is now the entity that we hit. Check if it is what we want to stun.
        if not fmIsAlien(target) and target.prototype.max_health < 20 then
            local level = string.char(64 + math.random(1, 10))
            local sex = "M"
            if math.random(100) < 50 then sex = "F" end
            local stunned = target.surface.create_entity{name="fm-stunned-"..target.name.."-"..sex..level, position=target.position, direction=target.direction}
            stunned.orientation = target.orientation
            stunned.graphics_variation = target.graphics_variation
            target.destroy()
        end
    end
end)
