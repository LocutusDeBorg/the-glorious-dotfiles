local filesystem = require('gears.filesystem')

local config_dir = filesystem.get_configuration_dir()
local bin_dir = config_dir .. 'binaries/'

local default_config =  {

	-- The default applications that we will use in keybindings and widgets
	default = {
		terminal 										= 'kitty',																-- Terminal Emulator
		text_editor 									= 'subl3',                      	            						-- GUI Text Editor
		web_browser 									= 'firefox',                        	        						-- Web browser
		file_manager 									= 'dolphin', 
		multimedia										= 'vlc',
		graphics										= 'gimp-2.10',
		sandbox											= 'virtualbox',
		games											= 'supertuxkart',
		development										= '',                           	  	 	 					-- GUI File manager
		social											= 'discord',
		network_manager 								= 'nm-connection-editor',												-- Network manager
		bluetooth_manager 								= 'blueman-manager',													-- Bluetooth manager
		power_manager 									= 'xfce4-power-manager',												-- Power manager
		package_manager 								= 'pamac-manager',														-- GUI Package manager
		lock 											= 'awesome-client "awesome.emit_signal(\'module::lockscreen_show\')"',	-- Lockscreen
		quake 											= 'kitty --name QuakeTerminal',       			    					-- Quake-like Terminal

		rofiglobal										= 'rofi -dpi ' .. screen.primary.dpi .. 
															' -show "Global Search" -modi "Global Search":' .. config_dir .. 
															'/configuration/rofi/sidebar/rofi-spotlight.sh' .. 
															' -theme ' .. config_dir ..
															'/configuration/rofi/sidebar/rofi.rasi',			 				-- Rofi Web Search
		

		rofiappmenu 									= 'rofi -dpi ' .. screen.primary.dpi ..
															' -show drun -theme ' .. config_dir ..
															'/configuration/rofi/appmenu/rofi.rasi',				  			-- Application Menu
		-- Search button mouse events can be either a string (for spawn)
		-- or a no argument Lua function 
		-- See the apps-mine.lua.example for a more functional example
		searchbuttonup									= 'amixer -D pulse sset Master 5%+',
		searchbuttondown								= 'amixer -D pulse sset Master 5%-',
		searchbuttonrclick								= ''

		-- You can add more default applications here
	},
	
	-- List of apps to start once on start-up
	-- auto-start.lua module will start these

	run_on_start_up = {

		'picom -b --experimental-backends --dbus --config ' .. 
		config_dir .. '/configuration/picom.conf',   																			-- Compositor

		'blueman-applet',                                           	      								                    -- Bluetooth tray icon
		'mpd',                                                          	          										    -- Music Server
		'xfce4-power-manager',                                              	                    					    	-- Power manager
		'/usr/lib/polkit-kde-authentication-agent-1 &' .. 
		' eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)', 	          									-- Credential manager
		
		'xrdb $HOME/.Xresources',                                                   	                						-- Load X Colors
		'nm-applet',                                                                    	            						-- NetworkManager Applet
		'pulseeffects --gapplication-service',                                              	        						-- Sound Equalizer
		[[
		xidlehook --not-when-fullscreen --not-when-audio --timer 600 \
		"awesome-client 'awesome.emit_signal(\"module::lockscreen_show\")'" ""
		]]																														-- Auto lock timer 

		-- You can add more start-up applications here
	},

	-- List of binaries/shell scripts that will execute a certain task

	bins = {
		full_screenshot = bin_dir .. 'snap full',              					                    							-- Full Screenshot
		area_screenshot = bin_dir .. 'snap area',			                                        							-- Area Selected Screenshot
		update_profile  = bin_dir .. 'profile-image'																			-- Update profile picture
	},

	-- Default list of top panel widgets (can be removed/reordered in apps-mine)
	top_panel_widgets = {
		"widget.package-updater",
		"widget.screen-recorder",	
		"widget.music",
		"widget.bluetooth",
		"widget.network",
		"widget.battery"
	}
}

if filesystem.file_readable(config_dir .. 'configuration/apps-mine.lua') then
	local mine = require("configuration.apps-mine")
	local gears = require('gears')
	gears.table.crush(default_config.default, mine.default or {})
	if mine.run_on_start_up then default_config.run_on_start_up = mine.run_on_start_up end
	gears.table.crush(default_config.bins, mine.bins or {})
	if mine.top_panel_widgets then default_config.top_panel_widgets = mine.top_panel_widgets end
end  

return default_config