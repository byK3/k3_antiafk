Config = {}

Config.Debug = true

Config.Interval = 900 -- in seconds (60 = 1 minute)
Config.WarningDuration = 15 -- in seconds


Config.KickMessage = "You got kicked for being AFK too long"
Config.Notification = "Are you still here? Do anything to prevent being kicked"

Config.NotificationType = "3DText" -- "chat" or "3DText"  or you can add your own types in function notify (also you can add framework loadings in resource - its up to you)w

function notify (x,y,z)
    if Config.NotificationType == "chat" then
        TriggerEvent('chat:addMessage', {
            color = { 255, 0, 0},
            multiline = true,
            args = {"[K3-ANTIAFK]", Config.Notification}
        })
    elseif Config.NotificationType == "3DText" then
        local onScreen, _x, _y = World3dToScreen2d(x, y, z)
        local p = GetGameplayCamCoords()
        local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
        local scale = (1 / distance) * 2
        local fov = (1 / GetGameplayCamFov()) * 100
        local scale = scale * fov * 0.5
        if onScreen then
            SetTextScale(0.0, scale)
            SetTextFont(0)
            SetTextProportional(1)
            SetTextColour(255, 0, 0, 215)
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextEdge(2, 0, 0, 0, 150)
            SetTextDropShadow()
            SetTextOutline()
            SetTextEntry("STRING")
            SetTextCentre(1)
            AddTextComponentString(Config.Notification)
            DrawText(_x, _y)
        end
    elseif Config.NotificationType == "custom" then
        -- add custom notification here
    end
end
        


function dbg (msg)
    if Config.Debug then
        local info = debug.getinfo(2, 'Sl')
        local source = info.short_src:match("[^/]+$")
        print(('^3[K3-ANTIAFK]^0 %s (%s:%s)'):format(msg, source, info.currentline))
    end
end
