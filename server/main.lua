ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('JRC_moneywash:canWashMoney')
AddEventHandler('JRC_moneywash:canWashMoney',function(amountToWash)
    local xPlayer = ESX.GetPlayerFromId(source)
    local bm = xPlayer.getAccount('black_money').money
    if bm > amountToWash and xPlayer.getAccount('black_money').money >= bm then
        xPlayer.removeAccountMoney('black_money', amountToWash)
        TriggerClientEvent("JRC_moneywash:MoneyWashFunc", source, amountToWash)
    else
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'You dont have enough Black Money to wash it!' })
    end
end)

RegisterServerEvent('JRC_moneywash:washMoney')
AddEventHandler('JRC_moneywash:washMoney',function(amountToWash)
	local xPlayer = ESX.GetPlayerFromId(source)
    if Config.EnableTax then
        local tax = Config.TaxRate
        local delete = amountToWash / 100 * tax
        local clean = amountToWash - delete
        xPlayer.addMoney(clean)
		TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'success', text = 'Your money was laundered, you got: $'..clean..'!', })
    else
        xPlayer.addMoney(amountToWash)
    end
end)

ESX.RegisterServerCallback("JRC_moneywash:checkIDCard", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local item = xPlayer.getInventoryItem("moneywash_idcard")

    if item.count >= 1 then
        cb(true)
    else
        cb(false)
    end
end)

print('^5Made By JRC scripts^7: ^1'..GetCurrentResourceName()..'^7 started ^2successfully^7...')
