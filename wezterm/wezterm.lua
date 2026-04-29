local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Font
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 12.0

-- Theme
config.color_scheme = "Kanagawa Dragon (Gogh)"
config.window_background_opacity = 1.0
config.enable_tab_bar = false
config.window_padding = {
	left = 12,
	right = 12,
	top = 8,
	bottom = 8,
}

-- Shell
config.default_prog = { "pwsh.exe" }

return config
