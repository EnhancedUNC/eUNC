local Util = eUNCUtil
return {
    Run = function()
        return Util.run("setfenv", function()
            local fn = Util.getPath(Util.getGlobal("debug"), {"setfenv"})
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: debug.setfenv") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
