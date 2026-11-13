local Runner = {}

local function classify(value)
    if value == true then
        return "pass"
    elseif value == false then
        return "not_passed"
    end

    return "unknown"
end

local function executeSubtest(subtest)
    local started = os.clock()
    local result = {
        name = subtest.name or "Unnamed subtest",
        status = "unknown",
        duration = 0,
        detail = nil
    }

    if type(subtest.run) ~= "function" then
        result.detail = "Missing Run function"
        return result
    end

    local ok, value = pcall(subtest.run)

    result.duration = os.clock() - started

    if not ok then
        result.detail = tostring(value)
        return result
    end

    if type(value) == "table" then
        result.status = value.status or "unknown"
        result.detail = value.detail
    else
        result.status = classify(value)
    end

    if result.status ~= "pass"
        and result.status ~= "not_passed"
        and result.status ~= "unknown"
        and result.status ~= "skipped"
    then
        result.status = "unknown"
    end

    return result
end

local function classifySubtests(subtests)
    local passed = 0
    local notPassed = 0
    local unknown = 0
    local skipped = 0

    for _, subtest in ipairs(subtests) do
        if subtest.status == "pass" then
            passed += 1
        elseif subtest.status == "not_passed" then
            notPassed += 1
        elseif subtest.status == "skipped" then
            skipped += 1
        else
            unknown += 1
        end
    end

    local status

    if notPassed > 0 then
        status = "not_passed"
    elseif unknown > 0 then
        status = "unknown"
    elseif passed == 0 and skipped > 0 then
        status = "skipped"
    else
        status = "pass"
    end

    return status, passed, notPassed, unknown, skipped
end

local function executeTest(testCase)
    local started = os.clock()

    local result = {
        name = testCase.name or "Unnamed test",
        category = testCase.category or "uncategorized",
        status = "unknown",
        duration = 0,
        detail = nil,
        subtests = {},
        subtestTotals = {
            total = 0,
            passed = 0,
            notPassed = 0,
            unknown = 0,
            skipped = 0
        }
    }

    if type(testCase.run) ~= "function" then
        result.detail = "Missing Run function"
        return result
    end

    local ok, value = pcall(testCase.run)

    if not ok then
        result.detail = tostring(value)
        result.duration = os.clock() - started
        return result
    end

    if type(value) == "table" and type(value.subtests) == "table" then
        for _, subtest in ipairs(value.subtests) do
            result.subtests[#result.subtests + 1] =
                executeSubtest(subtest)
        end

        local status, passed, notPassed, unknown, skipped =
            classifySubtests(result.subtests)

        result.status = status
        result.subtestTotals = {
            total = #result.subtests,
            passed = passed,
            notPassed = notPassed,
            unknown = unknown,
            skipped = skipped
        }

        result.detail = value.detail
    elseif type(value) == "table" then
        result.status = value.status or "unknown"
        result.detail = value.detail
    else
        result.status = classify(value)
    end

    if result.status ~= "pass"
        and result.status ~= "not_passed"
        and result.status ~= "unknown"
        and result.status ~= "skipped"
    then
        result.status = "unknown"
    end

    result.duration = os.clock() - started

    return result
end

local function calculateCategoryScores(results)
    local categories = {}

    for _, result in ipairs(results) do
        local category = result.category

        if not categories[category] then
            categories[category] = {
                total = 0,
                passed = 0,
                notPassed = 0,
                unknown = 0,
                skipped = 0,
                score = 0
            }
        end

        local data = categories[category]

        data.total += 1

        if result.status == "pass" then
            data.passed += 1
        elseif result.status == "not_passed" then
            data.notPassed += 1
        elseif result.status == "skipped" then
            data.skipped += 1
        else
            data.unknown += 1
        end
    end

    for _, data in pairs(categories) do
        data.score = data.total > 0
            and (data.passed / data.total) * 100
            or 0
    end

    return categories
end

function Runner.run(tests, settings)
    settings = settings or {}

    local started = os.clock()
    local report = {
        total = 0,
        passed = 0,
        notPassed = 0,
        unknown = 0,
        skipped = 0,
        score = 0,
        duration = 0,
        results = {},
        categories = {},
        subtestTotals = {
            total = 0,
            passed = 0,
            notPassed = 0,
            unknown = 0,
            skipped = 0
        }
    }

    for _, testCase in ipairs(tests) do
        local result = executeTest(testCase)

        report.results[#report.results + 1] = result
        report.total += 1

        if result.status == "pass" then
            report.passed += 1
        elseif result.status == "not_passed" then
            report.notPassed += 1
        elseif result.status == "skipped" then
            report.skipped += 1
        else
            report.unknown += 1
        end

        for key, amount in pairs(result.subtestTotals) do
            report.subtestTotals[key] += amount
        end

        if settings.printtesttimetaken == true then
            print(string.format(
                "⏱️ %s: %.4fs",
                result.name,
                result.duration
            ))
        end

        local delay = tonumber(settings.delaybetweentests) or 0

        if delay > 0 and task and type(task.wait) == "function" then
            task.wait(delay)
        end
    end

    report.duration = os.clock() - started

    report.score = report.total > 0
        and (report.passed / report.total) * 100
        or 0

    report.categories = calculateCategoryScores(report.results)

    return report
end

return Runner
