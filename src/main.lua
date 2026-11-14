local ENV = (type(getgenv) == "function" and getgenv()) or _G

local CONFIG = type(ENV.eUNCDebug) == "table"
    and ENV.eUNCDebug
    or {}

local BASE_URL =
    "https://raw.githubusercontent.com/EnhancedUNC/eUNC/main/"

local SEPARATOR = "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

local STATUS_SYMBOLS = {
    pass = "✅",
    not_passed = "❌",
    unknown = "⏺️",
    skipped = "🔳"
}

local function exposeGlobal(name, value)
    ENV[name] = value
    _G[name] = value
end

local function fetchModule(path)
    if not game or type(game.HttpGet) ~= "function" then
        error("game:HttpGet unavailable")
    end

    if type(loadstring) ~= "function" then
        error("loadstring unavailable")
    end

    local source = game:HttpGet(BASE_URL .. path)

    if type(source) ~= "string" or source == "" then
        error("Empty module: " .. path)
    end

    local chunk, compileError = loadstring(source, "@" .. path)

    if not chunk then
        error(compileError or ("Compile failed: " .. path))
    end

    local ok, result = pcall(chunk)

    if not ok then
        error(path .. ": " .. tostring(result))
    end

    return result
end

local function getSymbol(status)
    return STATUS_SYMBOLS[status] or "⏺️"
end

local function formatPercentage(value)
    return string.format("%.2f%%", value or 0)
end

local function buildTextReport(report, settings)
    settings = settings or {}

    local lines = {}

    local function addLine(message)
        lines[#lines + 1] = tostring(message or "")
    end

    addLine("    ________  ________   _______   _______")
    addLine("   /        \\/    /   \\//   /   \\//       \\")
    addLine("  /         /         //        //        /")
    addLine(" /        _/        //         /       --/")
    addLine(" \\________/\\_______//\\__/_____/ \\________/")
    addLine("")
    addLine(" Enhanced UNC Benchmark")
    addLine("  No Spoof, just proof")
    addLine(SEPARATOR)
    addLine("")

    if settings.printindividualresults ~= false then
        for _, result in ipairs(report.results or {}) do
            addLine(string.format(
                "%s %s",
                getSymbol(result.status),
                result.name
            ))

            if settings.printsubtests == true then
                for _, subtest in ipairs(result.subtests or {}) do
                    addLine(string.format(
                        "  %s %s",
                        getSymbol(subtest.status),
                        subtest.name
                    ))

                    if settings.printsubtestdetails == true
                        and subtest.detail
                    then
                        addLine("    ↳ " .. tostring(subtest.detail))
                    end
                end
            end

            if settings.printtestdetails == true and result.detail then
                addLine("  ↳ " .. tostring(result.detail))
            end
        end
    end

    addLine("")
    addLine(SEPARATOR)
    addLine("💉 Executor: " .. tostring(report.executor or "Unknown"))
    addLine(string.format("⌛ Took: %.2fs", report.duration or 0))

    addLine(string.format(
        "📊 Passed: %d | Failed: %d | Unknown: %d | Skipped: %d",
        report.passed or 0,
        report.notPassed or 0,
        report.unknown or 0,
        report.skipped or 0
    ))

    addLine("📄 Score: " .. formatPercentage(report.score))
    addLine(SEPARATOR)

    if report.subtestTotals then
        local totals = report.subtestTotals

        addLine(string.format(
            "🧪 Subtests: %d | ✅ %d | ❌ %d | ⏺️ %d | 🔳 %d",
            totals.total or 0,
            totals.passed or 0,
            totals.notPassed or 0,
            totals.unknown or 0,
            totals.skipped or 0
        ))

        addLine(SEPARATOR)
    end

    return table.concat(lines, "\n")
end

local function exportReport(report)
    if CONFIG.savetodevice ~= true then
        return false
    end

    local write = ENV.writefile or _G.writefile

    if type(write) ~= "function" then
        warn("⚠️ savetodevice enabled, but writefile is unavailable")
        return false
    end

    local content = buildTextReport(report, CONFIG)

    local saved, err = pcall(
        write,
        "eUNC-results.txt",
        content
    )

    if not saved then
        warn("❌ Report save failed: " .. tostring(err))
        return false
    end

    print("💾 Saved eUNC-results.txt")
    return true
end

local function sortResults(results)
    local STATUS_ORDER = {
        pass = 1,
        not_passed = 2,
        unknown = 3,
        skipped = 4
    }

    table.sort(results, function(a, b)
        local orderA = STATUS_ORDER[a.status] or 3
        local orderB = STATUS_ORDER[b.status] or 3

        return orderA < orderB
    end)
end

local function start()
    local Executor = fetchModule("src/executor.lua")
    local Results = fetchModule("src/results.lua")
    local Runner = fetchModule("src/runner.lua")

    Results.printBanner()

    local identity = Executor.identify()

    if type(identity) ~= "table" then
        error("Executor identification returned an invalid result")
    end

    local Util = fetchModule("src/tests/_util.lua")

    if type(Util) ~= "table" then
        error("Utility module returned an invalid result")
    end

    exposeGlobal("eUNCUtil", Util)

    local manifest = fetchModule("src/tests/manifest.lua")

    if type(manifest) ~= "table" then
        error("Test manifest returned an invalid result")
    end

    local tests = {}

    for _, path in ipairs(manifest) do
        local ok, module = pcall(
            fetchModule,
            "src/tests/" .. path
        )

        if not ok then
            warn("⚠️ Failed to load " .. path .. ": " .. tostring(module))

            tests[#tests + 1] = {
                name = path:gsub("%.lua$", ""):gsub("^.-/", ""),
                category = path:match("^([^/]+)/"),
                run = function()
                    return nil, "Module loading failed: " .. tostring(module)
                end
            }

            continue
        end

        local run = type(module) == "table"
            and (module.Run or module.run)

        if type(run) ~= "function" then
            warn("⚠️ No Run function in " .. path)

            tests[#tests + 1] = {
                name = path:gsub("%.lua$", ""):gsub("^.-/", ""),
                category = path:match("^([^/]+)/"),
                run = function()
                    return nil, "Missing Run function"
                end
            }

            continue
        end

        tests[#tests + 1] = {
            name = path:gsub("%.lua$", ""):gsub("^.-/", ""),
            category = path:match("^([^/]+)/"),
            run = run
        }
    end

    print("🧪 Loaded " .. #tests .. " test modules")

    local report = Runner.run(tests, CONFIG)

    report.executor = tostring(identity.name or "Unknown")
        .. " "
        .. tostring(identity.version or "")

    sortResults(report.results)

    for _, result in ipairs(report.results) do
        if CONFIG.printindividualresults ~= false then
            Results.printTest(result, {
                printsubtests = CONFIG.printsubtests,
                printsubtestdetails = CONFIG.printsubtestdetails,
                printtestdetails = CONFIG.printtestdetails
            })
        end
    end

    Results.printReport(report)

    exposeGlobal("eUNCResults", report)

    exportReport(report)

    return report
end

local ok, result = pcall(start)

if not ok then
    warn("❌ eUNC Fatal: " .. tostring(result))
end

return ok and result or nil
