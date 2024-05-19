RegisterServerEvent('k3_antiafk:kick', function()
    if not source or source == -1 then return end
    dbg ("Player: " .. GetPlayerName(source) .. " || ID:  " .. source .. " got kicked from the server for being AFK too long")
    DropPlayer(source, Config.KickMessage)
end)