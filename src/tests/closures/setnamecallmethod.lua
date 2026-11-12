local Util = eUNCUtil

return {
    Run = function()
        return Util.run("setnamecallmethod", function()
            local fn = Util.getfunction("setnamecallmethod")
            if not fn then
                return Util.unknown("setnamecallmethod unavailable")
            end

            local ok = pcall(fn, "InvokeServer")

            return Util.expect(
                ok,
                "setnamecallmethod executed successfully"
            )
        end)
    end
}
