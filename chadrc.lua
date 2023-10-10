local M = {}

M.ui = {
  theme_toggle = { "chadracula", "everforest_light" },
  theme = "chadracula", --kanagawa
}

M.plugins = require "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
