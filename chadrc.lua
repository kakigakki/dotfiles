local M = {}

M.ui = {
  theme_toggle = { "dark_horizon", "everforest_light" },
  theme = "dark_horizon",
}

M.plugins = require "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
