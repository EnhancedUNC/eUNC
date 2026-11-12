local Util = eUNCUtil

return {
    Run = function()
        return Util.run("newlclosure", function()
            local fn = Util.getfunction("newlclosure")
            if not fn then
                return Util.unknown("newlclosure unavailable")
            end

            local wrapped = fn(function(a, b)
                return a * b
            end)

            if type(wrapped) ~= "function" then
                return Util.fail("Returned value is not a function")
            end

            return Util.expect(
                wrapped(6, 7) == 42,
                "Wrapped function preserved behavior"
            )
        end)
    end
}
