local tests = {}

table.insert(tests, {
    name = "getrawmetatable",
    run = function()
        if type(getrawmetatable) ~= "function" then return false end
        local sample = setmetatable({}, { __index = function() return "eUNC" end })
        local ok, mt = pcall(getrawmetatable, sample)
        return ok and type(mt) == "table" and type(mt.__index) == "function"
    end
})

table.insert(tests, {
    name = "isreadonly",
    run = function()
        if type(isreadonly) ~= "function" then return false end
        local sample = {}
        local ok, value = pcall(isreadonly, sample)
        return ok and type(value) == "boolean"
    end
})

table.insert(tests, {
    name = "setreadonly",
    run = function()
        if type(setreadonly) ~= "function" then return false end
        return nil, "Mutating readonly state is excluded from automatic tests."
    end
})

return tests
