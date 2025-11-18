-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()


-- Colorscheme
config.color_scheme = 'Srcery (Gogh)'
config.font_size = 20
config.font = wezterm.font_with_fallback {
  {
    family = 'FantasqueSansM Nerd Font Mono',
    weight = 'Medium',
    harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },
  },
  { family = 'Terminus', weight = 'Bold' },
  'Noto Color Emoji',
}



-- local mux = wezterm.mux
-- 
-- wezterm.on('gui-startup', function(cmd)
--   -- allow `wezterm start -- something` to affect what we spawn
--   -- in our initial window
--   local args = {}
--   if cmd then
--     args = cmd.args
--   end
-- 
--   -- Set a workspace for coding on a current project
--   -- Top pane is for the editor, bottom pane is for the build tool
--   local tab, top_pane, top_window = mux.spawn_window {
--     workspace = 'top',
--     args = args,
--   }
--   top_window:set_title 'top_popover'
--   top_pane:send_text 'sleep 2\naerospace-marks mark top\n'
-- 
--   -- A workspace for interacting with a local machine that
--   -- runs some docker containers for home automation
--   local tab, bottom_pane, bottom_window = mux.spawn_window {
--     workspace = 'bottom',
--     args = args,
--   }
--   bottom_pane:send_text 'sleep 2\naerospace-marks mark bottom\n'
--   bottom_window:set_title 'bottom_popover'
-- 
--   -- We want to startup in the coding workspace
--   mux.set_active_workspace 'top'
-- end)


-- config.unix_domains = {
--   {name = 'default'},
--   {name = 'top'},
--   {name = 'bottom'}
-- }
-- config.default_gui_startup_args = { 'connect', 'default' }

-- Finally, return the configuration to wezterm:
return config

