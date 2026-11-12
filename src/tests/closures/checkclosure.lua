local Util = eUNCUtil

return {
    Run = function()
        return Util.run("checkclosure", function()
            local fn = Util.getfunction("checkclosure")
            if not fn then
                return Util.unknown("checkclosure unavailable")
            end

            local function closure()
                return true
            end

            local ok, result = pcall(fn, closure)

            if not ok then
                return Util.fail("checkclosure raised an error")
            end

            return Util.expect(
                type(result) == "boolean",
                "Returned a boolean"
            )
        end)
    end
}
