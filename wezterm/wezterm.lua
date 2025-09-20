-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

term = "xterm-256color"

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28
config.adjust_window_size_when_changing_font_size = false
config.font_size = 14


-- FIGURE OUT COLOR SCHEMES
--local color_schemes = {
--['Adventure Time'] = 'AdventureTime',
--['Default'] = wezterm.color.get_default_colors(),
--}
--config.color_scheme = 'Default'



config.window_background_opacity = 0.9

config.show_tabs_in_tab_bar = true
config.tab_bar_at_bottom = true
config.tab_max_width = 20
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = true
config.show_tab_index_in_tab_bar = true
config.tab_and_split_indices_are_zero_based = false

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
}, {
  key = 'X',
  mods = 'CTRL|SHIFT',
  action = wezterm.action.ActivateCopyMode
}

}
-- Finally, return the configuration to wezterm:
return config
