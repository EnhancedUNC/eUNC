local Util = eUNCUtil

return {
    Run = function()
        return Util.run("islclosure", function()
            local fn = Util.getfunction("islclosure")
            if not fn then
                return Util.unknown("islclosure unavailable")
            end

            local result = fn(function()
                return true
            end)

            return Util.expect(
                result == true,
                "Lua closure identified correctly"
            )
        end)
    end
}
