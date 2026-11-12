local Util = eUNCUtil

return {
    Run = function()
        return Util.run("base64decode", function()
            local fn = Util.getfunction("base64decode")
            if not fn then
                return Util.unknown("base64decode unavailable")
            end

            local ok, result = pcall(fn, "SGVsbG8=")

            if not ok then
                return Util.fail("base64decode raised an error")
            end

            return Util.expect(
                result == "Hello",
                "Decoded Base64 correctly"
            )
        end)
    end
}
