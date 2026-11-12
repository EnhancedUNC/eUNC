local Util = eUNCUtil

return {
    Run = function()
        return Util.run("checkcaller", function()
            local fn = Util.getfunction("checkcaller")
            if not fn then
                return Util.unknown("checkcaller unavailable")
            end

            return Util.expect(
                type(fn()) == "boolean",
                "Returned a boolean"
            )
        end)
    end
}
