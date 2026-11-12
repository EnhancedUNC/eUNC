local Util = eUNCUtil
return {
    Run = function()
        return Util.run("getlocal", function()
            local fn = Util.getPath(Util.getGlobal("debug"), {"getlocal"})
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: debug.getlocal") end
            local ok, result = pcall(fn)
            if not ok then return Util.fail("API threw: " .. tostring(result)) end
            return Util.expect(result ~= nil, "API returned a value")
        end)
    end
}
