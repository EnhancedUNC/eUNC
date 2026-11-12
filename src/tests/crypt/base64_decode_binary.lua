local Util = eUNCUtil
return {
    Run = function()
        return Util.run("base64_decode_binary", function()
            local fn = Util.getPath(Util.getGlobal("crypt"), {"base64decode"})
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: crypt.base64decode") end
            local ok, result = pcall(fn, "SGVsbG8=")
            if not ok then return Util.fail("API raised: " .. tostring(result)) end
            return Util.expect(result ~= nil, "API returned a non-nil result")
        end)
    end
}
