local BREEDER_AREA_SIZE = 4.0

local function onNew(breeder, data)
    data.update_countdown = 30
end

local function onDelete(breeder, data)
    if data.breeder_indicator ~= nil then
        data.breeder_indicator.destroy()
    end
end

local function onTick(breeder, data)
    if breeder.energy > 100 then
        if data.breeder_indicator == nil then
            data.breeder_indicator = breeder.surface.create_entity{name="fm-breeder-area", position=breeder.position, force = game.forces.neutral}
        end
        
        if data.update_countdown > 0 then
            data.update_countdown = data.update_countdown - 1
        else
            data.update_countdown = 30
            onBreederUpdate(breeder, data)
        end
    else
        if data.breeder_indicator ~= nil then
            data.breeder_indicator.destroy()
            data.breeder_indicator = nil
        end
    end
end

function isBreederMatch(m, f)
    local type_m = m.name:sub(4, -4)
    local type_f = f.name:sub(4, -4)

    if type_m == type_f then
        return true
    end
    return false
end

function evolveTypeFrom(type)
    --Hardcoded right now. So not mod compattible.
    --TODO: use game.entity_prototypes to find the proper evolve type.
    if type == "small-biter" then return "medium-biter" end
    if type == "medium-biter" then return "big-biter" end
    if type == "big-biter" then return "behemoth-biter" end
    if type == "small-spitter" then return "medium-spitter" end
    if type == "medium-spitter" then return "big-spitter" end
    if type == "big-spitter" then return "behemoth-spitter" end
end

function onBreederUpdate(breeder, data)
    local male_canidate = nil
    local female_canidate = nil
    for _, unit in ipairs(breeder.surface.find_entities_filtered{
        area={{breeder.position.x-BREEDER_AREA_SIZE, breeder.position.y-BREEDER_AREA_SIZE}, {breeder.position.x+BREEDER_AREA_SIZE, breeder.position.y+BREEDER_AREA_SIZE}},
        type="unit",
        force=breeder.force,
    }) do
        if fmIsAlien(unit) then
            local sex = unit.name:sub(-2, -2)
            if sex == "M" and male_canidate == nil then
                male_canidate = unit
            end
            if sex == "F" and female_canidate == nil then
                female_canidate = unit
            end
        end
    end
    if male_canidate ~= nil and female_canidate ~= nil and isBreederMatch(male_canidate, female_canidate) then
        local mp = male_canidate.position
        local fp = female_canidate.position
        if math.abs(mp.x - fp.x) + math.abs(mp.y - fp.y) < 3 then
            --Create eggs
            local center = {(mp.x + fp.x) / 2, (mp.y + fp.y) / 2}
            local egg_count = math.random(3, 8)
            local level_m = male_canidate.name:byte(-1, -1) - 64
            local level_f = female_canidate.name:byte(-1, -1) - 64
            local level = (level_m + level_f) / 2
            local level_min = math.max(1, level)
            local level_max = math.min(27, level + 4)
            local type = male_canidate.name:sub(4, -4)
            for n=1,egg_count do
                local level = string.char(64 + math.random(level_min, level_max))
                local sex = "M"
                local new_type = type
                if math.random(100) < 50 then sex = "F" end
                if level == "A" and math.random(0, 100) < 20 then
                    new_type = evolveTypeFrom(type)
                    if new_type == nil then
                        new_type = type
                    else
                        level = string.char(64 + math.random(25, 27))
                    end
                end
                breeder.surface.spill_item_stack(center, {name="fm-egg-"..new_type.."-"..sex..level})
            end
            --Kill the parents (use .damage() instead of .die() as .die() reports them as being destroyed to the player)
            male_canidate.damage(male_canidate.health * 10, male_canidate.force)
            female_canidate.damage(female_canidate.health * 10, female_canidate.force)
        else
            male_canidate.set_command{type=defines.command.go_to_location, destination=fp, distraction=defines.distraction.none}
            female_canidate.set_command{type=defines.command.go_to_location, destination=mp, distraction=defines.distraction.none}
        end
    end
end

fmAddEntityMonitor("fm-breeder", onNew, onDelete, onTick)
