local Util = eUNCUtil

return {
    Run = function()
        return Util.run("base64encode", function()
            local fn = Util.getfunction("base64encode")
            if not fn then
                return Util.unknown("base64encode unavailable")
            end

            local ok, result = pcall(fn, "Hello")

            if not ok then
                return Util.fail("base64encode raised an error")
            end

            return Util.expect(
                result == "SGVsbG8=",
                "Encoded Base64 correctly"
            )
        end)
    end
}
