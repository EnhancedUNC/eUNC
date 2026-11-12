local Util = eUNCUtil

return {
    Run = function()
        return Util.run("encrypt", function()
            local fn = Util.getfunction("encrypt")
            if not fn then
                return Util.unknown("encrypt unavailable")
            end

            local ok, result = pcall(fn, "Hello", "key")

            if not ok then
                return Util.fail("encrypt raised an error")
            end

            return Util.expect(
                type(result) == "string",
                "Encrypt returned a string"
            )
        end)
    end
}
