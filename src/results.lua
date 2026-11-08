local Results = {}

local STATUS_ICONS = {
    pass = "✅",
    not_passed = "❌",
    unknown = "⏺️"
}

local STATUS_ORDER = {
    pass = 1,
    not_passed = 2,
    unknown = 3
}

local function sortResults(results)
    local sorted = {}

    for _, result in ipairs(results or {}) do
        table.insert(sorted, result)
    end

    table.sort(sorted, function(a, b)
        local orderA = STATUS_ORDER[a.status] or 4
        local orderB = STATUS_ORDER[b.status] or 4

        if orderA ~= orderB then
            return orderA < orderB
        end

        return string.lower(tostring(a.name or "")) < string.lower(tostring(b.name or ""))
    end)

    return sorted
end

function Results.print(report, executorName, executorVersion)
    report = report or {}
    local results = sortResults(report.results)
    local elapsed = report.duration or "Unknown"

    print("")
    print("███████╗██╗   ██╗███╗   ██╗ ██████╗")
    print("██╔════╝██║   ██║████╗  ██║██╔════╝")
    print("█████╗  ██║   ██║██╔██╗ ██║██║     ")
    print("██╔══╝  ██║   ██║██║╚██╗██║██║     ")
    print("███████╗╚██████╔╝██║ ╚████║╚██████╗")
    print("╚══════╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝")
    print("")
    print("         Enhanced UNC")
    print('      "No spoof, just proof."')
    print("")
    print("────────────────────────────────────────")

    for _, result in ipairs(results) do
        print("  " .. (STATUS_ICONS[result.status] or "⏺️") .. " " .. tostring(result.name or "Unnamed Test"))
    end

    print("")
    print("────────────────────────────────────────")
    print("🕒 Took: " .. tostring(elapsed))
    print("📊 Final Score: " .. tostring(report.score or 0) .. "%")
    print("Passed: " .. tostring(report.passed or 0) ..
        " | Failed: " .. tostring(report.notPassed or 0) ..
        " | Unknown: " .. tostring(report.unknown or 0))
    print("💉 Executor: " .. tostring(executorName or "Unknown"))

    if executorVersion and tostring(executorVersion) ~= "" then
        print("Executor Version: " .. tostring(executorVersion))
    end

    print("")
    print("────────────────────────────────────────")
    print("eUNC. No spoof, just proof.")
    print("")
end

return Results
