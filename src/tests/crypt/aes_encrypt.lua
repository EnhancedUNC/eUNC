local Util = eUNCUtil
return {
    Run = function()
        return Util.run("aes_encrypt", function()
            local fn = Util.getPath(Util.getGlobal("crypt"), {"encrypt"})
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: crypt.encrypt") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
