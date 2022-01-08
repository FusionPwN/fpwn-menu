fx_version 'bodacious'

game 'gta5'

description 'FPWN MENU'

version '1.0.0'

ui_page 'html/ui.html'

lua54 'yes'

files {
    'html/font/fa-brands-400.eot',
	'html/font/fa-brands-400.svg',
	'html/font/fa-brands-400.ttf',
	'html/font/fa-brands-400.woff',
	'html/font/fa-brands-400.woff2',
	'html/font/fa-regular-400.eot',
	'html/font/fa-regular-400.svg',
	'html/font/fa-regular-400.ttf',
	'html/font/fa-regular-400.woff',
	'html/font/fa-regular-400.woff2',
	'html/font/fa-solid-900.eot',
	'html/font/fa-solid-900.svg',
	'html/font/fa-solid-900.ttf',
	'html/font/fa-solid-900.woff',
	'html/font/fa-solid-900.woff2',
    'html/css/all.min.css',
    'html/css/animate.css',
    'html/css/bootstrap.min.css',
    'html/css/style.css',
    'html/js/jquery-3.6.0.min.js',
    'html/js/bootstrap.min.js',
    'html/js/script.js',
    'html/ui.html',
}

client_scripts {
    'config.lua',
    'client/menu.lua'
}

escrow_ignore {
	'config.lua'
}