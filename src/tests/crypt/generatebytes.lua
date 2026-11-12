local Util = eUNCUtil

return {
    Run = function()
        return Util.run("generatebytes", function()
            local fn = Util.getfunction("generatebytes")
            if not fn then
                return Util.unknown("generatebytes unavailable")
            end

            local ok, result = pcall(fn, 16)

            if not ok then
                return Util.fail("generatebytes raised an error")
            end

            return Util.expect(
                type(result) == "string" and #result == 16,
                "Generated 16 bytes"
            )
        end)
    end
}
