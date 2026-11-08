local tests = {}

local function add(name, callback)
    table.insert(tests, { name = name, run = callback })
end

add("debug.getinfo", function()
    if type(debug) ~= "table" or type(debug.getinfo) ~= "function" then return false end
    local function target() return true end
    local ok, info = pcall(debug.getinfo, target)
    return ok and type(info) == "table"
end)

add("debug.getupvalue", function()
    if type(debug) ~= "table" or type(debug.getupvalue) ~= "function" then return false end
    local captured = "eUNC"
    local function target() return captured end
    local ok, name, value = pcall(debug.getupvalue, target, 1)
    return ok and name ~= nil and value == "eUNC"
end)

add("debug.getconstant", function()
    if type(debug) ~= "table" or type(debug.getconstant) ~= "function" then return false end
    return nil, "Constant inspection is executor-specific; no portable expected result."
end)

add("debug.getconstants", function()
    if type(debug) ~= "table" or type(debug.getconstants) ~= "function" then return false end
    return nil, "Constant inspection is executor-specific; no portable expected result."
end)

add("debug.getregistry", function()
    if type(debug) ~= "table" or type(debug.getregistry) ~= "function" then return false end
    local ok, registry = pcall(debug.getregistry)
    return ok and type(registry) == "table"
end)

return tests
