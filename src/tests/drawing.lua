local tests = {}

table.insert(tests, {
    name = "Drawing.new",
    run = function()
        if type(Drawing) ~= "table" or type(Drawing.new) ~= "function" then return false end
        local ok, object = pcall(Drawing.new, "Square")
        if not ok or object == nil then return false end
        if type(object.Remove) == "function" then pcall(object.Remove, object) end
        return true
    end
})

table.insert(tests, {
    name = "Drawing.new.Circle",
    run = function()
        if type(Drawing) ~= "table" or type(Drawing.new) ~= "function" then return false end
        local ok, object = pcall(Drawing.new, "Circle")
        if not ok or object == nil then return false end
        local valid = pcall(function() object.Visible = false end)
        if type(object.Remove) == "function" then pcall(object.Remove, object) end
        return valid
    end
})

return tests
