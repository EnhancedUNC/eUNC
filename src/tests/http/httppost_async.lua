local Util = eUNCUtil
return {
    Run = function()
        return Util.run("httppost_async", function()
            local fn = Util.getGlobal("httppost")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: httppost") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
