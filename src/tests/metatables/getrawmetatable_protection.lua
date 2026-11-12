local Util = eUNCUtil
return {
    Run = function()
        return Util.run("getrawmetatable_protection", function()
            local fn = Util.getGlobal("getrawmetatable_protection")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: getrawmetatable_protection") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
