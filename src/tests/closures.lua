local tests = {}

local function add(name, callback)
    table.insert(tests, { name = name, run = callback })
end

add("clonefunction", function()
    if type(clonefunction) ~= "function" then return false end
    local function original(value) return value .. "!" end
    local ok, clone = pcall(clonefunction, original)
    if not ok or type(clone) ~= "function" or clone == original then return false end
    local ran, result = pcall(clone, "eUNC")
    return ran and result == "eUNC!"
end)

add("newcclosure", function()
    if type(newcclosure) ~= "function" then return false end
    local ok, wrapped = pcall(newcclosure, function(value) return value * 2 end)
    if not ok or type(wrapped) ~= "function" then return false end
    local ran, result = pcall(wrapped, 21)
    return ran and result == 42
end)

add("hookfunction", function()
    if type(hookfunction) ~= "function" then return nil, "Hooking even a local function can alter executor state; not run automatically." end
    return nil, "Not run: state-changing hook test requires explicit opt-in."
end)

add("iscclosure", function()
    if type(iscclosure) ~= "function" then return false end
    local ok, result = pcall(iscclosure, print)
    return ok and type(result) == "boolean"
end)

add("islclosure", function()
    if type(islclosure) ~= "function" then return false end
    local function localFunction() end
    local ok, result = pcall(islclosure, localFunction)
    return ok and result == true
end)

return tests
