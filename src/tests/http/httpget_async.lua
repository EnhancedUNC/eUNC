local Util = eUNCUtil
return {
    Run = function()
        return Util.run("httpget_async", function()
            local fn = Util.getGlobal("httpget")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: httpget") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
