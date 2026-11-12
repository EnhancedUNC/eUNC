local Util = eUNCUtil
return {
    Run = function()
        return Util.run("getfileextension", function()
            local fn = Util.getGlobal("getfileextension")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: getfileextension") end
            local ok, result = pcall(fn, "file.txt")
            if not ok then return Util.fail("API raised: " .. tostring(result)) end
            return Util.expect(result ~= nil, "API returned a non-nil result")
        end)
    end
}
