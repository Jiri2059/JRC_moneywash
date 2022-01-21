ESX = nil

local HasAlreadyEnteredMarker = false
local LastZone                = nil

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(0)
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end)

function DrawMoneyMarker()
    DrawMarker(2, 1136.0300, -989.5841, 46.1131, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.4, 0.2, 13, 0, 255, 255, 0, 0, 0, 1, 0, 0, 0)
        if GetDistanceBetweenCoords(coords, 1136.0300, -989.5841, 46.1131, true) < 2 then
            TriggerEvent('luke_textui:ShowUI', 'E - Wash Money')
                if IsControlJustReleased(0, 38) then
                    TriggerEvent('moneywash:target')
                end
            end
        end

function WashMoney(amountToWash)
    if Config.NeedIDCardToWashMoney then
        ESX.TriggerServerCallback("JRC_moneywash:checkIDCard", function(result)
            if result == true then
                    local dialog = exports['zf_dialog']:DialogInput({
                        header = "How Much Money do you want to wash?", 
                        rows = {
                            {
                                id = 0, 
                                txt = "Ammount"
                            }
                        }
                    })
                    if dialog ~= nil then
                        if dialog[1].input == nil then return end
                        local amountToWash = tonumber(dialog[1].input)
                        TriggerServerEvent("JRC_moneywash:canWashMoney", amountToWash)
					end
            else
				exports['mythic_notify']:DoHudText('error', 'You dont have an ID Card to access Money Wash.')
            end
        end)
    else
                    local dialog = exports['zf_dialog']:DialogInput({
                        header = "How Much Money do you want to wash?", 
                        rows = {
                            {
                                id = 0, 
                                txt = "Amount"
                            }
                        }
                    })
                    if dialog ~= nil then
                        if dialog[1].input == nil then return end
                        local amountToWash = tonumber(dialog[1].input)
                        local playerPed = PlayerPedId()
                        TriggerServerEvent("JRC_moneywash:canWashMoney", amountToWash)
                        FreezeEntityPosition(playerPed, false)
					end
    end
end

RegisterNetEvent("JRC_moneywash:MoneyWashFunc")
AddEventHandler("JRC_moneywash:MoneyWashFunc", function(amountToWash)
        exports.rprogress:Custom(
            {
                Async = true,
				Duration = Config.WashTime*1000,
                Label = "MONEY IS LAUNDERING. . .",
				Easing = "easeLinear",
                DisableControls = {
                        Mouse = false,
                        Player = false,
                        Vehicle = true
                }
            },
            function(e)
                if not e then
                    ClearPedTasks(PlayerPedId())
                else
                    ClearPedTasks(PlayerPedId())
                end
            end) 
	Citizen.Wait(Config.WashTime*1000)
    TriggerServerEvent("JRC_moneywash:washMoney", amountToWash)
end)

-- Display markers
Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
        if Config.qtarget == false then

		local coords = GetEntityCoords(PlayerPedId())

		    for k,v in pairs(Config.MoneyWash) do
			    if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, 1136.0300, -989.5841, 46.1131, true) < 2) then
                    DrawMoneyMarker()
              end
           end
        end
    end
end)

Citizen.CreateThread(function()
   while true do
    Citizen.Wait(0)
    if Config.qtarget == false then
    local coords = GetEntityCoords(PlayerPedId())

        if GetDistanceBetweenCoords(coords, 1136.0300, -989.5841, 46.1131, true) < 2 then
            TriggerEvent('luke_textui:ShowUI', 'E - Wash Money')
                if IsControlJustReleased(0, 38) then
                    print('Dave je gay')
                    TriggerEvent('moneywash:target')
                end
            else
                TriggerEvent('luke_textui:HideUI')
            end
        end
    end
end)


Citizen.CreateThread(function()
    if Config.qtarget then
        exports.qtarget:AddBoxZone("MoneyWash", vector3(1136.0300, -989.5841, 46.1131), 5.8, 2.4, {
            name="MoneyWash",
            heading=7,
            debugPoly=false,
            minZ=45.76,
            maxZ=47.56
        }, {
            options = {
            {
            event = "moneywash:target",
            icon = "fas fa-money-bill",
            label = "Wash Money",
            },
        },
            distance = 4.0
        })
    end
end)

RegisterNetEvent('moneywash:target')
AddEventHandler('moneywash:target', function()
    WashMoney(amountToWash)
end)  
