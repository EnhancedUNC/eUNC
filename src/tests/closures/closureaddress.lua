local Util = eUNCUtil

return {
    Run = function()
        return Util.run("closuredaddress", function()
            local fn = Util.getfunction("getclosureaddress")
                or Util.getfunction("closureaddress")

            if not fn then
                return Util.unknown("Closure address function unavailable")
            end

            local function target()
                return true
            end

            local ok, address = pcall(fn, target)

            if not ok then
                return Util.fail("Closure address call failed")
            end

            return Util.expect(
                address ~= nil,
                "Returned a closure address"
            )
        end)
    end
}
