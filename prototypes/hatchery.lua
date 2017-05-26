--Hatchery
--This building will hatch eggs that are placed into it.
--The control script will eject the hatched aliens from this building, it uses the "furnace" type to automaticly hatch anything without manual selection from the user.
data:extend({
{
    type = "recipe-category",
    name = "fm-hatching"
},
{
    type = "furnace",
    name = "fm-hatchery",
    icon = "__base__/graphics/icons/biter-spawner.png",
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 1, result = "fm-hatchery"},
    max_health = 200,
    corpse = "medium-remnants",
    repair_sound = { filename = "__base__/sound/manual-repair-simple.ogg" },
    mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    vehicle_impact_sound =  { filename = "__base__/sound/car-stone-impact.ogg", volume = 1.0 },
    working_sound = util.table.deepcopy(data.raw["unit-spawner"]["biter-spawner"].working_sound),
    collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    crafting_categories = {"fm-hatching"},
    result_inventory_size = 1,
    energy_usage = "180kW",
    crafting_speed = 1,
    source_inventory_size = 1,
    energy_source =
    {
        type = "electric",
        usage_priority = "secondary-input",
        emissions = 0.005
    },
    animation =
    {
        layers =
        {
            {
                filename = "__factorimon__/graphics/entity/hatchery.png",
                priority = "high",
                width = 108,
                height = 114,
                frame_count = 8,
                line_length = 8,
                shift = {0, 2/32},
                animation_speed = 0.25,
                direction_count = 1,
                run_mode = "forward-then-backward",
            },
            {
                filename = "__base__/graphics/entity/assembling-machine-1/assembling-machine-1-shadow.png",
                priority="high",
                width = 95,
                height = 83,
                frame_count = 8,
                line_length = 8,
                draw_as_shadow = true,
                shift = {8.5 / 32, 5.5 / 32},
                animation_speed = 0.25,
                direction_count = 1,
                run_mode = "forward-then-backward",
            }
        }
    }
},
{
    type = "item",
    name = "fm-hatchery",
    icon = "__base__/graphics/icons/biter-spawner.png",
    flags = {"goes-to-quickbar"},
    subgroup = "smelting-machine",
    order = "z",
    place_result = "fm-hatchery",
    stack_size = 50
},
{
    type = "recipe",
    name = "fm-hatchery",
    enabled = false,
    ingredients =
    {
        {"electronic-circuit", 10},
        {"iron-plate", 5},
        {"stone-brick", 5},
        {"copper-plate", 15},
    },
    result = "fm-hatchery"
},
})
