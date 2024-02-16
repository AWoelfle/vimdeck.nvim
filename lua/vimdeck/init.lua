require('vimdeck.ui')


Vimdeck = {}
Vimdeck.channel = {}
Vimdeck.currentName = {}
Vimdeck.__index = {} -- Holds window handles, buffers, and current keybind channel.
Vimdeck.__projects = {} -- Holds project paths and channel associations
Vimdeck.channels = {} -- table of modal keybindings

local win_width = vim.api.nvim_win_get_width(0)
local win_height = vim.api.nvim_win_get_height(0) - 3
Vimdeck.channelGuideBuf = vim.api.nvim_create_buf(false, true)
Vimdeck.channelGuide = vim.api.nvim_open_win(Vimdeck.channelGuideBuf, false, {relative='win', anchor='NE', col=win_width, row=win_height, width=20, height=1, border='rounded', title='Vimdeck', title_pos='right'})

table.insert(Vimdeck.__index, {window = Vimdeck.channelGuide, buffer=Vimdeck.channelGuideBuf, channel = require('vimdeck.config.default')})
table.insert(Vimdeck.__projects, {{path = "~/vimdeck", channel="lua"}})

function Vimdeck.setup(opts)
    -- Setting the initial keybindings
    Vimdeck.channel = require('vimdeck.config.default')


    Vimdeck.opts = opts
    -- Loading default profile
    Vimdeck:switch(Vimdeck.channel)


    -- Creating Commands
    Vimdeck:createCmd()

	Vimdeck.currentName = {"default"}

    Vimdeck:DisplayChannelGuide()
    Vimdeck:UpdateChannelGuide(Vimdeck.currentName)
end

function Vimdeck:switch(config)
    for k, _ in ipairs(config) do
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
		for i, _ in ipairs(Vimdeck.opts) do
			if Vimdeck.opts[i] == sel then
				vim.cmd(":Vimdeck load " .. sel)
	    	    		vim.cmd("echo 'Vimdeck: " .. sel ..  " profile loaded'")
				Vimdeck:UpdateChannelGuide({sel})
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
		Vimdeck.currentChannelName = sel
		for i, _ in ipairs(Vimdeck.opts) do
			if Vimdeck.opts[i] == sel then
				vim.cmd(":Vimdeck lookup " .. sel)
			end
		end
	end
	end
	ShowMenu(Vimdeck.opts, cb)
end




function Vimdeck:DisplayChannelGuide()
	local buf = vim.api.nvim_win_get_buf(Vimdeck.channelGuide)

	vim.api.nvim_buf_set_lines(buf, 0, -1, true, {Vimdeck.__index.filetype})
end

function Vimdeck:UpdateChannelGuide(channelName)
	local buf = vim.api.nvim_win_get_buf(Vimdeck.channelGuide)
	vim.api.nvim_buf_set_lines(buf, 0, -1, true, channelName)
end



return Vimdeck





