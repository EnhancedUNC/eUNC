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

local function getGlobal(environment, key)
    if environment then
        local value = environment[key]

        if value ~= nil then
            return value
        end
    end

    if _G then
        return _G[key]
    end

    return nil
end

local function readString(environment, key)
    local value = getGlobal(environment, key)

    if type(value) == "string" and value ~= "" then
        return value
    end

    return nil
end

local function readFunction(environment, key)
    local value = getGlobal(environment, key)

    return type(value) == "function"
        or (
            (type(value) == "table" or type(value) == "userdata")
            and type(getmetatable(value)) == "table"
            and type(getmetatable(value).__call) == "function"
        )
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
        local callback = getGlobal(environment, functionName)

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
        "gethui"
    }

    for _, capability in ipairs(capabilityNames) do
        information.capabilities[capability] =
            readFunction(environment, capability)
    end

    information.capabilities.Drawing =
        getGlobal(environment, "Drawing") ~= nil

    return information
end

return Executor
