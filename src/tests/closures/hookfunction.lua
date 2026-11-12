local Util = eUNCUtil

return {
    Run = function()
        return Util.run("hookfunction", function()
            local fn = Util.getfunction("hookfunction")
            if not fn then
                return Util.unknown("hookfunction unavailable")
            end

            local target = function()
                return 10
            end

            local replacement = function()
                return 25
            end

            local original = fn(target, replacement)

            if type(original) ~= "function" then
                return Util.fail("Original function was not returned")
            end

            local result = target()

            pcall(function()
                fn(target, original)
            end)

            return Util.expect(
                result == 25,
                "Target returned replacement result"
            )
        end)
    end
}
