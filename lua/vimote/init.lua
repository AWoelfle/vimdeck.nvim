

require('vimote.ui')



Vimote = {}
Vimote.channel = {}


function Vimote.setup(opts)
    -- Setting the initial keybindings
    Vimote.channel = require('vimote.config.default')


    Vimote.opts = opts
    -- Loading default profile
    Vimote:switch(Vimote.channel)

    -- Creating Commands
    Vimote.createCmd()


end

function Vimote:switch(config)    
    for k, v in ipairs(config) do
            vim.keymap.set(config[k].mode, config[k].key, config[k].cmd)
    end
end

function Vimote:current(config)
    for k, v in ipairs(config) do
	    print(k, v.mode, v.key, v.cmd)
    end
end

function Vimote:createCmd()
	local cmd = vim.api
	cmd.nvim_create_user_command('Vimote', function(opts)
		if opts.fargs[1] == 'menu' then
			Vimote.MainMenu(opts)

		elseif opts.fargs[1] == 'current' then
			Vimote:current(Vimote.channel)

		elseif opts.fargs[1] == 'load' then
			if opts.fargs[2] then
                		local config_opt = require('vimote.config.' .. opts.fargs[2])
				Vimote:switch(config_opt)
				Vimote.channel = config_opt
			end

		elseif opts.fargs[1] == 'lookup' then
			if opts.fargs[2] then
                		local config_opt = require('vimote.config.' .. opts.fargs[2])
				Vimote:current(config_opt)
			end
		else 
			Vimote.MainMenu(opts)
		end
	end, {nargs = '*'})
       
end

function Vimote:MainMenu() 
  	local cb = function(_, sel)
	if sel == nil then
		error("Configuration for " .. sel .. " not found!")
    	elseif sel then
		for i, item in ipairs(Vimote.opts) do
			if Vimote.opts[i] == sel then
				vim.cmd(":Vimote load " .. sel)
	    	    		vim.cmd("echo 'Vimote: " .. sel ..  " profile loaded'")
		    		break
			end
		end
	end
	end
	ShowMenu(Vimote.opts, cb)
end

function Vimote:Browse()
	local cb = function(_, sel)
	if sel then
		for i, item in ipairs(Vimote.opts) do
			if Vimote.opts[i] == sel then
				vim.cmd(":Vimote lookup " .. sel)
			end
		end
	end
	end
	ShowMenu(Vimote.opts, cb)
end


return Vimote
