local ui = require('ui')
local default = require('default')


local c_vimote = require('config.vimote')
local c_clang = require('config.clang')


local Vimote = {}
Vimote.__index = Vimote



function Vimote.setup()
    -- Setting the initial keybindings
    current_channel = c_vimote

    -- Loading default profile
    Vimote.loadProf(current_channel)

    -- Creating Commands
    Vimote.createCmd()

end

function Vimote.loadProf(bindings)     
    for k, v in ipairs(bindings) do
            vim.keymap.set(bindings[k].mode, bindings[k].key, bindings[k].cmd)
    end
end


function Vimote.current(bindings)
    for k, v in ipairs(bindings) do
	    print(bindings[k].mode, bindings[k].key, bindings[k].cmd)
    end

end



function Vimote.createCmd()
	local cmd = vim.api

	cmd.nvim_create_user_command('Vimote', function(opts)
		Vimote.MainMenu()
	end, {})

	-- VimoteLoad
	cmd.nvim_create_user_command('VimoteLoad', function(opts)
		if opts.fargs[1] == 'clang' then
	            Vimote.loadProf(c_clang)
		    current_channel = c_clang
	        end

		if opts.fargs[1] == 'default' then
	            Vimote.loadProf(c_vimote)
		    current_channel = c_vimote
	        end
	end,
	{ nargs = 1 })	

	--VimoteCur
	cmd.nvim_create_user_command('VimoteCur', function(opts)
		Vimote.current(current_channel)
	end,
        {})
        
	--VimoteLookup
	cmd.nvim_create_user_command('VimoteLookup', function(opts)
		if opts.fargs[1] == 'clang' then
			Vimote.current(c_clang)
		end
		if opts.fargs[1] == 'default' then
			Vimote.current(c_vimote)
		end
	end,
        { nargs = 1 })

end

function Vimote.MainMenu() 
  local opts = {'default', 'clang', 'cpp', 'javascript', 'lua', 'nim', 'npm',}
  local cb = function(_, sel)
    if sel == 'default' then
	    vim.cmd(":VimoteLoad default")
	    vim.cmd("echo 'Vimote: default profile loaded'")
    end

    if sel == 'clang' then
	    vim.cmd(":VimoteLoad clang")
	    vim.cmd("echo 'Vimote: clang profile loaded'")
    end

  end
  ShowMenu(opts, cb)
end


return Vimote
