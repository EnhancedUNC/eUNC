local tests = {}

table.insert(tests, {
    name = "getcallingscript",
    run = function()
        if type(getcallingscript) ~= "function" then return false end
        local ok, result = pcall(getcallingscript)
        return ok and (result == nil or typeof(result) == "Instance")
    end
})

table.insert(tests, {
    name = "getscripts",
    run = function()
        if type(getscripts) ~= "function" then return false end
        local ok, result = pcall(getscripts)
        return ok and type(result) == "table"
    end
})

table.insert(tests, {
    name = "getsenv",
    run = function()
        if type(getsenv) ~= "function" then return false end
        return nil, "Requires a known LocalScript target; not guessed or invoked automatically."
    end
})

return tests
