local Results = {}

local PREFIX = "eUNC"

local STATUS_SYMBOLS = {
    pass = "✅",
    not_passed = "❌",
    unknown = "⏺️",
    skipped = "🔳"
}

local SEPARATOR = "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

local function printLine(message)
    print(message)
end

local function getSymbol(status)
    return STATUS_SYMBOLS[status] or "⏺️"
end

local function formatPercentage(value)
    return string.format("%.2f%%", value or 0)
end

function Results.printBanner()
    printLine("    ________  ________   _______   _______")
    printLine("   /        \\/    /   \\//   /   \\//       \\")
    printLine("  /         /         //        //        /")
    printLine(" /        _/        //         /       --/")
    printLine(" \\________/\\_______//\\__/_____/ \\________/")
    printLine("")
    printLine(" Enhanced UNC Benchmark")
    printLine("  No Spoof, just proof")
    printLine(SEPARATOR)
end

function Results.printTest(result, settings)
    settings = settings or {}

    printLine(string.format(
        "%s %s",
        getSymbol(result.status),
        result.name
    ))

    if settings.printsubtests == true then
        for _, subtest in ipairs(result.subtests or {}) do
            printLine(string.format(
                "  %s %s",
                getSymbol(subtest.status),
                subtest.name
            ))

            if settings.printsubtestdetails == true
                and subtest.detail
            then
                printLine("    ↳ " .. tostring(subtest.detail))
            end
        end
    end

    if settings.printtestdetails == true and result.detail then
        printLine("  ↳ " .. tostring(result.detail))
    end
end

function Results.printReport(report)
    printLine(SEPARATOR)
    printLine("💉 Executor: " .. tostring(report.executor or "Unknown"))
    printLine(string.format("⌛ Took: %.2fs", report.duration or 0))

    printLine(string.format(
        "📊 Passed: %d | Failed: %d | Unknown: %d | Skipped: %d",
        report.passed or 0,
        report.notPassed or 0,
        report.unknown or 0,
        report.skipped or 0
    ))

    printLine("📄 Score: " .. formatPercentage(report.score))
    printLine(SEPARATOR)

    if report.subtestTotals then
        local totals = report.subtestTotals

        printLine(string.format(
            "🧪 Subtests: %d | ✅ %d | ❌ %d | ⏺️ %d | 🔳 %d",
            totals.total or 0,
            totals.passed or 0,
            totals.notPassed or 0,
            totals.unknown or 0,
            totals.skipped or 0
        ))

        printLine(SEPARATOR)
    end
end

return Results
