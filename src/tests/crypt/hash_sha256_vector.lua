local Util = eUNCUtil

return {
    Run = function()
        return Util.run("hash_sha256_vector", function()
            local hash = Util.getfunction("hash")
            if not hash then return Util.unknown("hash unavailable") end
            local ok, result = pcall(hash, "Hello", "sha256")
            if not ok then return Util.fail("hash raised: " .. tostring(result)) end
            local expected = "185f8db32271fe25f561a6fc938b2e264306ec304eda518007d1764826381969"
            return Util.expect(type(result) == "string" and result:lower() == expected,
                "SHA-256 known-answer vector matched")
        end)
    end
}
