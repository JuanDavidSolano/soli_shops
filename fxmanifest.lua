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
    'html/shop_creator/index.html',
    'html/shop_creator/style.css',
    'html/shop_creator/script.js',
    'html/shop_ui/index.html',
    'html/shop_ui/style.css',
    'html/shop_ui/script.js',
}