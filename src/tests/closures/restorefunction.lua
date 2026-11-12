local Util = eUNCUtil

return {
    Run = function()
        return Util.run("restorefunction", function()
            local fn = Util.getfunction("restorefunction")
            if not fn then
                return Util.unknown("restorefunction unavailable")
            end

            local target = function()
                return 1
            end

            local ok = pcall(fn, target)

            return Util.expect(
                ok,
                "restorefunction accepted a function"
            )
        end)
    end
}
