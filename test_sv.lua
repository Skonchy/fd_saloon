RegisterServerEvent("fd_jailedCunt")
AddEventHandler("fd_jailedCunt", function()
    local src = source
    TriggerEvent("redemrp:getPlayerFromId",src,function(user)
        local identifier = user.getIdentifier()
        MySQL.Async.fetchAll("SELECT * FROM users WHERE group = 'jailed' and identifier = @ident", {ident=identifier}, function(result)
            if result[1] ~= nil then
                TriggerClientEvent("fd_moveBackJail",src)
            end
        end)
    end)
end)