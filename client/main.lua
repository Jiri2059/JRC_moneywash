ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(0)
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end)

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
                        TriggerServerEvent("JRC_moneywash:canWashMoney", amountToWash)
					end
    end
end

RegisterNetEvent("JRC_moneywash:MoneyWashFunc")
AddEventHandler("JRC_moneywash:MoneyWashFunc", function(amountToWash)
        exports.rprogress:Custom(
            {
                Async = true,
				Duration = 25000,
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
	Citizen.Wait(25000)
    TriggerServerEvent("JRC_moneywash:washMoney", amountToWash)
end)

if Config.EnableMoneyWashBlip then
    Citizen.CreateThread(function()
		for k,v in pairs(Config.MoneyWash) do
			for i = 1, #v.WashMoney, 1 do
				local blip = AddBlipForCoord(v.WashMoney[i])
				
				SetBlipSprite (blip, 483)
				SetBlipDisplay(blip, 4)
				SetBlipScale  (blip, 0.8)
				SetBlipColour (blip, 17)
				SetBlipAsShortRange(blip, true)
				
				BeginTextCommandSetBlipName('STRING')
				AddTextComponentSubstringPlayerName(Config.WashMoneyBlipName)
				EndTextCommandSetBlipName(blip)
			end
		end
	end)
end

Citizen.CreateThread(function()
    exports.qtarget:AddBoxZone("MoneyWash", vector3(1135.65, -990.48, 46.11), 5.8, 2.4, {
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
        item = "moneywash_idcard",
        },
    },
        distance = 4.0
    })
end)

RegisterNetEvent('moneywash:target')
AddEventHandler('moneywash:target', function()
    WashMoney(amountToWash)
end)  
