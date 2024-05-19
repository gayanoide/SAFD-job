local blip = nil

RegisterServerEvent('startFire')
AddEventHandler('startFire', function()
    local players = GetPlayers()
    local safdOnline = false
    for _, playerId in ipairs(players) do
        if IsPlayerInSafd(playerId) then
            safdOnline = true
            break
        end
    end

    if safdOnline then
        local x = math.random(-1000, 1000)
        local y = math.random(-1000, 1000)
        local z = 30

        TriggerClientEvent('spawnFire', -1, x, y, z)
    end
end)

RegisterServerEvent('fireAlert')
AddEventHandler('fireAlert', function()
    local players = GetPlayers()
    for _, playerId in ipairs(players) do
        if IsPlayerInSafd(playerId) then
            local x, y, z = GetEntityCoords(GetPlayerPed(playerId))
            blip = AddBlipForCoord(x, y, z)
            SetBlipSprite(blip, 436)
            SetBlipColour(blip, 1)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Incendie")
            EndTextCommandSetBlipName(blip)
            break
        end
    end
end)

RegisterServerEvent('extinguishFire')
AddEventHandler('extinguishFire', function()
    if blip ~= nil then
        RemoveBlip(blip)
        blip = nil
    end
end)

function GetPlayers()
    local players = {}
    for _, player in ipairs(GetPlayers()) do
        table.insert(players, player)
    end
    return players
end

function IsPlayerInSafd(playerId)
    return false -- Implement your own logic here
end
