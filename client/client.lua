-- globals --
onDuty = false

-- functions --
function spawnFood()
    local player = PlayerPedId()
    local playerPos = GetEntityCoords(player)
    local objPos = GetOffsetFromEntityInWorldCoords(player,0.0,1.0,0.0)


    local mealHash = GetHashKey("p_bowl04x_stew")
    RequestModel(mealHash)
    while not HasModelLoaded(mealHash) do
        RequestModel(mealHash)
        print("Waiting for model "..mealHash)
        Citizen.Wait(100)
    end
    RequestModel(plateHash)
    local meal = CreateObject(mealHash,objPos.x,objPos.y,objPos.z,true,false,true)
    Citizen.InvokeNative(0x669655FFB29EF1A9, meal, 0, "Stew_Fill", 1.0)
    PlaceObjectOnGroundProperly(meal,true)
end

function spawnBeer()
    local player = PlayerPedId()
    local playerPos = GetEntityCoords(player)
    local objPos = GetOffsetFromEntityInWorldCoords(player,0.0,1.0,0.0)


    local mealHash = GetHashKey("p_bottleBeer01x")
    RequestModel(mealHash)
    while not HasModelLoaded(mealHash) do
        RequestModel(mealHash)
        print("Waiting for model "..mealHash)
        Citizen.Wait(100)
    end
    RequestModel(plateHash)
    local meal = CreateObject(mealHash,objPos.x,objPos.y,objPos.z,true,false,true)
    PlaceObjectOnGroundProperly(meal,true)
end

function spawnLiquor()
    local player = PlayerPedId()
    local playerPos = GetEntityCoords(player)
    local objPos = GetOffsetFromEntityInWorldCoords(player,0.0,1.0,0.0)


    local mealHash = GetHashKey("p_bottlenavyrum01X")
    RequestModel(mealHash)
    while not HasModelLoaded(mealHash) do
        RequestModel(mealHash)
        print("Waiting for model "..mealHash)
        Citizen.Wait(100)
    end
    RequestModel(plateHash)
    local meal = CreateObject(mealHash,objPos.x,objPos.y,objPos.z,true,false,true)
    PlaceObjectOnGroundProperly(meal,true)
end

function getTargetObject()
    local pos = GetEntityCoords(PlayerPedId())
    local entityWorld = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, 0.0)
    local result = GetClosestObjectOfType(entityWorld.x,entityWorld.y,entityWorld.z,1.5,GetHashKey("p_bowl04x_stew"),false,false,true)
    local type = "food"
    if result == 0 then
        result = GetClosestObjectOfType(entityWorld.x,entityWorld.y,entityWorld.z,1.5,GetHashKey("p_bottleBeer01x"),false,false,true)
        type = "beer"
        if result == 0 then
            result = GetClosestObjectOfType(entityWorld.x,entityWorld.y,entityWorld.z,1.5,GetHashKey("p_bottlenavyrum01X"),false,false,true)
            type = "liquor"
        end
    end
    return result,type
end
-- events --
RegisterNetEvent("fd_saloon:UpdateOnDuty")
AddEventHandler("fd_saloon:UpdateOnDuty", function(bool)
    onDuty = bool
end)
-- threads --
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        local object,type = getTargetObject()
        if object ~= 0 then
            if IsControlJustPressed(1,0x760A9C6F) then -- pressed g
                NetworkRequestControlOfEntity(object)
                while not NetworkHasControlOfEntity(object) do
                    print("gib object")
                    Citizen.Wait(10)
                end
                DeleteEntity(object)
                print(type)
                TriggerServerEvent("fd_saloon:AddToInv",type)
            end
        end
    end
end)

Citizen.CreateThread(function()
    WarMenu.CreateMenu('saloon', "Bartender")
    WarMenu.SetSubTitle('saloon', "For all your saloon needs")

    while true do
        local sleep = 1000
        if onDuty then
            if WarMenu.IsMenuOpened('saloon') then
                if WarMenu.Button("Serve Food") then
                    --spawnFood()
                    TriggerServerEvent("fd_saloon:AddToInv","food")
                elseif WarMenu.Button("Serve Beer") then
                    --spawnBeer()
                    TriggerServerEvent("fd_saloon:AddToInv","beer")
                elseif WarMenu.Button("Serve Liquor") then
                    --spawnLiquor()
                    TriggerServerEvent("fd_saloon:AddToInv","liquor")
                elseif WarMenu.Button("Close") then
                    WarMenu.CloseMenu('saloon')
                end
                WarMenu.Display()
            elseif IsControlJustPressed(1,0x26E9DC00) then -- pressed z 
                WarMenu.OpenMenu('saloon')
            end
            sleep = 1
        else
            TriggerServerEvent("fd_saloon:CheckOnDuty")
        end
        Citizen.Wait(sleep)
    end
end)

-- commands --