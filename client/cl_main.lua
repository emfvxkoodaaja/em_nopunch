-- Block Punching Without Aiming
-- made by emfvxkoodaaja

while true do
    if GetPedStealthMovement(PlayerPedId()) then
        SetPedStealthMovement(PlayerPedId(), 0)
    end
    Wait(1)
end

function IsEntityNearby(playerPed)
    local playerCoords = GetEntityCoords(playerPed)
    local nearbyEntities = GetNearbyPeds(playerPed, 3.0)
    
    for _, entity in ipairs(nearbyEntities) do
        if DoesEntityExist(entity) and not IsPedAPlayer(entity) then
            return true
        end
    end
    
    local players = GetActivePlayers()
    for i = 1, #players do
        local targetPed = GetPlayerPed(players[i])
        if targetPed ~= playerPed then
            local targetCoords = GetEntityCoords(targetPed)
            if #(playerCoords - targetCoords) <= 3.0 then
                return true
            end
        end
    end
    
    return false
end

function GetNearbyPeds(playerPed, radius)
    local peds = {}
    local handle, ped = FindFirstPed()
    local success

    repeat
        local pos = GetEntityCoords(ped)
        if DoesEntityExist(ped) and not IsPedAPlayer(ped) and #(pos - GetEntityCoords(playerPed)) <= radius then
            table.insert(peds, ped)
        end
        success, ped = FindNextPed(handle)
    until not success

    EndFindPed(handle)
    return peds
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerPed = PlayerPedId()
        local weaponHash = GetSelectedPedWeapon(playerPed)

        if weaponHash == GetHashKey("WEAPON_UNARMED") then
            if IsControlPressed(0, 25) and IsEntityNearby(playerPed) then
                EnableControlAction(0, 24, true)  
                EnableControlAction(0, 257, true) 
                EnableControlAction(0, 140, true) 
                EnableControlAction(0, 141, true) 
                EnableControlAction(0, 142, true) 
            else
                DisableControlAction(0, 24, true)  
                DisableControlAction(0, 257, true) 
                DisableControlAction(0, 140, true)
                DisableControlAction(0, 141, true) 
                DisableControlAction(0, 142, true) 
            end
        end
    end
end)
