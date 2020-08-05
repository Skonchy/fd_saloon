-- globals --

-- functions --

-- events --
RegisterServerEvent("fd_saloon:AddToInv")
AddEventHandler("fd_saloon:AddToInv", function(type)
    local src = source
    TriggerEvent('redemrp:getPlayerFromId', src, function(user)
        local identifier = user.getIdentifier()
        local charid = user.getSessionVar("charid")
        local item
        if type == "food" then
            item = "meatstew"
        elseif type == "beer" then
            item = "beer"
        else
            item = "whiskey"
        end
        local amount = 1
        local test = 1
        TriggerEvent("item:add", src, {item, amount, test})
        TriggerClientEvent('gui:ReloadMenu', src)
    end)
end)

RegisterServerEvent("fd_saloon:CheckOnDuty")
AddEventHandler("fd_saloon:CheckOnDuty", function()
    local src = source
    TriggerEvent('redemrp:getPlayerFromId', src, function(user)
        local identifier = user.getIdentifier()
        print("checking on duty")
        if user.getJob() == "saloon" then
            TriggerClientEvent("fd_saloon:UpdateOnDuty",src,true)
        else
            TriggerClientEvent("fd_saloon:UpdateOnDuty",src,false)
        end
    end)
end)
-- threads --

-- commands --
RegisterCommand("openSaloon", function(src,args,raw)
    TriggerEvent('redemrp:getPlayerFromId', src, function(user)
        local ident = user.getIdentifier()
        MySQL.Async.fetchAll("SELECT * FROM saloons WHERE owner = @owner",{owner = ident},function(result)
            if result[1] ~= nil then
                TriggerClientEvent("fd_saloon:UpdateOnDuty",src,true)
                TriggerClientEvent("chat:addMessage", src, {
                    color = {255,0,0},
                    multiline = true,
                    args = {"Government", "Your saloon is now open."}
                })
                user.setJob("saloon")
                print(user.getJob())
            else
                TriggerClientEvent("chat:addMessage", src, {
                    color = {255,0,0},
                    multiline = true,
                    args = {"Government", "You don't own a saloon."}
                })
            end
        end)
    end)
end)

RegisterCommand("closeSaloon", function(src,args,raw)
    TriggerEvent('redemrp:getPlayerFromId', src, function(user)
        local ident = user.getIdentifier()
        MySQL.Async.fetchAll("SELECT * FROM saloons WHERE owner = @owner",{owner = ident},function(result)
            if result[1] ~= nil then
                TriggerClientEvent("fd_saloon:UpdateOnDuty",src,false)
                TriggerClientEvent("chat:addMessage", src, {
                    color = {255,0,0},
                    multiline = true,
                    args = {"Government", "Your saloon is now closed."}
                })
                user.setJob("unemployed")
                print(user.getJob())
            else
                TriggerClientEvent("chat:addMessage", src, {
                    color = {255,0,0},
                    multiline = true,
                    args = {"Government", "You don't own a saloon."}
                })
            end
        end)
    end)
end)