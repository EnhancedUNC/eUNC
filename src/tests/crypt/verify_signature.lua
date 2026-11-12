local Util = eUNCUtil
return {
    Run = function()
        return Util.run("verify_signature", function()
            local fn = Util.getPath(Util.getGlobal("crypt"), {"verify_signature"})
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: crypt.verify_signature") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
