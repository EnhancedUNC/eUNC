local Results = {}

local PREFIX = ""

local STATUS_EMOJIS = {
    pass = "",
    not_passed = "",
    unknown = ""
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
    local emoji = STATUS_EMOJIS[result.status] or ""
    local name = tostring(result.name or "Unnamed test")

    printLine(emoji .. " " .. name)
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
    printLine(" ERROR: " .. tostring(message))
end

function Results.printWarning(message)
    printLine(" WARNING: " .. tostring(message))
end

return Results
