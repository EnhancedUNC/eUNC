local Util = eUNCUtil

return {
    Run = function()
        return Util.run("generatekey", function()
            local fn = Util.getfunction("generatekey")
            if not fn then
                return Util.unknown("generatekey unavailable")
            end

            local ok, result = pcall(fn)

            if not ok then
                return Util.fail("generatekey raised an error")
            end

            return Util.expect(
                type(result) == "string" and #result > 0,
                "Generated a non-empty key"
            )
        end)
    end
}
