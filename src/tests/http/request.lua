local Util = eUNCUtil
return {
    Run = function()
        return Util.run("request", function()
            local fn = Util.getGlobal("request")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: request") end
            local ok, result = pcall(fn, "{'Url': 'https://example.com', 'Method': 'GET'}")
            if not ok then return Util.fail("API raised: " .. tostring(result)) end
            return Util.expect(result ~= nil, "API returned a non-nil result")
        end)
    end
}
