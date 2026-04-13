local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Font
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 12.0

-- Theme
config.color_scheme = "Kanagawa Dragon (Gogh)"
config.window_background_opacity = 1.0
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = 4,
	right = 4,
	top = 4,
	bottom = 4,
}

-- Shell
config.default_prog = { "pwsh.exe" }

return config
