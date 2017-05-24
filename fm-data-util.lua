require("util")

function fmCopyAs(type, name, new_name)
    local result = util.table.deepcopy(data.raw[type][name])
    result.name = new_name
    if result.minable ~= nil then
        result.minable.result = new_name
    end
    if result.place_result ~= nil then
        result.place_result = new_name
    end
    return result
end

function fmOffsetCollision(collision, offset)
    return {{collision[1][1]-offset, collision[1][2]-offset}, {collision[2][1]+offset, collision[2][2]+offset}}
end
