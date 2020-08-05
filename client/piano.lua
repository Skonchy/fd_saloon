local play = false

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(1)
        for k,v in ipairs(SaloonConfig.PianoSpots) do
            if IsPlayerNearCoords(v.x,v.y,v.z) then
                if not play then 
                    TriggerEvent('redem_roleplay:Tip', "Press G to play piano.", 100)
                    if IsControlJustPressed(0, 0x760A9C6F) then
                        local sitPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(),-0.5,0.0,-0.5)
                        play = true
                        if GetEntityModel(GetPlayerPed())==GetHashKey("mp_male") then
                            print("male task")
                            TaskStartScenarioAtPosition(GetPlayerPed(), GetHashKey('PROP_HUMAN_PIANO'), sitPos.x, sitPos.y, sitPos.z, GetEntityHeading(PlayerPedId()), 0, true, true, 0, true)
                        elseif GetEntityModel(GetPlayerPed())==GetHashKey("mp_female") then
                            print("female task")
                            TaskStartScenarioAtPosition(GetPlayerPed(), GetHashKey('PROP_HUMAN_ABIGAIL_PIANO'), sitPos.x, sitPos.y, sitPos.z, GetEntityHeading(PlayerPedId()), 0, true, true, 0, true)
                        end
                    end
                else
                    TriggerEvent('redem_roleplay:Tip', "Press W to stop playing.", 100)
                    if IsControlJustPressed(0, 0x8FD015D8) then
                        play = false
                        ClearPedTasks(GetPlayerPed())
                        --SetCurrentPedWeapon(GetPlayerPed(), -1569615261, true)
                    end 
                end
            end
        end
    end    
end)

function IsPlayerNearCoords(x, y, z)
    local playerx, playery, playerz = table.unpack(GetEntityCoords(GetPlayerPed(), 0))
    local distance = GetDistanceBetweenCoords(playerx, playery, playerz, x, y, z, true)

    if distance < 0.5 then
        return true
    end
end