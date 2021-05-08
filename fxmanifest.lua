fx_version 'bodacious'

game 'gta5'

author 'JuanSolanoS'
description 'Create custom shops where the users can buy/sell items'
version '1.0.0'

client_script {'client/main.lua'}

server_scripts {
    'config.lua',
    'server/main.lua',
    '@mysql-async/lib/MySQL.lua'
}

ui_page('html/index.html')

files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
}