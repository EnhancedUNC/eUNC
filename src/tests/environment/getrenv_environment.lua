local Util = eUNCUtil
return {
    Run = function()
        return Util.run("getrenv_environment", function()
            local fn = Util.getGlobal("getrenv_environment")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: getrenv_environment") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
