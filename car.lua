RegisterCommand('car', function(source, args, rawCommand)
    local vehicleName = args[1] or "adder" -- Default vehicle is "adder" if no argument is provided

    if not IsModelInCdimage(vehicleName) or not IsModelAVehicle(vehicleName) then
        TriggerEvent('chat:addMessage', {
            args = {"^1Error", "Invalid vehicle model."}
        })
        return
    end

    RequestModel(vehicleName)

    while not HasModelLoaded(vehicleName) do
        Wait(500)
    end

    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)

    local vehicle = CreateVehicle(vehicleName, pos.x, pos.y, pos.z, GetEntityHeading(playerPed), true, false)
    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

    SetModelAsNoLongerNeeded(vehicleName)
end, false)
