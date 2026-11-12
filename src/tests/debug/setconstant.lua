local Util = eUNCUtil
return {
    Run = function()
        return Util.run("setconstant", function()
            local fn = Util.getGlobal("setconstant")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: setconstant") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
