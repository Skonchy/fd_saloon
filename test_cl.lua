RegisterNetEvent("fd_moveBackJail")
AddEventHandling("fd_moveBackJail", function()
    local playerPed = PlayerPedId()
    local playerPos = GetEntityCoords(playerPed)
    local distance = #(JailConfig.Pos - playerPos)
    if distance > JailConfig.Radius then
        SetEntityCoords(playerPed,JailConfig.Pos.x,JailConfig.Pos.y,JailConfig.Pos.z,true)
    end
end)

Citizen.CreateThread(function()
    while true do
        TriggerServerEvent("fd_jailedCunt")
        Citizen.Wait(1000)
    end
end)