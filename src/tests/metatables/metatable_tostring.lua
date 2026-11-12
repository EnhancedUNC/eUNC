local Util = eUNCUtil
return {
    Run = function()
        return Util.run("metatable_tostring", function()
            local fn = Util.getGlobal("metatable_tostring")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: metatable_tostring") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
