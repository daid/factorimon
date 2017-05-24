local SENSOR_AREA_SIZE = 1.2

local function onNew(entity, data)
    entity.operable = false
end

local function onDelete(entity, data)
end

local function onTick(entity, data)
    local male_count = 0
    local female_count = 0
    local levels = {}
    local health_min = nil
    local health_max = nil
    for _, unit in ipairs(entity.surface.find_entities_filtered{
        area={{entity.position.x-SENSOR_AREA_SIZE, entity.position.y-SENSOR_AREA_SIZE}, {entity.position.x+SENSOR_AREA_SIZE, entity.position.y+SENSOR_AREA_SIZE}},
        type="unit",
        force=entity.force,
    }) do
        if unit.name:sub(1, 3) == "fm-" then
            local level = unit.name:sub(-1, -1)
            local sex = unit.name:sub(-2, -2)
            if sex == "M" then
                male_count = male_count + 1
            else
                female_count = female_count + 1
            end
            if levels[level] == nil then
                levels[level] = 1
            else
                levels[level] = levels[level] + 1
            end
            local health = 100 * unit.health / unit.prototype.max_health
            if health_min == nil then health_min = health health_max = health end
            if health_min > health then health_min = health end
            if health_max < health then health_max = health end
        end
    end
    
    local signals = {
        {signal={type="virtual", name="fm-signal-male"}, count=male_count, index=1},
        {signal={type="virtual", name="fm-signal-female"}, count=female_count, index=2},
    }
    if health_min ~= nil then
        table.insert(signals, {signal={type="virtual", name="fm-signal-hpmin"}, count=health_min, index=#signals+1})
        table.insert(signals, {signal={type="virtual", name="fm-signal-hpmax"}, count=health_max, index=#signals+1})
    end
    for level, count in pairs(levels) do
        table.insert(signals, {signal={type="virtual", name="signal-"..level}, count=count, index=#signals+1})
    end
    local control_behavior = entity.get_or_create_control_behavior()
    control_behavior.parameters = {parameters=signals}
end

fmAddEntityMonitor("fm-alien-sensor", onNew, onDelete, onTick)
