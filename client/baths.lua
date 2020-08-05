local keys = { ['G'] = 0x760A9C6F, ['S'] = 0xD27782E3, ['W'] = 0x8FD015D8, ['H'] = 0x24978A28, ['G'] = 0x5415BE48, ["ENTER"] = 0xC7B5340A, ['BACKSPACE'] = 0x156F7119 }
local pressTime = 0
local pressLeft = 0


function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end

local function IsNearZone ( location )

    local player = PlayerPedId()
    local playerloc = GetEntityCoords(player, 0)
    


    for i = 1, #location do
        if #(playerloc - location[i]) < 2.0 then
            return true, i
        end
    end

end



local function DisplayHelp( _message, x, y, w, h, enableShadow, col1, col2, col3, a, centre )

    local str = CreateVarString(10, "LITERAL_STRING", _message, Citizen.ResultAsLong())

    SetTextScale(w, h)
    SetTextColor(col1, col2, col3, a)

    SetTextCentre(centre)

    if enableShadow then
        SetTextDropshadow(1, 0, 0, 0, 255)
    end

    Citizen.InvokeNative(0xADA9255D, 10);

    if IsPedUsingAnyScenario(PlayerPedId()) then

    else
        DisplayText(str, x, y)
    end

end



Citizen.CreateThread(function()

    local player = PlayerPedId()
    while true do
    Wait(10)
        local IsZone, IdZone = IsNearZone( SaloonConfig.BathSpots )
 
        if IsZone then
            DisplayHelp(SaloonConfig.bathtext, 0.50, 0.95, 0.6, 0.6, true, 255, 255, 255, 255, true, 10000)
            
            if IsControlJustPressed(0, keys['ENTER']) then --ENTER
                   
					SetCamActive(gameplaycam, true)

                    SetEntityCoords(player,  2629.49, -1223.63, 59.62, true, true, true, false)
                    SetEntityHeading(PlayerPedId(), 354.25)
                        local dict = "mini_games@bathing@regular@arthur"
                        RequestAnimDict(dict)
                            while not HasAnimDictLoaded(dict) do
                                Citizen.Wait(0)
                            end
						local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, -0.5, 0.0)					
						SetEntityCoords(player,  entityWorld.x,entityWorld.y,entityWorld.z, true, true, true, false)
                        TaskPlayAnim(player, dict, "bathing_idle_02", 1.0, 8.0, -1, 1, 0, false, false, false)
                            Citizen.Wait(5000)  
                        TaskPlayAnim(player, dict, "left_leg_scrub_medium", 1.0, 8.0, -1, 1, 0, false, false, false) 
						 Citizen.Wait(2000)
                        TaskPlayAnim(player, dict, "bathing_idle_01", 1.0, 8.0, -1, 1, 0, false, false, false)
                            Citizen.Wait(5000)
                        
            end
					
			if IsControlJustPressed(0, keys['G']) then
					Citizen.Wait(100)
                    DoScreenFadeOut(300)
                    Citizen.Wait(500)
                    ClearPedTasks(player)
                    SetEntityCoords(player,  2630.27, -1223.47, 59.59, true, true, true, false)
                    SetEntityHeading(PlayerPedId(), 252.02)
                    Citizen.Wait(1000)
                    DoScreenFadeIn(300)
					SetCamActive(gameplaycam, true)
					DisplayHud(true)
					DisplayRadar(true)

            end


        end
 
    end
 
end)