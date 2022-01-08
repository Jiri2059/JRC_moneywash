Config = {}

Config.EnableVersionCheck = true
Config.VersionCheckInterval = 60

--MONEYWASH
Config.NeedIDCardToWashMoney = false
Config.EnableTax = true 
Config.TaxRate = 10 --In percents %

-- BLIP --

Config.EnableMoneyWashBlip = false
Config.WashMoneyBlipName = "Laundry"

--Coordinates for Money Wash
Config.MoneyWash = {
    Loc = {
        WashMoney = {
            vector3(1137.46, -991.97, 46.11)
        }
    }
}
