local Util = eUNCUtil

return {
    Run = function()
        return Util.run("hmac", function()
            local fn = Util.getfunction("hmac")
            if not fn then
                return Util.unknown("hmac unavailable")
            end

            local ok, result = pcall(fn, "Hello", "key", "sha256")

            if not ok then
                return Util.fail("hmac raised an error")
            end

            return Util.expect(
                type(result) == "string" and #result > 0,
                "HMAC returned a non-empty string"
            )
        end)
    end
}
