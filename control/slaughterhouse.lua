local SLAUGHTERHOUSE_INPUT_AREA = 1.0
local SLAUGHTERHOUSE_INPUT_X = 0.0
local SLAUGHTERHOUSE_INPUT_Y = 1.5

function onNew(entity, data)
end

function onDelete(entity, data)
end

function onTick(entity, data)
    --If the crafting progress is 0.0 when we know for sure the next incomming inventory item is consumed ASAP.
    --We don't want to insert something into the source inventory if it isn't consumed by the "furnace" type directly. Else you could convery aliens into items with this.
    if entity.crafting_progress == 0.0 then
        local inventory = entity.get_inventory(defines.inventory.furnace_source)
        local x, y = entity.position.x + SLAUGHTERHOUSE_INPUT_X, entity.position.y + SLAUGHTERHOUSE_INPUT_Y
        for _, unit in ipairs(entity.surface.find_entities_filtered{
            area={{x-SLAUGHTERHOUSE_INPUT_AREA, y-SLAUGHTERHOUSE_INPUT_AREA}, {x+SLAUGHTERHOUSE_INPUT_AREA, y+SLAUGHTERHOUSE_INPUT_AREA}},
            type="unit",
            force=entity.force,
        }) do
            if fmIsAlien(unit) then
                if inventory.insert({name="fm-stunned-"..unit.name:sub(4), count=1}) then
                    unit.destroy()
                    return
                end
            end
        end
    end
end

fmAddEntityMonitor("fm-slaughterhouse", onNew, onDelete, onTick)
