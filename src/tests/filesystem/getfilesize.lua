local Util = eUNCUtil
return {
    Run = function()
        return Util.run("getfilesize", function()
            local fn = Util.getGlobal("getfilesize")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: getfilesize") end
            local ok, result = pcall(fn, "eunc_probe_missing.txt")
            if not ok then return Util.fail("API raised: " .. tostring(result)) end
            return Util.expect(result ~= nil, "API returned a non-nil result")
        end)
    end
}
