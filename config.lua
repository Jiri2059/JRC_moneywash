Config = {}

--Money wash
Config.NeedIDCardToWashMoney = true -- Need item to acces the money wash - item: moneywash_idcard
Config.EnableTax = true --Tax at money wash (how much money it grab)
Config.TaxRate = 10 --In percents %
Config.WashTime = 25 --in seconds
Config.qtarget = true --Use qtarget

--Coordinates for Money Wash
Config.MoneyWash = {
    Loc = {
        WashMoney = {
            vector3(1137.46, -991.97, 46.11)
        }
    }
}
