local Util = eUNCUtil

return {
    Run = function()
        return Util.run("hash", function()
            local fn = Util.getfunction("hash")
            if not fn then
                return Util.unknown("hash unavailable")
            end

            local ok, result = pcall(fn, "Hello", "sha256")

            if not ok then
                return Util.fail("hash raised an error")
            end

            return Util.expect(
                type(result) == "string" and #result > 0,
                "Hash returned a non-empty string"
            )
        end)
    end
}
