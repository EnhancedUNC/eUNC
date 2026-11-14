local Util = {}

local function getEnvironments()
    local environments = {}

    if type(getgenv) == "function" then
        local ok, environment = pcall(getgenv)

        if ok and type(environment) == "table" then
            environments[#environments + 1] = environment
        end
    end

    if type(_G) == "table" then
        environments[#environments + 1] = _G
    end

    return environments
end

function Util.getGlobal(name)
    if type(name) ~= "string" then
        return nil
    end

    for _, environment in ipairs(getEnvironments()) do
        local value = environment[name]

        if value ~= nil then
            return value
        end
    end

    return nil
end

function Util.getfunction(name)
    local value = Util.getGlobal(name)

    return type(value) == "function" and value or nil
end

function Util.getPath(root, path)
    local current = root

    for _, key in ipairs(path or {}) do
        if current == nil then
            return nil
        end

        current = current[key]
    end

    return current
end

function Util.isCallable(value)
    if type(value) == "function" then
        return true
    end

    if type(value) ~= "table" and type(value) ~= "userdata" then
        return false
    end

    local ok, mt = pcall(getmetatable, value)

    return ok
        and type(mt) == "table"
        and type(mt.__call) == "function"
end

function Util.expect(condition, detail)
    return condition == true,
        detail or (condition and "Assertion passed" or "Assertion failed")
end

function Util.fail(detail)
    return false, detail or "Behavioral assertion failed"
end

function Util.unknown(detail)
    return nil, detail or "Required API or test fixture unavailable"
end

function Util.run(name, callback)
    if type(callback) ~= "function" then
        return Util.fail(name .. ": test callback missing")
    end

    local ok, passed, detail = pcall(callback)

    if not ok then
        return false, name .. " raised: " .. tostring(passed)
    end

    if passed == nil then
        return nil, detail or (name .. " could not be tested")
    end

    return passed == true,
        detail or (
            passed
            and (name .. " behavior verified")
            or (name .. " behavior assertion failed")
        )
end

function Util.safeCall(fn, ...)
    if not Util.isCallable(fn) then
        return false, "Not callable"
    end

    return pcall(fn, ...)
end

function Util.expectType(value, expected)
    return type(value) == expected
end

function Util.expectEqual(a, b)
    return a == b
end

function Util.expectTruthy(value)
    return not not value
end

function Util.expectNonEmptyString(value)
    return type(value) == "string" and #value > 0
end

function Util.expectFiniteNumber(value)
    return type(value) == "number"
        and value == value
        and value ~= math.huge
        and value ~= -math.huge
end

function Util.cleanup(fn)
    if type(fn) ~= "function" then
        return false
    end

    return pcall(fn)
end

return Util
