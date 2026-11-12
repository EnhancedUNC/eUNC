local Results = {}

local STATUS_EMOJIS = {
    pass = "",
    not_passed = "",
    unknown = ""
}

local SEPARATOR = "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

local function printLine(message)
    print(tostring(message))
end

function Results.printBanner()
    printLine("   ________  ________   _______   _______")
    printLine("  /        \\/    /   \\//   /   \\//       \\")
    printLine(" /         /         //        //        /")
    printLine("/        _/        //         /       --/")
    printLine("/________/\\_______//\\__/_____/\\________/")
    printLine("")
    printLine("    Enhanced UNC Benchmark")
    printLine("     No Spoof, just proof")
    printLine(SEPARATOR)
    printLine("")
end

function Results.printExecutor(information)
    information = information or {}

    printLine(" Executor: " .. tostring(information.name or "Unknown"))
end

function Results.printTest(result)
    result = result or {}

    local emoji = STATUS_EMOJIS[result.status] or ""
    local name = tostring(result.name or "Unnamed test")

    printLine(emoji .. " " .. name)
end

function Results.printDivider()
    printLine("")
    printLine(SEPARATOR)
    printLine("")
end

function Results.printReport(report)
    report = report or {}

    local passed = tonumber(report.passed) or 0
    local failed = tonumber(report.notPassed or report.failed) or 0
    local unknown = tonumber(report.unknown) or 0
    local duration = tostring(report.duration or "0.00s")
    local score = tonumber(report.score) or 0
    local eid = tostring(report.eID or report.eid or "Unknown")

    printLine("")
    printLine(SEPARATOR)
    printLine("")

    printLine(" Took: " .. duration)
    printLine(string.format(
        " Passed: %d | Failed: %d | Unknown: %d",
        passed,
        failed,
        unknown
    ))
    printLine(string.format(" Score: %d%%", score))

    printLine("")
    printLine(SEPARATOR)
    printLine("")
    printLine("eID: " .. eid)
end

function Results.printError(message)
    printLine(" ERROR: " .. tostring(message))
end

function Results.printWarning(message)
    printLine(" WARNING: " .. tostring(message))
end

return Results
