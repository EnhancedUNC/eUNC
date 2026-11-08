local BASE_URL = "https://raw.githubusercontent.com/EnhancedUNC/eUNC/main/"
local ENV = (getgenv and getgenv()) or _G

local DEFAULT_DEBUG = {
    printcheckpoints = false,
    delaybetweentests = 0,
    printtesttimetaken = false
}

local function getSettings()
    local supplied = type(ENV.eUNCDebug) == "table" and ENV.eUNCDebug or {}
    local settings = {}

    for key, value in pairs(DEFAULT_DEBUG) do
        settings[key] = supplied[key] ~= nil and supplied[key] or value
    end

    settings.printcheckpoints = settings.printcheckpoints == true
    settings.printtesttimetaken = settings.printtesttimetaken == true

    local delay = tonumber(settings.delaybetweentests) or 0
    settings.delaybetweentests = math.max(0, math.min(delay, 5))

    return settings
end

local settings = getSettings()

local function checkpoint(message)
    if settings.printcheckpoints then
        print("[eUNC] " .. tostring(message))
    end
end

local function fetchModule(path)
    local response = game:HttpGet(BASE_URL .. path)

    if type(response) ~= "string" or response == "" then
        error("Empty or invalid response while loading " .. path)
    end

    local chunk, compileError = loadstring(response)
    if type(chunk) ~= "function" then
        error("Unable to compile " .. path .. ": " .. tostring(compileError))
    end

    local ok, result = pcall(chunk)
    if not ok then
        error("Unable to initialize " .. path .. ": " .. tostring(result))
    end

    return result
end

checkpoint("Loading benchmark modules")

local Runner = fetchModule("src/runner.lua")
local Results = fetchModule("src/results.lua")
local Executor = fetchModule("src/executor.lua")

local testModules = {
    "closures", "crypt", "debug", "drawing", "environment", "filesystem",
    "http", "identification", "instances", "metatables", "scripts", "websocket"
}

local tests = {}

for _, moduleName in ipairs(testModules) do
    local path = "src/tests/" .. moduleName .. ".lua"
    local ok, moduleTests = pcall(fetchModule, path)

    if ok and type(moduleTests) == "table" then
        for _, testCase in ipairs(moduleTests) do
            if type(testCase) == "table" and type(testCase.name) == "string" then
                table.insert(tests, testCase)
            end
        end
        checkpoint("Loaded " .. moduleName)
    else
        warn("[eUNC] Could not load " .. moduleName .. ": " .. tostring(moduleTests))
    end
end

if #tests == 0 then
    error("[eUNC] No tests loaded; benchmark cannot continue.")
end

local executorName, executorVersion = Executor.identify()
checkpoint("Identified executor: " .. tostring(executorName))
checkpoint("Starting " .. #tests .. " tests")

local report = Runner.run(tests, settings)
Results.print(report, executorName, executorVersion)

return report
