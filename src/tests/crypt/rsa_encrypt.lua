local Util = eUNCUtil
return {
    Run = function()
        return Util.run("rsa_encrypt", function()
            local fn = Util.getPath(Util.getGlobal("crypt"), {"rsa_encrypt"})
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: crypt.rsa_encrypt") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
