local Util = eUNCUtil
return {
    Run = function()
        return Util.run("metatable_call", function()
            local fn = Util.getGlobal("metatable_call")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: metatable_call") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
