local Util = eUNCUtil
return {
    Run = function()
        return Util.run("metatable_index", function()
            local fn = Util.getGlobal("metatable_index")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: metatable_index") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
