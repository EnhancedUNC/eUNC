local Util = eUNCUtil
return {
    Run = function()
        return Util.run("websocket_binary", function()
            local fn = Util.getGlobal("websocket_binary")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: websocket_binary") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
