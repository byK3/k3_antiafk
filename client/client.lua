local lastAction = 0


local function detectedAfk()
    local warningDurationMs = Config.WarningDuration * 1000

    if Config.NotificationType == "3DText" then
        local timeRemaining = warningDurationMs

        while timeRemaining > 0 do
            Wait(1)
            local playerCoords = GetEntityCoords(PlayerPedId())
            notify(playerCoords.x, playerCoords.y, playerCoords.z)

            if GetTimeSinceLastInput() < 1000 then
                return
            end

            timeRemaining = timeRemaining - 1

            if timeRemaining <= 0 then
                TriggerServerEvent('k3_antiafk:kick')
            end
        end
    else
        notify()
        Wait(warningDurationMs)

        if GetTimeSinceLastInput() > warningDurationMs then
            TriggerServerEvent('k3_antiafk:kick')
        end
    end
end


CreateThread(function()
    local intervalMs = Config.Interval * 1000

    while true do
        Wait(intervalMs)
        local timeSinceLastInput = GetTimeSinceLastInput()

        if timeSinceLastInput - lastAction > intervalMs then
            detectedAfk()
        end

        lastAction = timeSinceLastInput
    end
end)
