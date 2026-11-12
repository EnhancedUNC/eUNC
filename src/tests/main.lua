local BASE_URL =
    "https://raw.githubusercontent.com/EnhancedUNC/eUNC/main/"

local ENV = (getgenv and getgenv()) or _G

local CONFIG = ENV.eUNCDebug or {}

local function fetchModule(path)
    local url = BASE_URL .. path

    if type(game) ~= "userdata" and type(game) ~= "table" then
        error("Roblox game environment is unavailable.")
    end

    if type(game.HttpGet) ~= "function" then
        error("game:HttpGet is unavailable.")
    end

    local source = game:HttpGet(url)

    if type(source) ~= "string" or source == "" then
        error("Failed to download " .. path)
    end

    if type(loadstring) ~= "function" then
        error("loadstring is unavailable.")
    end

    local chunk, compileError = loadstring(source, "@" .. path)

    if not chunk then
        error(compileError or "Compilation failed for " .. path)
    end

    local ok, module = pcall(chunk)

    if not ok then
        error(module)
    end

    return module
end

local function loadTests(manifest)
    if type(manifest) ~= "table" then
        error("Test manifest must return a table.")
    end

    local tests = {}

    for _, path in ipairs(manifest) do
        if type(path) ~= "string" then
            error("Invalid test module path in manifest.")
        end

        local module = fetchModule("src/tests/" .. path)

        if type(module) ~= "table" then
            error("Test module did not return a table: " .. path)
        end

        local name = path:gsub("%.lua$", "")

        if type(module.run) == "function" then
            table.insert(tests, {
                name = name,
                run = module.run
            })
        elseif type(module.Run) == "function" then
            table.insert(tests, {
                name = name,
                run = module.Run
            })
        else
            error("Test module has no run function: " .. path)
        end
    end

    return tests
end

local function start()
    print("[eUNC] Enhanced UNC Benchmark")
    print("[eUNC] No spoof, just proof.")
    print("[eUNC] Loading benchmark...")

    local Executor = fetchModule("src/executor.lua")
    local Results = fetchModule("src/results.lua")
    local Runner = fetchModule("src/runner.lua")

    Results.printExecutor(Executor.identify())

    local manifest = fetchModule("src/tests/manifest.lua")
    local tests = loadTests(manifest)

    print("[eUNC] Loaded " .. #tests .. " tests.")

    local report = Runner.run(tests, {
        delaybetweentests = CONFIG.delaybetweentests,
        printtesttimetaken = CONFIG.printtesttimetaken
    })

    if CONFIG.printindividualresults ~= false then
        for _, result in ipairs(report.results) do
            Results.printTest(result)
        end
    end

    Results.printReport(report)

    ENV.eUNCResults = report

    return report
end

local ok, result = pcall(start)

if not ok then
    print("[eUNC] ERROR: " .. tostring(result))
end

return ok and result or nil
