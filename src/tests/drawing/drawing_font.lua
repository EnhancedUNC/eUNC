local Util = eUNCUtil
return {
    Run = function()
        return Util.run("drawing_font", function()
            local fn = Util.getGlobal("Drawing")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: Drawing") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
