-- [Previous code remains the same until the player data section]

-- In the main HUD thread, modify the PlayerData section:
local PlayerData = Config.framework == 'esx' and Config.core.GetPlayerData() or Config.core.Functions.GetPlayerData()

-- [Rest of the file remains the same]