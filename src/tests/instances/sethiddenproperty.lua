local Util = eUNCUtil
return {
    Run = function()
        return Util.run("sethiddenproperty", function()
            local fn = Util.getGlobal("sethiddenproperty")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: sethiddenproperty") end
            local ok, result = pcall(fn, GAME, "Name", "Name")
            if not ok then return Util.fail("API raised: " .. tostring(result)) end
            return Util.expect(result ~= nil, "API returned a non-nil result")
        end)
    end
}
