local tests = {}

local function add(name, callback)
    table.insert(tests, { name = name, run = callback })
end

add("crypt.base64.decode", function()
    local cryptLib = crypt
    if type(cryptLib) ~= "table" or type(cryptLib.base64) ~= "table" or type(cryptLib.base64.decode) ~= "function" then return false end
    local ok, value = pcall(cryptLib.base64.decode, "ZVVOQw==")
    return ok and value == "eUNC"
end)

add("crypt.base64.encode", function()
    local cryptLib = crypt
    if type(cryptLib) ~= "table" or type(cryptLib.base64) ~= "table" or type(cryptLib.base64.encode) ~= "function" then return false end
    local ok, value = pcall(cryptLib.base64.encode, "eUNC")
    return ok and value == "ZVVOQw=="
end)

add("crypt.base64.roundtrip", function()
    local cryptLib = crypt
    if type(cryptLib) ~= "table" or type(cryptLib.base64) ~= "table" then return nil, "Base64 library unavailable." end
    if type(cryptLib.base64.encode) ~= "function" or type(cryptLib.base64.decode) ~= "function" then return false end
    local input = "eUNC:No spoof, just proof. 123!?"
    local okEncode, encoded = pcall(cryptLib.base64.encode, input)
    if not okEncode or type(encoded) ~= "string" then return false end
    local okDecode, decoded = pcall(cryptLib.base64.decode, encoded)
    return okDecode and decoded == input
end)

add("crypt.generatekey", function()
    if type(crypt) ~= "table" or type(crypt.generatekey) ~= "function" then return false end
    local ok, key = pcall(crypt.generatekey)
    return ok and type(key) == "string" and #key > 0
end)

add("crypt.hash", function()
    if type(crypt) ~= "table" or type(crypt.hash) ~= "function" then return false end
    local ok, first = pcall(crypt.hash, "eUNC benchmark")
    local ok2, second = pcall(crypt.hash, "eUNC benchmark")
    return ok and ok2 and type(first) == "string" and #first > 0 and first == second
end)

add("crypt.random", function()
    if type(crypt) ~= "table" or type(crypt.random) ~= "function" then return nil, "No portable, safe contract for this API." end
    local ok, value = pcall(crypt.random, 16)
    return ok and type(value) == "string" and #value == 16
end)

return tests
