
function onKill(entity, kill)
    if fmIsAlien(entity) and fmIsAlien(kill) then
        local level = entity.name:byte(-1, -1) - 64
        local other_level = kill.name:byte(-1, -1) - 64
        if level > 1 and other_level - level < math.random(1, 5) then
            level = level - 1
            local new_entity = {
                name = entity.name:sub(1, -2) .. string.char(level + 64),
                position = entity.position,
                force = entity.force,
            }
            local orientation = entity.orientation
            local health = entity.health
            local graphics_variation = entity.graphics_variation
            local surface = entity.surface
            entity.destroy()

            new_entity = surface.create_entity(new_entity)
            new_entity.orientation = orientation
            new_entity.health = health
            new_entity.graphics_variation = graphics_variation
        end
    end
end
