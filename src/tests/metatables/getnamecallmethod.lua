local Util = eUNCUtil
return {
    Run = function()
        return Util.run("getnamecallmethod", function()
            local fn = Util.getGlobal("getnamecallmethod")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: getnamecallmethod") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
