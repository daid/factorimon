local ARENA_AREA_SIZE = 4.0

local function onNew(entity, data)
    data.update_countdown = 30
end

local function onDelete(entity, data)
    if data.indicator ~= nil then
        data.indicator.destroy()
    end
end

local function onTick(entity, data)
    if entity.energy > 100 then
        if data.indicator == nil then
            data.indicator = entity.surface.create_entity{name="fm-arena-area", position=entity.position, force = game.forces.neutral}
        end
        
        if data.update_countdown > 0 then
            data.update_countdown = data.update_countdown - 1
        else
            data.update_countdown = 30
            onArenaUpdate(entity, data)
        end
    else
        if data.indicator ~= nil then
            data.indicator.destroy()
            data.indicator = nil
        end
    end
end

function onArenaUpdate(entity, data)
    local canidates = {}
    for _, unit in ipairs(entity.surface.find_entities_filtered{
        area={{entity.position.x-ARENA_AREA_SIZE, entity.position.y-ARENA_AREA_SIZE}, {entity.position.x+ARENA_AREA_SIZE, entity.position.y+ARENA_AREA_SIZE}},
        type="unit",
        force=entity.force,
    }) do
        if fmIsAlien(unit) then
            table.insert(canidates, unit)
        end
    end
    if #canidates > 1 then
        local a = math.random(1, #canidates)
        local b = math.random(1, #canidates)
        if a ~= b then
            canidates[a].set_command{type=defines.command.attack, target=canidates[b], distraction=defines.distraction.none}
            canidates[b].set_command{type=defines.command.attack, target=canidates[a], distraction=defines.distraction.none}
        end
    end
end

fmAddEntityMonitor("fm-arena", onNew, onDelete, onTick)
