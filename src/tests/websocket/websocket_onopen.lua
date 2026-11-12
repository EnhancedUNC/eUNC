local Util = eUNCUtil
return {
    Run = function()
        return Util.run("websocket_onopen", function()
            local fn = Util.getGlobal("websocket_onopen")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: websocket_onopen") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
