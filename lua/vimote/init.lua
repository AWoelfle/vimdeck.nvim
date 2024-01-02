


Vimote = {}
Vimote.__index = Vimote
Vimote.utils = {}


function Vimote.setup(opts, config)
    require('vimote.ui')
    -- Setting the initial keybindings
    current_channel = require('vimote.config.' .. opts)


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
	    print(k, v.mode, v.key, v.cmd)
    end
end

function Vimote.createCmd()
	local cmd = vim.api

	cmd.nvim_create_user_command('Vimote', function(opts)
		Vimote.MainMenu()
	end, {})

	-- VimoteLoad
	cmd.nvim_create_user_command('VimoteLoad', function(opts)
                local config_opt = require('vimote.config.' .. opts.fargs[1])


		if opts.fargs[1] then
	            Vimote.loadProf(config_opt)
		    current_channel = config_opt
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

                local config_opt = 'vimote.config.' .. opts.fargs[1]
		if opts.fargs[1] then
			Vimote.current(config_opt)
		end

	end,
        { nargs = 1 })
end

function Vimote.MainMenu() 
	local opts = {'default', 'clang', 'cpp', 'go', 'javascript', 'lua', 'nim', 'npm', 'zig'}
  	local cb = function(_, sel)
	if sel then
		for i, item in ipairs(opts) do
			if opts[i] == sel then
				vim.cmd(":VimoteLoad " .. sel)
	    	    		vim.cmd("echo 'Vimote: " .. sel ..  " profile loaded'")
		    		break
			end
		end
    	else
	    error("Configuration for " .. sel .. " not found!")
    	end
	end
	ShowMenu(opts, cb)
end


return Vimote
