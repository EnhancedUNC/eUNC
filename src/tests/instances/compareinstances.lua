local Util = eUNCUtil
return {
    Run = function()
        return Util.run("compareinstances", function()
            local fn = Util.getGlobal("compareinstances")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: compareinstances") end
            local ok, result = pcall(fn, GAME, GAME)
            if not ok then return Util.fail("API raised: " .. tostring(result)) end
            return Util.expect(result ~= nil, "API returned a non-nil result")
        end)
    end
}
