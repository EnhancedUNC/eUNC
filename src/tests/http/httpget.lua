local Util = eUNCUtil
return {
    Run = function()
        return Util.run("httpget", function()
            local fn = Util.getGlobal("httpget")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: httpget") end
            local ok, result = pcall(fn, "https://example.com")
            if not ok then return Util.fail("API raised: " .. tostring(result)) end
            return Util.expect(result ~= nil, "API returned a non-nil result")
        end)
    end
}
