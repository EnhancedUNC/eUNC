local Util = eUNCUtil
return {
    Run = function()
        return Util.run("digest", function()
            local fn = Util.getPath(Util.getGlobal("crypt"), {"digest"})
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: crypt.digest") end
            local ok, result = pcall(fn, "Hello", "sha256")
            if not ok then return Util.fail("API raised: " .. tostring(result)) end
            return Util.expect(result ~= nil, "API returned a non-nil result")
        end)
    end
}
