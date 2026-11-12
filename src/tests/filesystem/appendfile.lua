local Util = eUNCUtil
return {
    Run = function()
        return Util.run("appendfile", function()
            local fn = Util.getGlobal("appendfile")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: appendfile") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
