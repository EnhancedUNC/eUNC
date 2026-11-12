local Util = eUNCUtil
return {
    Run = function()
        return Util.run("getcustomasset", function()
            local fn = Util.getGlobal("getcustomasset")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: getcustomasset") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
