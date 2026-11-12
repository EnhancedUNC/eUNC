local Util = eUNCUtil

return {
    Run = function()
        return Util.run("decrypt", function()
            local fn = Util.getfunction("decrypt")
            if not fn then
                return Util.unknown("decrypt unavailable")
            end

            local ok, result = pcall(fn, "invalid", "key")

            return Util.expect(
                ok and type(result) == "string",
                "Decrypt returned a string"
            )
        end)
    end
}
