-- Sanitizes a message by removing or escaping Discord mentions, links, markdown, emojis,
-- control characters, HTML tags, and trims long messages to prevent unwanted content
local function sanitizeMessage(text)
    -- Prevent Discord mentions
    text = text:gsub("@everyone", "@\u{200B}everyone")
    text = text:gsub("@here", "@\u{200B}here")
    text = text:gsub("<@[%d]+>", "<@\u{200B}>")

    -- Remove URLs
    text = text:gsub("https?://[%w-_%.%?%.:/%+=&]+", "[link removed]")

    -- Escape markdown characters
    text = text:gsub("([*_~`|>])", "\\%1")

    -- Remove custom Discord emojis
    text = text:gsub("<a?:%w+:%d+>", "")

    -- Remove control characters
    text = text:gsub("%c", "")

    -- Remove HTML tags
    text = text:gsub("<.->", "")

    -- Trim long messages to Discord's 2000 character limit
    if #text > 2000 then
        text = text:sub(1, 1997) .. "..."
    end

    -- Remove extra empty lines
    text = text:gsub("\n%s*\n", "\n")

    return text
end

-- Replace this with your actual Discord webhook URL
local url = "https://discord.com/api/webhooks/your_webhook_id/your_webhook_token"

-- Subscribe to a custom event called "logToDiscord"
Events.Subscribe("logToDiscord", function(text)
    -- If you want to send the raw (cleaned) message, uncomment the next line:
    -- text = sanitizeMessage(text)

    -- Prepare the message as a JSON object; escape any quotation marks in the text
    local json = '{"content": "' .. text:gsub('"', '\\"') .. '"}'

    -- Send an asynchronous HTTP POST request to the Discord webhook
    HTTP.RequestAsync(url, "post", json, "application/json", {
        ["Content-Type"] = "application/json"
    }, function(status, data)
        -- Print the response from Discord to the console (optional, for debugging)
        Console.Log("Status: " .. tostring(status) .. ", Response: " .. tostring(data))
    end)
end, true)