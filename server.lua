--# # # # # # # # # # # # # # # # # # # # # # # # # # # #
--# ███████ ██   ██  █████  ███    ███ ███████ ██    ██ #
--# ██      ██   ██ ██   ██ ████  ████ ██      ██    ██ #
--# ███████ ███████ ███████ ██ ████ ██ █████   ██    ██ #
--#      ██ ██   ██ ██   ██ ██  ██  ██ ██       ██  ██  #
--# ███████ ██   ██ ██   ██ ██      ██ ███████   ████   #
--#                                                     # 
--#     Owner: sledge_hamm3r                            #
--#     Discord: https://discord.gg/vVnxwGfg            #
--#     Website: https://shamev.de                      #
--# # # # # # # # # # # # # # # # # # # # # # # # # # # #


ESX = exports["es_extended"]:getSharedObject()


-- Lade Konfiguration
local Config = {}
Config = LoadResourceFile(GetCurrentResourceName(), 'config.lua')
Config = load(Config)()

-- Steuerfunktion
function TaxVehicles()
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        local ownedVehicles = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner', {['@owner'] = xPlayer.identifier})
        local taxToPay = #ownedVehicles * Config.TaxAmount
        if taxToPay > 0 then
            xPlayer.removeAccountMoney('bank', taxToPay)
            TriggerClientEvent('okokNotify:Alert', xPlayer.source, 'KFZ-Steuer', 'Du hast ~r~' .. taxToPay .. '~s~ $ KFZ-Steuer bezahlt.', 5000, 'info')
        end
    end
end

-- Steuerintervall
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.TaxInterval)
        TaxVehicles()
    end
end)
