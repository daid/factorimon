--Arena "lamp"
--When this entity is powered, it will have nearby aliens fight each other.
data:extend({
{
    type = "electric-energy-interface",
    name = "fm-arena",
    icon = "__factorimon__/graphics/icons/arena.png",
    flags = {"placeable-neutral", "player-creation"},
    minable = {hardness = 0.2, mining_time = 0.5, result = "fm-arena"},
    max_health = 100,
    corpse = "small-remnants",
    collision_box = {{-0.15, -0.15}, {0.15, 0.15}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },

    energy_source =
    {
        type = "electric",
        buffer_capacity = "100KJ",
        usage_priority = "terciary",
        input_flow_limit = "1MW",
        output_flow_limit = "0W"
    },

    energy_production = "0kW",
    energy_usage = "100kW",

    picture =
    {
        filename = "__factorimon__/graphics/entity/arena.png",
        priority = "high",
        width = 67,
        height = 58,
        frame_count = 1,
        axially_symmetrical = false,
        direction_count = 1,
        shift = {-0.015625, 0.15625},
    },
},
{
    type = "item",
    name = "fm-arena",
    icon = "__factorimon__/graphics/icons/arena.png",
    flags = {"goes-to-quickbar"},
    subgroup = "circuit-network",
    order = "a[light]-a[small-lamp]",
    place_result = "fm-arena",
    stack_size = 50
},
{
    type = "recipe",
    name = "fm-arena",
    enabled = false,
    ingredients =
    {
        {"electronic-circuit", 4},
        {"iron-plate", 2},
        {"steel-plate", 1},
    },
    result = "fm-arena"
},

{   --Area indicator shown below the breeder that it is active and what the area of influence is.
    type = "simple-entity",
    name = "fm-arena-area",
    flags = {"placeable-neutral", "placeable-off-grid", "not-on-map"},
    icon = "__base__/graphics/icons/small-lamp.png",
    subgroup = "other",
    order = "a",
    render_layer = "decorative",
    selectable_in_game = false,
    pictures =
    {
        {
            filename = "__core__/graphics/color-effect-small.png",
            width = 150,
            height = 150,
            scale = 2.0,
            tint = {r=1.0, g=0.2, b=0.2, a=0.1},
        },
    }
},
})
