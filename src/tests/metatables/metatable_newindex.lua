local Util = eUNCUtil
return {
    Run = function()
        return Util.run("metatable_newindex", function()
            local fn = Util.getGlobal("metatable_newindex")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: metatable_newindex") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
