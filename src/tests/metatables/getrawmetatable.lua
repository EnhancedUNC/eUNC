local Util = eUNCUtil
return {
    Run = function()
        return Util.run("getrawmetatable", function()
            local fn = Util.getGlobal("getrawmetatable")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: getrawmetatable") end
            local ok, result = pcall(fn, "{}")
            if not ok then return Util.fail("API raised: " .. tostring(result)) end
            return Util.expect(result ~= nil, "API returned a non-nil result")
        end)
    end
}
