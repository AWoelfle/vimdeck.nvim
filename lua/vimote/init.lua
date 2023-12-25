
require('default')

local Vimote = {}
local VimoteBindings = {
	{ mode='n', key='<leader>1', cmd='<cmd> :Telescope buffers <CR>'},
	{ mode='n', key='<leader>2', cmd='<cmd> :Goyo <CR>'},
	{ mode='n', key='<leader>3', cmd='<cmd> :Mason <CR>'},
	{ mode='n', key='<leader>4', cmd='<cmd> :term <CR>'},
	{ mode='n', key='<leader>5', cmd='<cmd> EMPTY <CR>'},
	{ mode='n', key='<leader>6', cmd='<cmd> EMPTY <CR>'},
	{ mode='n', key='<leader>7', cmd='<cmd> EMPTY <CR>'},
	{ mode='n', key='<leader>8', cmd='<cmd> EMPTY <CR>'},
	{ mode='n', key='<leader>9', cmd='<cmd> EMPTY <CR>'},
	{ mode='n', key='<leader>0', cmd='<cmd> :Lazy <CR>'},
}

Vimote.__index = Vimote

function Vimote.setup()
    print("Welcome to Vimote!")

    -- Setting the initial keybindings
    vimote_current = vimote_default
    vimote_clang = vimote_clang

    for i in ipairs(VimoteBindings) do
	    Vimote.addMap(VimoteBindings[i].mode, VimoteBindings[i].key, VimoteBindings[i].cmd)
    end

    

    Vimote.createCmd()

end

function Vimote.current(vimote_map)
    for k, v in ipairs(vimote_map) do
	    print(vimote_map[k].mode, vimote_map[k].key, vimote_map[k].cmd)
    end
end



function Vimote.createCmd()
	local cmd = vim.api

	cmd.nvim_create_user_command('VimoteLoad', function(opts)
		print(Vimote.loadBindings(opts.fargs[1]))
	end,
	{ nargs = 1 })	

	cmd.nvim_create_user_command('VimoteCur', function(opts)
		Vimote.current(vimote_current)
	end,
        {})
        
	cmd.nvim_create_user_command('VimoteLookup', function(opts)
		if opts.fargs[1] == 'clang' then
			Vimote.current(vimote_clang)
		end
		if opts.fargs[1] == 'default' then
			Vimote.current(vimote_default)
		end
	end,
        { nargs = 1 })



end



function Vimote.addMap(mode, key, cmd)
	vim.keymap.set(mode, key, cmd)
end



function Vimote.loadBindings(config_name)
    print(config_name)
end



return Vimote
