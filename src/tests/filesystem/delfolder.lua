local Util = eUNCUtil
return {
    Run = function()
        return Util.run("delfolder", function()
            local fn = Util.getGlobal("delfolder")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: delfolder") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
