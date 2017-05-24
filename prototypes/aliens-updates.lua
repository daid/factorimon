local function alienLevels()
    local n = 0
    local max_level = 27
    return function()
        n = n + 1
        if n < max_level then return 0.7 + 0.6 * (n / 27.0), string.char(n + 64) end
    end
end

local function alienSexes()
    local n = 0
    return function()
        n = n + 1
        if n == 1 then return "M" end
        if n == 2 then return "F" end
    end
end

--For each unit that exists, build fm- versions with stunned corpses, and health/damage variations.
local new_prototypes = {}
for name, prototype in pairs(data.raw["unit"]) do
    for quality, level in alienLevels() do
        for sex in alienSexes() do
            --Create the stunned alien "corpse"
            local stunned_corpse = util.table.deepcopy(data.raw["corpse"][prototype.corpse])
            local new_corpse_name = "fm-stunned-" .. name .. "-" .. sex  .. level
            local new_alien_name = "fm-" .. name .. "-" .. sex .. level
            local egg_name = "fm-egg-" .. name .. "-" .. sex .. level
            stunned_corpse.name = new_corpse_name
            stunned_corpse.localised_name = {"fm-alien.name", {"entity-name."..name}, {"fm-alien.sex_"..sex}, level}
            stunned_corpse.minable = {mining_time = 1, result = new_corpse_name}
            stunned_corpse.selectable_in_game = true
            --Stunned alien corpse in inventory.
            table.insert(new_prototypes, stunned_corpse)
            table.insert(new_prototypes, {
                type = "item",
                name = new_corpse_name,
                localised_name = {"fm-alien.name", {"entity-name."..name}, {"fm-alien.sex_"..sex}, level},
                icon = prototype.icon,
                flags = {"goes-to-quickbar", "hidden"},
                subgroup = "other",
                order = "a",
                place_result = new_alien_name,
                stack_size = 1
            })
            
            --Create fm-... versions of each alien
            local alien = util.table.deepcopy(prototype)
            alien.name = new_alien_name
            alien.collision_box = fmOffsetCollision(alien.collision_box, 0.2)   --Enlarge the collision of the biters, so they don't try to squeeze between everything.
            alien.localised_name = name .. sex .. level
            alien.max_health = alien.max_health * quality
            alien.attack_parameters.cooldown = alien.attack_parameters.cooldown / quality   --Simple way to get weakers/stronger attacks is to adjust the cooldown for each alien.
            alien.movement_speed = alien.movement_speed * 0.8
            table.insert(new_prototypes, alien)
            
            --Create fm-egg-... version of each alien
            table.insert(new_prototypes, {
                type = "item",
                name = egg_name,
                localised_name = {"fm-alien.egg-name", {"entity-name."..name}, {"fm-alien.sex_"..sex}, level},
                icon = "__base__/graphics/icons/biter-spawner.png",
                flags = {"goes-to-main-inventory", "hidden"},
                subgroup = "intermediate-product",
                order = "z",
                stack_size = 1
            })
            --Create the recipe to create an alien from the egg.
            --This is used by the hatchery.
            table.insert(new_prototypes, {
                type = "recipe",
                name = egg_name,
                category = "fm-hatching",
                energy_required = 10.0,
                hidden = true,
                ingredients = {{ egg_name, 1}},
                result = new_corpse_name
            })
        end
    end
end
data:extend(new_prototypes)
