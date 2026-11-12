local Util = eUNCUtil
return {
    Run = function()
        return Util.run("make_writeable", function()
            local fn = Util.getGlobal("makewriteable")
            if type(fn) ~= "function" and not Util.isCallable(fn) then return Util.unknown("API unavailable: makewriteable") end
            return Util.expect(true, "API exists and is callable; no safe generic fixture is defined")
        end)
    end
}
