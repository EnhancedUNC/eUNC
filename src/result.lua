local Results = {}

local PREFIX = "[eUNC]"

local STATUS_LABELS = {
    pass = "PASS",
    not_passed = "NOT PASSED",
    unknown = "UNKNOWN"
}

local function printLine(message)
    print(PREFIX .. " " .. tostring(message))
end

function Results.printExecutor(information)
    information = information or {}

    printLine("Executor: " .. tostring(information.name or "Unknown"))
    printLine("Version: " .. tostring(information.version or "Unknown"))

    if information.identified then
        printLine("Identification: Confirmed")
    else
        printLine("Identification: Unavailable")
    end
end

function Results.printTest(result)
    local label = STATUS_LABELS[result.status] or "UNKNOWN"
    local name = tostring(result.name or "Unnamed test")

    printLine(string.format("[%s] %s", label, name))

    if result.detail ~= nil and result.detail ~= "" then
        printLine("  " .. tostring(result.detail))
    end
end

function Results.printReport(report)
    report = report or {}

    printLine("----------------------------------------")
    printLine("Benchmark complete")
    printLine(string.format("Tests: %d", tonumber(report.total) or 0))
    printLine(string.format("Passed: %d", tonumber(report.passed) or 0))
    printLine(string.format("Not passed: %d", tonumber(report.notPassed) or 0))
    printLine(string.format("Unknown: %d", tonumber(report.unknown) or 0))
    printLine(string.format("Score: %d%%", tonumber(report.score) or 0))
    printLine("Duration: " .. tostring(report.duration or "0.00s"))
    printLine("----------------------------------------")
end

function Results.printError(message)
    printLine("ERROR: " .. tostring(message))
end

function Results.printWarning(message)
    printLine("WARNING: " .. tostring(message))
end

return Results
