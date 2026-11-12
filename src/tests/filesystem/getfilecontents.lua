local Util = eUNCUtil
return {
    Run = function()
        return Util.run("getfilecontents", function()
            local fn = Util.getGlobal("readfile")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: readfile") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
