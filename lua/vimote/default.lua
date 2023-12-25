
local CR = '<CR>'

current_channel = vimote_default

vimote_default = {
	{ mode = 'n', key = '<leader>1', cmd = ':Telescope buffers' .. CR},
	{ mode = 'n', key = '<leader>2', cmd = ':Goyo' .. CR},
	{ mode = 'n', key = '<leader>3', cmd = ':Neotree' .. CR},
	{ mode = 'n', key = '<leader>4', cmd = ':term' .. CR},
	{ mode = 'n', key = '<leader>5', cmd = ''},
	{ mode = 'n', key = '<leader>6', cmd = ''},
	{ mode = 'n', key = '<leader>7', cmd = ''},
	{ mode = 'n', key = '<leader>8', cmd = ''},
	{ mode = 'n', key = '<leader>9', cmd = ''},
	{ mode = 'n', key = '<leader>0', cmd = ''},
}

vimote_clang = {
	name = 'clang',
	{ key = '<leader>1', cmd = ':! clang main.c -o main'},
	{ key = '<leader>2', cmd = ':Goyo'},
	{ key = '<leader>3', cmd = ':Neotree'},
	{ key = '', cmd = ''},
	{ key = '', cmd = ''},
	{ key = '', cmd = ''},
	{ key = '', cmd = ''},
	{ key = '', cmd = ''},
	{ key = '', cmd = ''},
	{ key = '', cmd = ''},

}
