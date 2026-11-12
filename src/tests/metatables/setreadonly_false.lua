local Util = eUNCUtil
return {
    Run = function()
        return Util.run("setreadonly_false", function()
            local fn = Util.getGlobal("setreadonly_false")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: setreadonly_false") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
