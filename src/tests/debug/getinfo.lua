local Util = eUNCUtil
return {
    Run = function()
        return Util.run("getinfo", function()
            local fn = Util.getPath(Util.getGlobal("debug"), {"getinfo"})
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: debug.getinfo") end
            local ok, result = pcall(fn, "<function <lambda> at 0x7f79d96671a0>")
            if not ok then return Util.fail("API raised: " .. tostring(result)) end
            return Util.expect(result ~= nil, "API returned a non-nil result")
        end)
    end
}
