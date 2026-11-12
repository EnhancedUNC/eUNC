local Util = eUNCUtil

return {
    Run = function()
        return Util.run("cloneclosure", function()
            local fn = Util.getfunction("cloneclosure")
            if not fn then
                return Util.unknown("cloneclosure unavailable")
            end

            local function original(a, b)
                return a * b
            end

            local clone = fn(original)

            if type(clone) ~= "function" then
                return Util.fail("Clone is not a function")
            end

            return Util.expect(
                clone(6, 7) == original(6, 7),
                "Clone preserved behavior"
            )
        end)
    end
}
