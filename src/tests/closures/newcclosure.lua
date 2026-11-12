local Util = eUNCUtil

return {
    Run = function()
        return Util.run("newcclosure", function()
            local fn = Util.getfunction("newcclosure")
            if not fn then
                return Util.unknown("newcclosure unavailable")
            end

            local wrapped = fn(function(a, b)
                return a + b
            end)

            if type(wrapped) ~= "function" then
                return Util.fail("Returned value is not a function")
            end

            return Util.expect(
                wrapped(4, 7) == 11,
                "Wrapped function preserved behavior"
            )
        end)
    end
}
