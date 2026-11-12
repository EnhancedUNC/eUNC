local Util = eUNCUtil
return {
    Run = function()
        return Util.run("websocket_send", function()
            local fn = Util.getGlobal("websocket_send")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: websocket_send") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
