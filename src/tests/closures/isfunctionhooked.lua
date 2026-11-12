local Util = eUNCUtil

return {
    Run = function()
        return Util.run("isfunctionhooked", function()
            local fn = Util.getfunction("isfunctionhooked")
            if not fn then
                return Util.unknown("isfunctionhooked unavailable")
            end

            local function target()
                return true
            end

            local ok, result = pcall(fn, target)

            if not ok then
                return Util.fail("isfunctionhooked raised an error")
            end

            return Util.expect(
                type(result) == "boolean",
                "Returned a boolean"
            )
        end)
    end
}
