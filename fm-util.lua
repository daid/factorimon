local entity_monitors = {}

--Utility function to monitor entity types and have a callback on creation/deletion and every tick.
-- This requires an prototype name to filter on. And 3 functions.
-- Each of the functions is called with the enitity as first parameter, and a 2nd parameter containing a table. This table is stored in the "global" table and thus should be used for data storage about this entity.
function fmAddEntityMonitor(prototype_name, create_function, delete_function, tick_function)
    entity_monitors[prototype_name] = {
        create_function = create_function,
        delete_function = delete_function,
        tick_function = tick_function,
    }
end

function fmIsAlien(entity)
    local name = entity.name
    if entity.type ~= "unit" then return false end
    if name:sub(1, 3) ~= "fm-" then return false end
    if name:sub(-3, -3) ~= "-" then return false end
    return true
end

local function entityKey(entity)
    return entity.position.x .. "," .. entity.position.y
end

local function onCreateEntityCheck(event)
    local e = event.created_entity
    if entity_monitors[e.name] ~= nil then
        local data = {}
        local key = entityKey(e)
        global.entity_monitor_lists[key] = {entity=e, data=data}
        entity_monitors[e.name].create_function(e, data)
    end
end

local function onDeleteEntityCheck(event)
    local e = event.entity
    
    if entity_monitors[e.name] ~= nil then
        local key = entityKey(e)
        if global.entity_monitor_lists[key] ~= nil then
            entity_monitors[e.name].delete_function(e, global.entity_monitor_lists[key].data)
            global.entity_monitor_lists[key] = nil
        end
    end

    if event.cause ~= nil and onKill ~= nil then
        --Forward a kill to the onKill handler
        onKill(event.cause, event.entity)
    end
end

local function onTick(event)
    if global.entity_monitor_lists == nil then
        global.entity_monitor_lists = {}
    end

    for _, data in pairs(global.entity_monitor_lists) do
        entity_monitors[data.entity.name].tick_function(data.entity, data.data)
    end
end

script.on_event(defines.events.on_built_entity, onCreateEntityCheck)
script.on_event(defines.events.on_robot_built_entity, onCreateEntityCheck)
script.on_event(defines.events.on_preplayer_mined_item , onDeleteEntityCheck)
script.on_event(defines.events.on_robot_pre_mined, onDeleteEntityCheck)
script.on_event(defines.events.on_entity_died, onDeleteEntityCheck)
script.on_event(defines.events.on_tick, onTick)
