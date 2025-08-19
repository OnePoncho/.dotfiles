-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 14
config.adjust_window_size_when_changing_font_size = false


-- FIGURE OUT COLOR SCHEMES
--local color_schemes = {
--['Adventure Time'] = 'AdventureTime',
--['Default'] = wezterm.color.get_default_colors(),
--}
--config.color_scheme = 'Default'



config.window_background_opacity = 0.9

config.tab_bar_at_bottom = true

config.keys = {
  {
    key = 'LeftArrow',
    mods = 'SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  }, {
  key = 'RightArrow',
  mods = 'SHIFT',
  action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
}, {
  key = '+',
  mods = 'CMD',
  action = wezterm.action.IncreaseFontSize
},

}
-- Finally, return the configuration to wezterm:
return config
