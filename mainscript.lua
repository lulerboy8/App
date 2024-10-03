-- Main script to be loaded via loadstring
local function main(keyOlympic)
    -- Get necessary services
    local HttpService = game:GetService("HttpService")
    local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
    local Players = game:GetService("Players")

    -- Define the webhook URL
    local webhookUrl = "https://discord.com/api/webhooks/1289978384532770948/vIiP63PE2BGxIGBxO2UDOUhEeNykYhwBoQe7U9KM58_q6_00TCQvcIYePQHuiciWpT4K"

    -- Load the keys table via loadstring from an external source
    local keys = loadstring(game:HttpGet("https://pastefy.app/Jo1WTRwZ/raw"))()

    -- Function to send a webhook notification
    local function sendClientIdToDiscord(clientId, message)
        local payload = HttpService:JSONEncode({content = message .. clientId})

        local response = http_request({
            Url = webhookUrl,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = payload
        })

        print("Status Code: " .. response.StatusCode)  -- Optional: Print the response status for debugging
        print("Response Body: " .. response.Body)       -- Optional: Print the response body
    end

    -- Generate Client ID
    local clientId = RbxAnalyticsService:GetClientId()

    -- Check if the key is valid and associate the client ID if necessary
    if keys[keyOlympic] == nil then
        -- Invalid key
        sendClientIdToDiscord(clientId, "Invalid key attempted: " .. keyOlympic .. " with client ID: ")
        wait(1)
        local player = Players.LocalPlayer
        player:Kick("Invalid key")
    elseif keys[keyOlympic] == clientId then
        -- Valid key and client ID
        loadstring(game:HttpGet("https://pastefy.app/N0qRkmVK/raw"))()
    elseif keys[keyOlympic] == nil then
        -- First time use, associate the client ID with the key
        keys[keyOlympic] = clientId
        sendClientIdToDiscord(clientId, "New client ID connected to the key: " .. keyOlympic .. " with client ID: ")
        -- Load the script
        loadstring(game:HttpGet("https://pastefy.app/N0qRkmVK/raw"))()
    else
        -- Invalid client ID for the key
        sendClientIdToDiscord(clientId, "Invalid client ID attempted: " .. clientId .. " for key: " .. keyOlympic)
        wait(1)
        local player = Players.LocalPlayer
        player:Kick("Not whitelisted")
    end
end

-- Return the main function to be called with the key
return main
