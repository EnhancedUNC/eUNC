local Executor = {}

local function tryIdentify(callback)
    if type(callback) ~= "function" then
        return nil, nil
    end

    local ok, name, version = pcall(callback)
    if not ok or type(name) ~= "string" or name == "" then
        return nil, nil
    end

    return name, version ~= nil and tostring(version) or nil
end

function Executor.identify()
    local name, version = tryIdentify(identifyexecutor)
    if name then
        return name, version
    end

    name, version = tryIdentify(getexecutorname)
    if name then
        return name, version
    end

    return "Unknown", nil
end

return Executor
