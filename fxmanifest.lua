fx_version "adamant"

game "rdr3"

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

version '1.0.0'

shared_script "config.lua"

client_scripts {
    "client/client.lua",
    "client/piano.lua",
    "client/warmenu.lua"
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    "server.lua"
}