local Util = eUNCUtil
return {
    Run = function()
        return Util.run("base64_encode_binary", function()
            local fn = Util.getPath(Util.getGlobal("crypt"), {"base64encode"})
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: crypt.base64encode") end
            local ok, result = pcall(fn, "Hello")
            if not ok then return Util.fail("API raised: " .. tostring(result)) end
            return Util.expect(result ~= nil, "API returned a non-nil result")
        end)
    end
}
