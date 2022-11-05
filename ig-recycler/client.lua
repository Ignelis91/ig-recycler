local table = lib.table
local clocked = false
if cfg.esxLegacy == false then
    ESX = nil -- ESX 
    CreateThread(function()
	    while ESX == nil do
	    	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		    Wait(0)
	    end
    end)
end

RegisterNetEvent('esx:playerLoaded') -- toto načte postavu prostě základ
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

CreateThread(function()
	while true do
        Citizen.Wait(5000)
        if ESX.PlayerData.job and ESX.PlayerData.job.name == cfg.job['job'] then
            if blip == nil then
                blip = AddBlipForCoord(cfg.blip['blipjobcords'])
                AddTextEntry('blip', cfg.blip['blipjobname'])
                SetBlipSprite(blip, 473)
                SetBlipColour(blip, 37)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, 1.0)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName('blip')
                EndTextCommandSetBlipName(blip)
            end

        else
            if blip ~= nil then
                RemoveBlip(blip)
                blip = nil
            end

        end
    end
end)


local boxm = true
local ispakuojama = true
local pajimta = false
RegisterNetEvent('getbox') 
AddEventHandler('getbox', function(xPlayer)
    local playerPed = PlayerPedId()
    if pajimta == false then
    if boxm == true then
    pajimta = true
	TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 5000, true)
    if lib.progressCircle({
        duration = 5000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    }) then end
    Citizen.Wait(500)
    ClearPedTasks(playerPed)
    Citizen.Wait(200)
    boxbum()
    boxm = false
    else 
        Notify(cfg.translation['darturideze'])
    end
    else
        Notify(cfg.translation['jobisnotdone'])
            end
    end)

RegisterNetEvent('ispakuoti') 
AddEventHandler('ispakuoti', function(xPlayer)
    local playerPed = PlayerPedId()
    if pajimta == true then
    if ispakuojama == true then
    ispakuojama = false
    TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 5000, true)
    if lib.progressCircle({
        duration = 5000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    }) then end
    Citizen.Wait(200)
    ClearPedTasks(playerPed)
    DropPackage()
    boxonground()
    TriggerServerEvent('box:items')
    ispakuojama = true
    pajimta = false
    else
        Notify(cfg.translation['darvisispakuojama'])
    end
    else
            Notify(cfg.translation['neturidezes'])
    end
end)
RegisterNetEvent('ig-recycler:pradetiDarba')
AddEventHandler('ig-recycler:pradetiDarba', function() 
    if clocked == false then
    if lib.progressBar({
        duration = 2000,
        label = 'Kalbate Su Darbdaviu',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    }) then clocked = true Notify("Jus Pradejote Pamaina") TriggerEvent("pradejo:darba") 
        exports.ox_target:addSphereZone({
            coords = vec3(-163.4762, 6169.7627, 31.2063),
            radius = 1,
            debug = drawZones,
            id = 1,
            options = {
                {
                    name = 'deze1',
                    event = 'getbox',
                    icon = 'fa-solid fa-box',
                    label = 'Pajimti Deže',
                    groups = cfg.job['job'],
                    distance = 2,
                    canInteract = function(entity, distance, coords, name)
                        return true
                    end
                }
            }
        })
        
        exports.ox_target:addSphereZone({
            coords = vec3(-166.2100, 6166.6343, 31.2016),
            radius = 1,
            debug = drawZones,
            id = 2,
            options = {
                {
                    name = 'deze2',
                    event = 'getbox',
                    icon = 'fa-solid fa-box',
                    label = 'Pajimti Deže',
                    groups = cfg.job['job'],
                    distance = 2,
                    canInteract = function(entity, distance, coords, name)
                        return true
                    end
                }
            }
        })
        
        exports.ox_target:addSphereZone({
            coords = vec3(-164.6830, 6165.0654, 31.2014),
            radius = 1,
            debug = drawZones,
            id = 3,
            options = {
                {
                    name = 'deze3',
                    event = 'getbox',
                    icon = 'fa-solid fa-box',
                    label = 'Pajimti Deže',
                    groups = cfg.job['job'],
                    distance = 2,
                    canInteract = function(entity, distance, coords, name)
                        return true
                    end
                }
            }
        })
        
        exports.ox_target:addSphereZone({
            coords = vec3(-166.9157, 6175.5898, 31.1726),
            radius = 1,
            debug = drawZones,
            id = 4,
            options = {
                {
                    name = 'ispakuoti',
                    event = 'ispakuoti',
                    icon = 'fa-sharp fa-solid fa-box-open',
                    label = 'Išpakuoti Deže',
                    groups = cfg.job['job'],
                    distance = 2,
                    canInteract = function(entity, distance, coords, name)
                        return true
                    end
                }
            }
        })
    end
else
    if lib.progressBar({
        duration = 2000,
        label = 'Kalbate Su Darbdaviu',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
        },
    }) then clocked = false  Notify("Jus Pabaigete Pamaina")
        exports.ox_target:removeZone(1)
        exports.ox_target:removeZone(2)
        exports.ox_target:removeZone(3)
        exports.ox_target:removeZone(4)
    end
end
end)

exports.ox_target:addModel("a_m_m_eastsa_02", {{
    event = 'ig-recycler:pradetiDarba',
    icon = 'fa-solid fa-user-tie',
    label = "Pabaigti/Pradeti Pamaina",
    groups = "recycler",
    distance = 2,
},
{
    serverEvent = 'ig-recycler-sell',
    icon = 'fa-solid fa-money-bill',
    label = "Parduoti Daiktus",
    groups = "recycler",
    distance = 2,   
}})


function boxbum()
    local pos = GetEntityCoords(PlayerPedId(), true)
    RequestAnimDict('anim@heists@box_carry@')
    while (not HasAnimDictLoaded('anim@heists@box_carry@')) do
      Wait(7)
    end
    TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 5.0, -1, -1, 50, 0, false, false, false)
    RequestModel("prop_cs_cardbox_01")
    while not HasModelLoaded("prop_cs_cardbox_01") do
      Wait(0)
    end
    local object5 = CreateObject("prop_cs_cardbox_01", pos.x, pos.y, pos.z, true, true, true)
    AttachEntityToEntity(object5, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.05, 0.1, -0.3, 300.0, 250.0, 20.0, true, true, false, true, 1, true)
    carryPackage = object5
    

end

function boxonground()
    local playerPed = PlayerPedId()
    local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
    local objectCoords = (coords + forward * 1.0)

    ESX.Game.SpawnLocalObject("prop_cs_cardbox_01", objectCoords, function(obj)
        SetEntityHeading(obj, GetEntityHeading(playerPed))
        PlaceObjectOnGroundProperly(obj)
        Wait(10000)
        DeleteObject(obj)
        DeleteEntity(obj)
    
    end)
end

function DropPackage()
    ClearPedTasks(PlayerPedId())
    DetachEntity(carryPackage, true, true)
    DeleteObject(carryPackage)
    carryPackage = nil
    boxm = true

end

local npc = {}
local npcThreadas = 3000
local npc = {}
CreateThread(function() 
	while true do
		Wait(npcThreadas)
		local pos = GetEntityCoords(PlayerPedId())
		local dist = 0
		for k,v in pairs(cfg.npc) do
			dist = #(vec3(v.pos.x, v.pos.y, v.pos.z) - pos)
			if dist < 100 and not v.spawned then
				local hash = GetHashKey(v.model)
				-- Modelio uzkrovimas
				if not HasModelLoaded(hash) then
					RequestModel(hash)
					Wait(10)
				end
				while not HasModelLoaded(hash) do 
					Wait(10)
				end

				local pedas = CreatePed(1, hash, v.pos.x, v.pos.y, v.pos.z, v.pos.h, false, false)
                SetBlockingOfNonTemporaryEvents(pedas, true)
				SetEntityInvincible(pedas, true)
                FreezeEntityPosition(pedas, true)
				SetBlockingOfNonTemporaryEvents(illegpedasalFishSeller, true)
				SetModelAsNoLongerNeeded(hash)
				v.spawned = true
				npc[k] = pedas
			elseif v.spawned and dist > 100 then
				v.spawned = false
				DeleteEntity(npc[k])
			end
		end
	
	end
end)

RegisterNetEvent('ig-recycler:notify')
AddEventHandler('ig-recycler:notify', function(message)
    ESX.ShowNotification(message)
end)