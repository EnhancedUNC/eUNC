local tests = {}

local function add(name, callback)
    table.insert(tests, { name = name, run = callback })
end

local function uniquePath()
    return "eunc_probe_" .. tostring(math.floor(os.clock() * 1000000)) .. ".tmp"
end

add("delfile", function()
    if type(delfile) ~= "function" then return false end
    return nil, "Deletion is only tested as cleanup after a successful isolated write."
end)

add("filesystem.isfile", function()
    if type(isfile) ~= "function" then return false end
    if type(writefile) ~= "function" or type(readfile) ~= "function" or type(delfile) ~= "function" then
        return nil, "Requires writefile, readfile, and delfile for a reversible check."
    end
    local path = uniquePath()
    local payload = "eUNC:" .. path
    local wrote = pcall(writefile, path, payload)
    if not wrote then return false end
    local checked, exists = pcall(isfile, path)
    local readOK, contents = pcall(readfile, path)
    pcall(delfile, path)
    return checked and exists == true and readOK and contents == payload
end)

add("readfile", function()
    if type(readfile) ~= "function" or type(writefile) ~= "function" or type(delfile) ~= "function" then return false end
    local path = uniquePath()
    local payload = "eUNC read/write verification"
    local wrote = pcall(writefile, path, payload)
    if not wrote then return false end
    local ok, value = pcall(readfile, path)
    pcall(delfile, path)
    return ok and value == payload
end)

add("writefile", function()
    if type(writefile) ~= "function" or type(readfile) ~= "function" or type(delfile) ~= "function" then return false end
    local path = uniquePath()
    local payload = "eUNC write verification"
    local ok = pcall(writefile, path, payload)
    if not ok then return false end
    local readOK, value = pcall(readfile, path)
    pcall(delfile, path)
    return readOK and value == payload
end)

return tests
