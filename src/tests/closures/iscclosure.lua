local Util = eUNCUtil

return {
    Run = function()
        return Util.run("iscclosure", function()
            local fn = Util.getfunction("iscclosure")
            if not fn then
                return Util.unknown("iscclosure unavailable")
            end

            local result = fn(function()
                return true
            end)

            return Util.expect(
                result == false,
                "Lua closure identified as non-C closure"
            )
        end)
    end
}
