local Util = eUNCUtil

return {
    Run = function()
        return Util.run("filesystem_roundtrip", function()
            local write = Util.getfunction("writefile")
            local read = Util.getfunction("readfile")
            local delete = Util.getfunction("delfile")
            if not write or not read or not delete then
                return Util.unknown("writefile/readfile/delfile required")
            end
            local path = "eunc_roundtrip_probe.txt"
            local payload = "eUNC filesystem round-trip\n193"
            local wrote, writeError = pcall(write, path, payload)
            if not wrote then return Util.fail("writefile failed: " .. tostring(writeError)) end
            local readOk, actual = pcall(read, path)
            pcall(delete, path)
            if not readOk then return Util.fail("readfile failed: " .. tostring(actual)) end
            return Util.expect(actual == payload, "Written bytes were read back unchanged")
        end)
    end
}
