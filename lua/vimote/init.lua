
require('default')

local Vimote = {}

Vimote.__index = Vimote



function Vimote.setup()

    -- Setting the initial keybindings
    current_channel = vimote_default
    
    vimote_clang = vimote_clang
    Vimote.loadProf(current_channel)

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

	-- VimoteLoad
	cmd.nvim_create_user_command('VimoteLoad', function(opts)
		if opts.fargs[1] == 'clang' then
	            Vimote.loadProf(vimote_clang)
		    current_channel = vimote_clang
	        end

		if opts.fargs[1] == 'default' then
	            Vimote.loadProf(vimote_default)
		    current_channel = vimote_default
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
			Vimote.current(vimote_clang)
		end
		if opts.fargs[1] == 'default' then
			Vimote.current(vimote_default)
		end
	end,
        { nargs = 1 })

end
return Vimote
