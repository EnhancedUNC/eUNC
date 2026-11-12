local Util = eUNCUtil
return {
    Run = function()
        return Util.run("request_body", function()
            local fn = Util.getGlobal("request_body")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: request_body") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
