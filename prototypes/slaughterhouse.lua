data:extend({
{
    type = "recipe-category",
    name = "fm-slaughtering"
},
{
    type = "furnace",
    name = "fm-slaughterhouse",
    icon = "__factorimon__/graphics/icons/slaughterhouse.png",
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 1, result = "fm-slaughterhouse"},
    max_health = 200,
    corpse = "medium-remnants",
    repair_sound = { filename = "__base__/sound/manual-repair-simple.ogg" },
    mined_sound = { filename = "__base__/sound/deconstruct-bricks.ogg" },
    open_sound = { filename = "__base__/sound/machine-open.ogg", volume = 0.85 },
    close_sound = { filename = "__base__/sound/machine-close.ogg", volume = 0.75 },
    vehicle_impact_sound =  { filename = "__base__/sound/car-stone-impact.ogg", volume = 1.0 },
    working_sound =
    {
        sound = {
            { filename = "__base__/sound/assembling-machine-t2-1.ogg", volume = 0.8 },
            { filename = "__base__/sound/assembling-machine-t2-2.ogg", volume = 0.8 },
        },
        idle_sound = { filename = "__base__/sound/idle1.ogg", volume = 0.6 },
        apparent_volume = 1.5,
    },
    fluid_boxes =
    {
        {
            production_type = "output",
            pipe_picture = assembler2pipepictures(),
            pipe_covers = pipecoverspictures(),
            base_area = 10,
            base_level = 1,
            pipe_connections = {{ type="output", position = {0, -2} }},
            secondary_draw_orders = { north = -1 }
        },
    },
    collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    crafting_categories = {"fm-slaughtering"},
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
                filename = "__factorimon__/graphics/entity/slaughterhouse.png",
                priority = "high",
                width = 108,
                height = 110,
                frame_count = 32,
                line_length = 8,
                shift = {0, 4/32},
            },
            {
                filename = "__base__/graphics/entity/assembling-machine-2/assembling-machine-2-shadow.png",
                priority = "high",
                width = 98,
                height = 82,
                frame_count = 32,
                line_length = 8,
                draw_as_shadow = true,
                shift = {12/32, 5/32},
            },
        },
    }
},
{
    type = "item",
    name = "fm-slaughterhouse",
    icon = "__factorimon__/graphics/icons/slaughterhouse.png",
    flags = {"goes-to-quickbar"},
    subgroup = "smelting-machine",
    order = "z",
    place_result = "fm-slaughterhouse",
    stack_size = 50
},
{
    type = "recipe",
    name = "fm-slaughterhouse",
    enabled = false,
    ingredients =
    {
        {"electronic-circuit", 10},
        {"iron-gear-wheel", 5},
        {"steel-plate", 5},
        {"stone-brick", 5},
    },
    result = "fm-slaughterhouse"
},
})
