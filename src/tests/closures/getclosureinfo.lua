local Util = eUNCUtil

return {
    Run = function()
        return Util.run("getclosureinfo", function()
            local fn = Util.getfunction("getclosureinfo")
            if not fn then
                return Util.unknown("getclosureinfo unavailable")
            end

            local function target()
                return true
            end

            local ok, result = pcall(fn, target)

            if not ok then
                return Util.fail("getclosureinfo raised an error")
            end

            return Util.expect(
                result ~= nil,
                "Returned closure information"
            )
        end)
    end
}
