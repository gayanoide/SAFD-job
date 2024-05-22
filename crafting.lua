local disablecontrol = false
Citizen.CreateThread(function()
	while true do
	Citizen.Wait(0)
	    if disablecontrol then
	    	FreezeEntityPosition(PlayerPedId(), true)
		else
			FreezeEntityPosition(PlayerPedId(), false)
		end
	end
end)




RegisterNetEvent('safd:craft')
AddEventHandler('safd:craft', function(type, data)
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'safd' then
        exports.ox_lib:showContext('safdcraft')  
    else
        ESX.ShowNotification("~y~ta pas acces miskin")
    end
end)


exports.ox_lib:registerContext({
    id = 'safdcraft',
    title = "Table de craft",
    options = {
        {
            title = 'Bandage',
            description = "pour faire un bandage vous avez besoin de 2 compresses",
            image = "nui://ox_inventory/web/images/bandage.png",
            progress = '100',
            onSelect = function()

                ExecuteCommand("e cleanhands")
                disablecontrol = true
				TriggerServerEvent('hsafd:addbandage') 
                Citizen.Wait(5000)
                disablecontrol = false
                ExecuteCommand("emotecancel")

            end,
        },
        {
            title = 'Kit de soin',
            description = "pour faire un kit vous avez besoin de 2 bandages",
            image = "nui://ox_inventory/web/images/medikit.png",
            progress = '100',
            onSelect = function()

                ExecuteCommand("e cleanhands")
                disablecontrol = true
				TriggerServerEvent('hsafd:addmedikit')
                Citizen.Wait(5000)
                disablecontrol = false
                ExecuteCommand("emotecancel")
            end,
        },
    },
})











































RegisterNetEvent('safd:coffre')
AddEventHandler('safd:coffre', function(type, data)
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'safd' then
        
        CoffreMax = Config.pos.coffre.poids
        exports.ox_inventory:openInventory('stash', {id = 'society_safd'})
    else
        ESX.ShowNotification("~y~ta pas acces miskin")
    end
end)

exports.ox_target:addBoxZone(
    {
        coords = vec3(Config.pos.coffre.position.x, Config.pos.coffre.position.y, Config.pos.coffre.position.z),
        size = vec3(1, 1, 1),
        rotation = 0,
        debug = drawZones,
        options = {
            {
                name = 'box',
                event = 'safd:coffre',
                icon = 'fa-solid fa-cube',
                label = 'Acceder au coffre',
            },
        },
        minZ = Config.pos.coffre.position.z - 0.3,
        maxZ = Config.pos.coffre.position.z + 0.3,
    }
)

exports.ox_target:addBoxZone(
    {
        coords = vec3(Config.pos.craft.position.x, Config.pos.craft.position.y, Config.pos.craft.position.z),
        size = vec3(1, 1, 1),
        rotation = 0,
        debug = drawZones,
        options = {
            {
                name = 'box',
                event = 'safd:craft',
                icon = 'fa-solid fa-cube',
                label = 'Acceder au craft',
            },
        },
        minZ = Config.pos.craft.position.z - 0.3,
        maxZ = Config.pos.craft.position.z + 0.3,
    }
)