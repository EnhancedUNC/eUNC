local Util = eUNCUtil
return {
    Run = function()
        return Util.run("getstacksize", function()
            local fn = Util.getPath(Util.getGlobal("debug"), {"getstacksize"})
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: debug.getstacksize") end
            local ok, result = pcall(fn, "1")
            if not ok then return Util.fail("API raised: " .. tostring(result)) end
            return Util.expect(result ~= nil, "API returned a non-nil result")
        end)
    end
}
