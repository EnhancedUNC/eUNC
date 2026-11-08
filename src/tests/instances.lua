local tests = {}

table.insert(tests, {
    name = "Instance.new",
    run = function()
        local ok, instance = pcall(Instance.new, "Folder")
        if not ok or not instance then return false end
        local valid = instance:IsA("Folder")
        instance:Destroy()
        return valid
    end
})

table.insert(tests, {
    name = "Instance.new.Destroy",
    run = function()
        local ok, instance = pcall(Instance.new, "Folder")
        if not ok or not instance then return false end
        local destroyed = pcall(function() instance:Destroy() end)
        return destroyed
    end
})

return tests
