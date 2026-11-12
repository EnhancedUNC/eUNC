local Util = eUNCUtil
return {
    Run = function()
        return Util.run("getrenv_global", function()
            local fn = Util.getGlobal("getrenv_global")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: getrenv_global") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
