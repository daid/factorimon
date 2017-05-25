data:extend({
{
    type = "technology",
    name = "fm-alien-capture",
    icon = "__factorimon__/graphics/technology/alien-capture.png",
    icon_size = 128,
    effects = {
        { type = "unlock-recipe", recipe = "fm-stun-magazine" },
        { type = "unlock-recipe", recipe = "fm-arena" },
    },
    prerequisites = {"military"},
    unit =
    {
        count = 30,
        ingredients =
        {
            {"science-pack-1", 1},
        },
        time = 10
    },
    order = "z"
},
{
    type = "technology",
    name = "fm-alien-breeding",
    icon = "__factorimon__/graphics/technology/alien-breeding.png",
    icon_size = 128,
    effects = {
        { type = "unlock-recipe", recipe = "fm-breeder" },
        { type = "unlock-recipe", recipe = "fm-hatchery" },
    },
    prerequisites = {"fm-alien-capture"},
    unit =
    {
        count = 30,
        ingredients =
        {
            {"science-pack-1", 1},
        },
        time = 10
    },
    order = "z"
},
{
    type = "technology",
    name = "fm-alien-sensor",
    icon = "__factorimon__/graphics/technology/alien-sensor.png",
    icon_size = 128,
    effects = { { type = "unlock-recipe", recipe = "fm-alien-sensor" } },
    prerequisites = {"circuit-network", "fm-alien-capture"},
    unit =
    {
        count = 100,
        ingredients =
        {
            {"science-pack-1", 1},
            {"science-pack-2", 1}
        },
        time = 30
    },
    order = "z"
},
})
