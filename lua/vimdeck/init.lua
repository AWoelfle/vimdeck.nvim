

require('vimdeck.ui')



Vimdeck = {}
Vimdeck.channel = {}


function Vimdeck.setup(opts)
    -- Setting the initial keybindings
    Vimdeck.channel = require('vimdeck.config.default')


    Vimdeck.opts = opts
    -- Loading default profile
    Vimdeck:switch(Vimdeck.channel)

    -- Creating Commands
    Vimdeck.createCmd()


end

function Vimdeck:switch(config)    
    for k, v in ipairs(config) do
            vim.keymap.set(config[k].mode, config[k].key, config[k].cmd)
    end
end

function Vimdeck:current(config)
    for k, v in ipairs(config) do
	    print(k, v.mode, v.key, v.cmd)
    end
end

function Vimdeck:createCmd()
	local cmd = vim.api
	cmd.nvim_create_user_command('Vimdeck', function(opts)
		if opts.fargs[1] == 'menu' then
			Vimdeck.MainMenu(opts)

		elseif opts.fargs[1] == 'current' then
			Vimdeck:current(Vimdeck.channel)

		elseif opts.fargs[1] == 'load' then
			if opts.fargs[2] then
                		local config_opt = require('vimdeck.config.' .. opts.fargs[2])
				Vimdeck:switch(config_opt)
				Vimdeck.channel = config_opt
			end

		elseif opts.fargs[1] == 'lookup' then
			if opts.fargs[2] then
                		local config_opt = require('vimdeck.config.' .. opts.fargs[2])
				Vimdeck:current(config_opt)
			end
		else 
			Vimdeck.MainMenu(opts)
		end
	end, {nargs = '*'})
       
end

function Vimdeck:MainMenu() 
  	local cb = function(_, sel)
	if sel == nil then
		error("Configuration for " .. sel .. " not found!")
    	elseif sel then
		for i, item in ipairs(Vimdeck.opts) do
			if Vimdeck.opts[i] == sel then
				vim.cmd(":Vimdeck load " .. sel)
	    	    		vim.cmd("echo 'Vimdeck: " .. sel ..  " profile loaded'")
		    		break
			end
		end
	end
	end
	ShowMenu(Vimdeck.opts, cb)
end

function Vimdeck:Browse()
	local cb = function(_, sel)
	if sel then
		for i, item in ipairs(Vimdeck.opts) do
			if Vimdeck.opts[i] == sel then
				vim.cmd(":Vimdeck lookup " .. sel)
			end
		end
	end
	end
	ShowMenu(Vimdeck.opts, cb)
end


return Vimdeck
