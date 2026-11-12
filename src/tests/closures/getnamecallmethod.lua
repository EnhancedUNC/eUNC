local Util = eUNCUtil

return {
    Run = function()
        return Util.run("getnamecallmethod", function()
            local fn = Util.getfunction("getnamecallmethod")
            if not fn then
                return Util.unknown("getnamecallmethod unavailable")
            end

            local ok = pcall(fn)

            return Util.expect(
                ok,
                "Function executed successfully"
            )
        end)
    end
}
