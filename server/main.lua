local resetStress = false
local Config = lib.load('config')

AddEventHandler('ox_inventory:openedInventory', function(source)
    TriggerClientEvent('ts_hud:client:hideHUD', source)
end)

AddEventHandler('ox_inventory:closedInventory', function(source)
    TriggerClientEvent('ts_hud:client:showHud', source)
end)

RegisterNetEvent('hud:server:GainStress', function(amount)
    if not Config.stress.enableStress then return end

    local src = source
    if Config.framework == 'esx' then
        local xPlayer = Config.core.GetPlayerFromId(src)
        if not xPlayer then return end
        
        local newStress = (xPlayer.get('stress') or 0) + amount
        if newStress <= 0 then newStress = 0 end
        if newStress > 100 then newStress = 100 end
        
        xPlayer.set('stress', newStress)
        TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    else
        local player = Config.core.Functions.GetPlayer(src)
        if not player then return end
        
        local newStress
        if not resetStress then
            if not player.PlayerData.metadata.stress then
                player.PlayerData.metadata.stress = 0
            end
            newStress = player.PlayerData.metadata.stress + amount
            if newStress <= 0 then newStress = 0 end
        else
            newStress = 0
        end
        if newStress > 100 then newStress = 100 end
        player.Functions.SetMetaData('stress', newStress)
        TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    end
    
    TriggerClientEvent('ox_lib:notify', src, {
        description = 'Feeling More Stressed!',
        type = 'error',
    })
end)

RegisterNetEvent('hud:server:RelieveStress', function(amount)
    if not Config.stress.enableStress then return end

    local src = source
    if Config.framework == 'esx' then
        local xPlayer = Config.core.GetPlayerFromId(src)
        if not xPlayer then return end
        
        local newStress = (xPlayer.get('stress') or 0) - amount
        if newStress <= 0 then newStress = 0 end
        if newStress > 100 then newStress = 100 end
        
        xPlayer.set('stress', newStress)
        TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    else
        local player = Config.core.Functions.GetPlayer(src)
        if not player then return end
        
        local newStress
        if not resetStress then
            if not player.PlayerData.metadata.stress then
                player.PlayerData.metadata.stress = 0
            end
            newStress = player.PlayerData.metadata.stress - amount
            if newStress <= 0 then newStress = 0 end
        else
            newStress = 0
        end
        if newStress > 100 then newStress = 100 end
        player.Functions.SetMetaData('stress', newStress)
        TriggerClientEvent('hud:client:UpdateStress', src, newStress)
    end
    
    TriggerClientEvent('ox_lib:notify', src, {
        description = 'Feeling Less Stressed!',
        type = 'success',
    })
end)