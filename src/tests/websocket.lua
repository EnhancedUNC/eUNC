local tests = {}

table.insert(tests, {
    name = "WebSocket.connect",
    run = function()
        if type(WebSocket) ~= "table" or type(WebSocket.connect) ~= "function" then return false end
        return nil, "A live WebSocket test requires a user-approved endpoint."
    end
})

table.insert(tests, {
    name = "syn.websocket.connect",
    run = function()
        if type(syn) ~= "table" or type(syn.websocket) ~= "table" or type(syn.websocket.connect) ~= "function" then return false end
        return nil, "A live WebSocket test requires a user-approved endpoint."
    end
})

return tests
