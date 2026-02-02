local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Detect system theme
function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return "Kanagawa (Gogh)" -- Dark theme
  else
    return "Kanagawa Lotus (Gogh)" -- Light theme
  end
end

-- Suscribe to event that notifies system changes
wezterm.on("window-config-reloaded", function(window, pane)
  local overrides = window:get_config_overrides() or {}
  local appearance = window:get_appearance()
  local scheme = scheme_for_appearance(appearance)

  if overrides.color_scheme ~= scheme then
    overrides.color_scheme = scheme
    window:set_config_overrides(overrides)
  end
end)

-- Initial configuration
config.color_scheme = scheme_for_appearance(wezterm.gui.get_appearance())
config.font_size = 12
config.font = wezterm.font("Iosevka Nerd Font")

return config
