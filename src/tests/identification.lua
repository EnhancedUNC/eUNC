local tests = {}

table.insert(tests, {
    name = "identifyexecutor",
    run = function()
        if type(identifyexecutor) ~= "function" then return false end
        local ok, name, version = pcall(identifyexecutor)
        return ok and type(name) == "string" and #name > 0
    end
})

table.insert(tests, {
    name = "getexecutorname",
    run = function()
        if type(getexecutorname) ~= "function" then return false end
        local ok, name = pcall(getexecutorname)
        return ok and type(name) == "string" and #name > 0
    end
})

return tests
