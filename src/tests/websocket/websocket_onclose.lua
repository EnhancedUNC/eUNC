local Util = eUNCUtil
return {
    Run = function()
        return Util.run("websocket_onclose", function()
            local fn = Util.getGlobal("websocket_onclose")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: websocket_onclose") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
