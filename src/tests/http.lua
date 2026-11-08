local tests = {}

table.insert(tests, {
    name = "request",
    run = function()
        local requestFunction = request or http_request
        if type(requestFunction) ~= "function" then return false end
        return nil, "Network requests are not sent automatically; endpoint and consent are required."
    end
})

table.insert(tests, {
    name = "syn.request",
    run = function()
        if type(syn) ~= "table" or type(syn.request) ~= "function" then return false end
        return nil, "Network requests are not sent automatically; endpoint and consent are required."
    end
})

return tests
