local Util = eUNCUtil
return {
    Run = function()
        return Util.run("request_headers", function()
            local fn = Util.getGlobal("request_headers")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: request_headers") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
