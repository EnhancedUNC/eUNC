local Util = eUNCUtil

return {
    Run = function()
        return Util.run("isexecutorclosure", function()
            local fn = Util.getfunction("isexecutorclosure")
            if not fn then
                return Util.unknown("isexecutorclosure unavailable")
            end

            local result = fn(function()
                return true
            end)

            return Util.expect(
                type(result) == "boolean",
                "Returned a boolean"
            )
        end)
    end
}
