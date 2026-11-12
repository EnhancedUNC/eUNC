local Runner = {}

local function classify(testCase)
    if type(testCase) ~= "table" then
        return "unknown", "Invalid test case."
    end

    if type(testCase.run) ~= "function" then
        return "unknown", "Test has no callable run function."
    end

    local ok, result, detail = pcall(testCase.run)

    if not ok then
        return "not_passed", tostring(result)
    end

    if result == true then
        return "pass", detail
    end

    if result == false then
        return "not_passed", detail or "Behavioral check returned false."
    end

    return "unknown", detail or "Test did not return a boolean result."
end

function Runner.run(tests, settings)
    settings = settings or {}

    local started = os.clock()

    local report = {
        total = 0,
        passed = 0,
        notPassed = 0,
        unknown = 0,
        score = 0,
        duration = "0.00s",
        results = {},
        categories = {}
    }

    tests = type(tests) == "table" and tests or {}

    for index, testCase in ipairs(tests) do
        local testStarted = os.clock()
        local status, detail = classify(testCase)
        local elapsed = os.clock() - testStarted

        report.total = report.total + 1

        if status == "pass" then
            report.passed = report.passed + 1
        elseif status == "not_passed" then
            report.notPassed = report.notPassed + 1
        else
            report.unknown = report.unknown + 1
        end

        local category = tostring(testCase.category or (tostring(testCase.name or ""):match("^([^/]+)/") or "uncategorized"))
        report.categories[category] = report.categories[category] or {total = 0, passed = 0, notPassed = 0, unknown = 0, score = 0}
        local categoryReport = report.categories[category]
        categoryReport.total = categoryReport.total + 1
        if status == "pass" then categoryReport.passed = categoryReport.passed + 1 elseif status == "not_passed" then categoryReport.notPassed = categoryReport.notPassed + 1 else categoryReport.unknown = categoryReport.unknown + 1 end

        table.insert(report.results, {
            name = testCase.name or "unnamed",
            category = category,
            status = status,
            detail = detail,
            duration = elapsed
        })

        if settings.printtesttimetaken then
            print(string.format(
                "[eUNC] %s: %.4fs",
                tostring(testCase.name or "unnamed"),
                elapsed
            ))
        end

        local delay = tonumber(settings.delaybetweentests) or 0

        if delay > 0
            and task
            and type(task.wait) == "function"
            and index < #tests
        then
            task.wait(math.min(delay, 5))
        end
    end

    report.duration = string.format(
        "%.2fs",
        os.clock() - started
    )

    for _, categoryReport in pairs(report.categories) do
        if categoryReport.total > 0 then categoryReport.score = math.floor(categoryReport.passed / categoryReport.total * 100 + 0.5) end
    end

    if report.total > 0 then
        report.score = math.floor(
            (report.passed / report.total * 100) + 0.5
        )
    end

    return report
end

return Runner
