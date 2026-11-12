local Util = eUNCUtil
return {
    Run = function()
        return Util.run("rsa_decrypt", function()
            local fn = Util.getPath(Util.getGlobal("crypt"), {"rsa_decrypt"})
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: crypt.rsa_decrypt") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
