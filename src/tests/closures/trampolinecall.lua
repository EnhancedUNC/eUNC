local Util = eUNCUtil

return {
    Run = function()
        return Util.run("trampoline_call", function()
            local trampoline = Util.getfunction("trampoline_call")

            if not trampoline then
                return Util.unknown("API unavailable: trampoline_call")
            end

            local expectedFirst = "eUNC_trampoline_test"
            local expectedSecond = 1337

            local function target(first, second)
                return first, second, true
            end

            local ok, first, second, third = pcall(
                trampoline,
                target,
                {},
                {},
                expectedFirst,
                expectedSecond
            )

            if not ok then
                return Util.fail(
                    "trampoline_call raised: " .. tostring(first)
                )
            end

            if first ~= true then
                return Util.fail(
                    "Callback execution failed: " .. tostring(second)
                )
            end

            if second ~= expectedFirst then
                return Util.fail("First argument or return value was not preserved")
            end

            if third ~= expectedSecond then
                return Util.fail("Second argument or return value was not preserved")
            end

            if select(4, trampoline(
                function()
                    return true
                end,
                {},
                {}
            )) ~= nil then
                return Util.fail("Unexpected extra return value")
            end

            return Util.expect(
                true,
                "Callback execution, argument forwarding, and multiple return values verified"
            )
        end)
    end
}
