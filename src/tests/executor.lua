local Executor = {}

local function getEnvironment()
    if type(getgenv) == "function" then
        local ok, environment = pcall(getgenv)

        if ok and type(environment) == "table" then
            return environment
        end
    end

    return _G
end

local function readString(environment, key)
    local value = environment[key]

    if type(value) == "string" and value ~= "" then
        return value
    end

    return nil
end

local function readFunction(environment, key)
    return type(environment[key]) == "function"
end

function Executor.identify()
    local environment = getEnvironment()

    local information = {
        name = "Unknown",
        version = "Unknown",
        identified = false,
        capabilities = {}
    }

    local nameFunctions = {
        "identifyexecutor",
        "getexecutorname"
    }

    for _, functionName in ipairs(nameFunctions) do
        local callback = environment[functionName]

        if type(callback) == "function" then
            local ok, name, version = pcall(callback)

            if ok and type(name) == "string" and name ~= "" then
                information.name = name
                information.version = type(version) == "string"
                    and version ~= ""
                    and version
                    or "Unknown"
                information.identified = true
                break
            end
        end
    end

    local stringNames = {
        "ExecutorName",
        "executorname",
        "Executor",
        "executor"
    }

    if not information.identified then
        for _, key in ipairs(stringNames) do
            local name = readString(environment, key)

            if name then
                information.name = name
                information.identified = true
                break
            end
        end
    end

    local capabilityNames = {
        "checkcaller",
        "clonefunction",
        "hookfunction",
        "hookmetamethod",
        "newcclosure",
        "getgc",
        "getreg",
        "getupvalues",
        "setupvalue",
        "getconstants",
        "setconstant",
        "getprotos",
        "getstack",
        "setstack",
        "getrawmetatable",
        "setreadonly",
        "isreadonly",
        "getnamecallmethod",
        "setnamecallmethod",
        "isexecutorclosure",
        "islclosure",
        "iscclosure",
        "gethui",
        "Drawing"
    }

    for _, capability in ipairs(capabilityNames) do
        information.capabilities[capability] =
            readFunction(environment, capability)
    end

    information.capabilities.Drawing =
        environment.Drawing ~= nil

    return information
end

return Executor
