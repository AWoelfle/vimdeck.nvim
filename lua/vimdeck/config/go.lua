
local CR = "<CR>"

go = {
	{ mode = 'n', key = '<leader>1', cmd = ':! go run .' },
	{ mode = 'n', key = '<leader>2', cmd = '' .. CR },
	{ mode = 'n', key = '<leader>3', cmd = ':Neotree' .. CR },
	{ mode = 'n', key = '<leader>4', cmd = ''},
	{ mode = 'n', key = '<leader>5', cmd = ':lua require("dapui").toggle()'..CR},
	{ mode = 'n', key = '<leader>6', cmd = ':lua require("dap").continue()'.. CR},
	{ mode = 'n', key = '<leader>7', cmd = ''},
	{ mode = 'n', key = '<leader>8', cmd = ''},
	{ mode = 'n', key = '<leader>9', cmd = ':Vimdeck current' .. CR},
	{ mode = 'n', key = '<leader>0', cmd = ''},
	{ mode = 'n', key = '<leader>-', cmd = ':Vimdeck' .. CR},
}

return go
