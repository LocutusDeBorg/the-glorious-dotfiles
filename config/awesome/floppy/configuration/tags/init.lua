local awful = require('awful')
local gears = require('gears')
local beautiful = require('beautiful')

local icons = require('theme.icons')
local apps = require('configuration.apps')

local tags = {
	{
		icon = icons.terminal,
		type = 'terminal',
		default_app = apps.default.terminal,
		screen = 1
	},
	{
		icon = icons.web_browser,
		type = 'chrome',
		default_app = apps.default.web_browser,
		screen = 1
	},
	{
		icon = icons.text_editor,
		type = 'code',
		default_app = apps.default.text_editor,
		screen = 1
	},
	{
		icon = icons.file_manager,
		type = 'files',
		default_app = apps.default.file_manager,
		screen = 1
	},
	{
		icon = icons.multimedia,
		type = 'music',
		default_app = apps.default.multimedia,
		screen = 1
	},
	{
		icon = icons.games,
		type = 'game',
		default_app = apps.default.games,
		screen = 1
	},
	{
		icon = icons.graphics,
		type = 'art',
		default_app = apps.default.graphics,
		screen = 1
	},
	{
		icon = icons.sandbox,
		type = 'virtualbox',
		default_app = apps.default.sandbox,
		screen = 1
	},
	{
		icon = icons.development,
		type = 'any',
		default_app = apps.default.development,
		screen = 1
	}
	-- {
	--   icon = icons.social,
	--   type = 'social',
	--   default_app = 'discord',
	--   screen = 1
	-- }
}


tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
		awful.layout.suit.spiral.dwindle,
		awful.layout.suit.tile,
		awful.layout.suit.max
    })
end)


screen.connect_signal("request::desktop_decoration", function(s)
	for i, tag in pairs(tags) do
		awful.tag.add(
			tag.type,
			{
				icon = tag.icon,
				icon_only = true,
				layout = awful.layout.suit.spiral.dwindle,
				gap_single_client = false,
				gap = beautiful.useless_gap,
				screen = s,
				default_app = tag.default_app,
				selected = i == 1
			}
		)
	end
end)


tag.connect_signal(
	'property::layout',
	function(t)
		local currentLayout = awful.tag.getproperty(t, 'layout')
		if (currentLayout == awful.layout.suit.max) then
			t.gap = 0
		else
			t.gap = beautiful.useless_gap
		end
	end
)
