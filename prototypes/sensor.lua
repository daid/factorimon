local alien_sensor = fmCopyAs("constant-combinator", "constant-combinator", "fm-alien-sensor")
local alien_sensor_item = fmCopyAs("item", "constant-combinator", "fm-alien-sensor")
alien_sensor_item.order = "z"
data:extend({alien_sensor, alien_sensor_item})
data:extend({
{
    type = "recipe",
    name = "fm-alien-sensor",
    enabled = false,
    ingredients =
    {
        {"constant-combinator", 1},
        {"electronic-circuit", 2},
    },
    result = "fm-alien-sensor"
},
})
data:extend({
{
    type = "virtual-signal",
    name = "fm-signal-male",
    icon = "__factorimon__/graphics/icons/signal/male.png",
    subgroup = "virtual-signal",
    order = "z-a"
},
{
    type = "virtual-signal",
    name = "fm-signal-female",
    icon = "__factorimon__/graphics/icons/signal/female.png",
    subgroup = "virtual-signal",
    order = "z-b"
},
{
    type = "virtual-signal",
    name = "fm-signal-hpmin",
    icon = "__factorimon__/graphics/icons/signal/hpmin.png",
    subgroup = "virtual-signal",
    order = "z-c"
},
{
    type = "virtual-signal",
    name = "fm-signal-hpmax",
    icon = "__factorimon__/graphics/icons/signal/hpmax.png",
    subgroup = "virtual-signal",
    order = "z-d"
},
})