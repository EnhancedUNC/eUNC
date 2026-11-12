local Util = eUNCUtil

return {
    Run = function()
        return Util.run("hookmetamethod", function()
            local fn = Util.getfunction("hookmetamethod")
            if not fn then
                return Util.unknown("hookmetamethod unavailable")
            end

            local object = setmetatable({}, {
                __index = function()
                    return 10
                end
            })

            local replacement = function()
                return 20
            end

            local old = fn(object, "__index", replacement)
            local result = object.Value

            pcall(function()
                fn(object, "__index", old)
            end)

            return Util.expect(
                result == 20,
                "__index hook changed behavior"
            )
        end)
    end
}
