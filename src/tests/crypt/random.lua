local Util = eUNCUtil
return {
    Run = function()
        return Util.run("random", function()
            local fn = Util.getPath(Util.getGlobal("crypt"), {"random"})
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: crypt.random") end
            local ok, result = pcall(fn, "16")
            if not ok then return Util.fail("API raised: " .. tostring(result)) end
            return Util.expect(result ~= nil, "API returned a non-nil result")
        end)
    end
}
