local tests = {}

table.insert(tests, {
    name = "getgenv",
    run = function()
        if type(getgenv) ~= "function" then return false end
        local ok, env = pcall(getgenv)
        return ok and type(env) == "table" and env == getgenv()
    end
})

table.insert(tests, {
    name = "getrenv",
    run = function()
        if type(getrenv) ~= "function" then return false end
        local ok, env = pcall(getrenv)
        return ok and type(env) == "table"
    end
})

table.insert(tests, {
    name = "getrawmetatable",
    run = function()
        if type(getrawmetatable) ~= "function" then return false end
        local sample = {}
        local ok, mt = pcall(getrawmetatable, sample)
        return ok and (mt == nil or type(mt) == "table")
    end
})

return tests
