
local leader = vim.g.mapleader
local CR = '<CR>'


default = {
		{ mode = 'n', key = '<leader>1', cmd = ':Telescope buffers' .. CR},
		{ mode = 'n', key = '<leader>2', cmd = ':Goyo'},
		{ mode = 'n', key = '<leader>3', cmd = ':Neotree'},
		{ mode = 'n', key = leader .. '', cmd = ''},
		{ mode = 'n', key = leader .. '', cmd = ''},
		{ mode = 'n', key = leader .. '', cmd = ''},
		{ mode = 'n', key = leader .. '', cmd = ''},
		{ mode = 'n', key = leader .. '7', cmd = ':colorscheme rose-pine-dawn' .. CR},
		{ mode = 'n', key = leader .. '', cmd = ''},
		{ mode = 'n', key = leader .. '9', cmd = ':Vimdeck current' .. CR},
		{ mode = 'n', key = leader .. '-', cmd = ':Vimdeck menu' .. CR},
}

return default
