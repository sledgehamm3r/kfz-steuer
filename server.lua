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
        local vehicleCount = #ownedVehicles
        local taxAmount = Config.TaxAmounts[vehicleCount] or Config.TaxAmounts[#Config.TaxAmounts]
        local taxToPay = vehicleCount * taxAmount
        if taxToPay > 0 then
            xPlayer.removeAccountMoney('bank', taxToPay)
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Du hast ~r~' .. taxToPay .. '~s~ $ KFZ-Steuer bezahlt.')
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.TaxInterval)
        TaxVehicles()
    end
end)
