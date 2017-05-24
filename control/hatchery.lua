function onNew(entity, data)
end

function onDelete(entity, data)
end

function onTick(entity, data)
    local inventory = entity.get_output_inventory()
    if not inventory.is_empty() then
        for item, count in pairs(inventory.get_contents()) do
            if item:sub(1, 11) == "fm-stunned-" and item:sub(-3, -3) == "-" then
                local sex = item:sub(-2, -2)
                local level = item:sub(-1, -1)
                local type = item:sub(12, -4)
                inventory.clear()
                local name = "fm-"..type.."-"..sex..level
                local position = entity.surface.find_non_colliding_position(name, {entity.position.x, entity.position.y + 1.5}, 1.5, 0.5)
                if position ~= nil then
                    entity.surface.create_entity{name=name, position=position, force=entity.force}
                end
            end
        end
    end
end

fmAddEntityMonitor("fm-hatchery", onNew, onDelete, onTick)
