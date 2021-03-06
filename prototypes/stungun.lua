require("util")

data:extend({
{ --Create out custom stun ammo. This applies no damage, but spawns a custom explosion-hit effect, which we then get an event for in the control.lua
    type = "ammo",
    name = "fm-stun-magazine",
    icon = "__factorimon__/graphics/icons/stun-magazine.png",
    flags = {"goes-to-main-inventory"},
    ammo_type =
    {
      category = "bullet",
      cooldown_modifier = 5,
      action =
      {
        {
          type = "direct",
          action_delivery =
          {
            {
              type = "instant",
              source_effects =
              {
                {
                  type = "create-explosion",
                  entity_name = "explosion-gunshot"
                }
              },
              target_effects =
              {
                {
                  type = "create-entity",
                  entity_name = "fm-stun-hit",
                  trigger_created_entity = true
                }
              }
            }
          }
        }
      }
    },
    magazine_size = 2,
    subgroup = "ammo",
    order = "a[basic-clips]-a[firearm-magazine]-a",
    stack_size = 200
},
{
    type = "recipe",
    name = "fm-stun-magazine",
    enabled = false,
    ingredients =
    {
        {"iron-plate", 3},
        {"copper-plate", 1},
    },
    result = "fm-stun-magazine"
},
})
local fm_stun_hit = util.table.deepcopy(data.raw["explosion"]["explosion-hit"])
fm_stun_hit["name"] = "fm-stun-hit"
data:extend({fm_stun_hit})
