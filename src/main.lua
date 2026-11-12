local ENV = (type(getgenv) == "function" and getgenv()) or _G
local CONFIG = type(ENV.eUNCDebug) == "table" and ENV.eUNCDebug or {}
local BASE_URL = "https://raw.githubusercontent.com/EnhancedUNC/eUNC/main/"

local LOGO = [[   ________  ________   _______   _______
  /        \/    /   \\//   /   \\//       \\
 /         /         //        //        /
/        _/        //         /       --/
/________/\_______//\__/_____ /\________/]]

local function fetchModule(path)
    if not game or type(game.HttpGet) ~= "function" then error("game:HttpGet unavailable") end
    if type(loadstring) ~= "function" then error("loadstring unavailable") end
    local source = game:HttpGet(BASE_URL .. path)
    if type(source) ~= "string" or source == "" then error("Empty module: " .. path) end
    local chunk, compileError = loadstring(source, "@" .. path)
    if not chunk then error(compileError or ("Compile failed: " .. path)) end
    local ok, result = pcall(chunk)
    if not ok then error(result) end
    return result
end

local function exportReport(report, executor)
    if CONFIG.savetodevice ~= true then return false end
    local write = ENV.writefile or _G.writefile
    if type(write) ~= "function" then
        warn("[eUNC] savetodevice enabled, but writefile is unavailable")
        return false
    end
    local payload = {
        benchmark = "eUNC", version = "1.0.0", executor = executor,
        total = report.total, passed = report.passed, notPassed = report.notPassed,
        unknown = report.unknown, score = report.score, duration = report.duration,
        results = report.results
    }
    local encode = (ENV.HttpService or game:GetService("HttpService"))
    if not encode or type(encode.JSONEncode) ~= "function" then
        warn("[eUNC] JSON encoder unavailable; report not saved")
        return false
    end
    local ok, json = pcall(encode.JSONEncode, encode, payload)
    if not ok then warn("[eUNC] JSON encoding failed: " .. tostring(json)); return false end
    local saved, err = pcall(write, "eUNC-results.json", json)
    if not saved then warn("[eUNC] Report save failed: " .. tostring(err)); return false end
    print("[eUNC] Saved eUNC-results.json")
    return true
end

local function start()
    print(LOGO)
    print("Enhanced UNC Benchmark")
    print("No spoof, just proof.")
    print("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

    ENV.eUNCUtil = fetchModule("src/tests/_util.lua")
    local Executor = fetchModule("src/executor.lua")
    local Results = fetchModule("src/results.lua")
    local Runner = fetchModule("src/runner.lua")
    local identity = Executor.identify()
    Results.printExecutor(identity)

    local manifest = fetchModule("src/tests/manifest.lua")
    local tests = {}
    for _, path in ipairs(manifest) do
        local module = fetchModule("src/tests/" .. path)
        local run = type(module) == "table" and (module.Run or module.run)
        if type(run) ~= "function" then error("No Run function in " .. path) end
        tests[#tests + 1] = {name = path:gsub("%.lua$", ""):gsub("^.-/", ""), category = path:match("^([^/]+)/"), run = run}
    end
    print("[eUNC] Loaded " .. #tests .. " tests")
    local report = Runner.run(tests, CONFIG)
    for _, item in ipairs(report.results) do
        if CONFIG.printindividualresults ~= false then Results.printTest(item) end
    end
    Results.printReport(report)
    ENV.eUNCResults = report
    exportReport(report, identity.name .. " " .. identity.version)
    return report
end

local ok, result = pcall(start)
if not ok then warn("[eUNC] Fatal: " .. tostring(result)) end
return ok and result or nil
