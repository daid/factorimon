--When harvesting aliens, the following parts can be produced.
data:extend({
{
    type = "item",
    name = "fm-raw-meat",
    icon = "__factorimon__/graphics/icons/meat.png",
    flags = {"goes-to-quickbar"},
    subgroup = "raw-resource",
    order = "z",
    stack_size = 100
},{
    type = "fluid",
    name = "fm-blood",
    default_temperature = 25,
    heat_capacity = "0.1KJ",
    base_color = {r=1.0, g=0, b=0},
    flow_color = {r=1.0, g=0.3, b=0.3},
    max_temperature = 100,
    icon = "__factorimon__/graphics/icons/blood.png",
    pressure_to_speed_ratio = 0.1,
    flow_to_energy_ratio = 0.2,
    order = "a[fluid]-z"
},
})