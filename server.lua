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

-- Konfiguration
local taxAmount = 150 -- Steuerbetrag pro Fahrzeug
local taxInterval = 1800000 -- Steuerintervall in Millisekunden (30 Minuten)1800000

-- Steuerfunktion
function TaxVehicles()
    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        local ownedVehicles = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner', {['@owner'] = xPlayer.identifier})
        local taxToPay = #ownedVehicles * taxAmount
        if taxToPay > 0 then
            xPlayer.removeAccountMoney('bank', taxToPay)
            TriggerClientEvent('esx:showNotification', xPlayer.source, 'Du hast ~r~' .. taxToPay .. '~s~ $ KFZ-Steuer bezahlt.')
        end
    end
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(taxInterval)
        TaxVehicles()
    end
end)
