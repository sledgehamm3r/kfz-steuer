
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

Config = {}

-- Steuerbeträge für verschiedene Anzahlen von Fahrzeugen
Config.TaxAmounts = {
    [0] = 0,
    [1] = 50,
    [2] = 100,
    [3] = 230,
}

-- Steuerintervall in Millisekunden (30 Minuten)
Config.TaxInterval = 1800000

return Config

