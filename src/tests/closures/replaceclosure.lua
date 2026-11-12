local Util = eUNCUtil

return {
    Run = function()
        return Util.run("replaceclosure", function()
            local fn = Util.getfunction("replaceclosure")
            if not fn then
                return Util.unknown("replaceclosure unavailable")
            end

            local target = function()
                return 1
            end

            local replacement = function()
                return 2
            end

            local ok = pcall(fn, target, replacement)

            if not ok then
                return Util.fail("replaceclosure raised an error")
            end

            return Util.expect(
                target() == 2,
                "Target function was replaced"
            )
        end)
    end
}
