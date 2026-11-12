local Util = eUNCUtil

return {
    Run = function()
        return Util.run("clonefunction", function()
            local fn = Util.getfunction("clonefunction")
            if not fn then
                return Util.unknown("clonefunction unavailable")
            end

            local function original(a, b)
                return a + b
            end

            local clone = fn(original)

            if type(clone) ~= "function" then
                return Util.fail("Clone is not a function")
            end

            if clone == original then
                return Util.fail("Clone shares original reference")
            end

            return Util.expect(
                clone(12, 30) == original(12, 30),
                "Clone preserved behavior"
            )
        end)
    end
}
