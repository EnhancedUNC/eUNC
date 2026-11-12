local Util = eUNCUtil
return {
    Run = function()
        return Util.run("isfile", function()
            local fn = Util.getGlobal("isfile")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: isfile") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
