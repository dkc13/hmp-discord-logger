# HappinessMP Discord Webhook Logger

A simple Lua script for sending log messages from [HappinessMP](https://happinessmp.net) to a Discord channel using webhooks.

This can be useful for logging in-game events, errors, server status updates, or any custom messages from your HappinessMP server to Discord.

## 🚀 Features

- Send messages directly from HappinessMP to Discord
- Uses `Events.Subscribe` and `HTTP.RequestAsync`
- Lightweight and easy to integrate
- Customizable event trigger

## 🔧 Setup

1. Create a [Discord webhook](https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks)
2. Copy your webhook URL
3. Paste it into the `url` variable in the script

## 🧪 Example Script

```lua
Events.Subscribe("chatSubmit", function(chatMessage)
    -- Log the chat message to Discord
    local playerName = Game.GetPlayerName(Game.GetPlayerId())
    Events.CallRemote("logToDiscord", { playerName .. ": " .. chatMessage })
end)
```

## 📌 Requirements

- HappinessMP scripting environment
- Internet access from your server/mod
- Valid Discord webhook URL

## 🛡️ Security Note

Do **not** expose your webhook URL in public repositories – treat it like a password.

## 📄 License

MIT License – you are free to use, modify, and distribute.

---

### 💬 Feedback or ideas?

Feel free to open an issue or fork the project!
