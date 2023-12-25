
local CR = '<CR>'


vimote = {
	{ mode = 'n', key = '<leader>1', cmd = ':Telescope buffers' .. CR},
	{ mode = 'n', key = '<leader>2', cmd = ':Goyo' .. CR},
	{ mode = 'n', key = '<leader>3', cmd = ':Neotree' .. CR},
	{ mode = 'n', key = '<leader>4', cmd = ':term' .. CR},
	{ mode = 'n', key = '<leader>5', cmd = ':! brave https://google.com' .. CR},
	{ mode = 'n', key = '<leader>6', cmd = ''},
	{ mode = 'n', key = '<leader>7', cmd = ''},
	{ mode = 'n', key = '<leader>8', cmd = ''},
	{ mode = 'n', key = '<leader>9', cmd = ':VimoteCur' .. CR},
	{ mode = 'n', key = '<leader>0', cmd = ':Lazy' .. CR},
	{ mode = 'n', key = '<leader>-', cmd = ':Vimote' .. CR},
}



vimote_clang = {
	{ mode = 'n', key = '<leader>1', cmd = ':! clang main.c -o main' },
	{ mode = 'n', key = '<leader>2', cmd = ':Goyo' .. CR },
	{ mode = 'n', key = '<leader>3', cmd = ':Neotree' .. CR },
	{ mode = 'n', key = '<leader>4', cmd = ''},
	{ mode = 'n', key = '<leader>5', cmd = ''},
	{ mode = 'n', key = '<leader>6', cmd = ''},
	{ mode = 'n', key = '<leader>7', cmd = ''},
	{ mode = 'n', key = '<leader>8', cmd = ''},
	{ mode = 'n', key = '<leader>9', cmd = ':VimoteCur' .. CR},
	{ mode = 'n', key = '<leader>0', cmd = ''},
	{ mode = 'n', key = '<leader>-', cmd = ':Vimote' .. CR},
}



