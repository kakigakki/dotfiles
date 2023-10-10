local M = {}

M.ui = {
  theme_toggle = { "chadracula", "everforest_light" },
  theme = "chadracula", --kanagawa
  nvdash = {
    load_on_startup = true,

    header = {
      "          ▀████▀▄▄              ▄█ ",
      "            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ",
      "    ▄        █          ▀▀▀▀▄  ▄▀  ",
      "   ▄▀ ▀▄      ▀▄              ▀▄▀  ",
      "  ▄▀    █     █▀   ▄█▀▄      ▄█    ",
      "  ▀▄     ▀▄  █     ▀██▀     ██▄█   ",
      "   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ",
      "    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ",
      "   █   █  █      ▄▄           ▄▀   ",
    },

    buttons = {
      { "  Find File", "Spc f f", "Telescope find_files" },
      { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
      { "  Mappings", "Spc c h", "NvCheatsheet" },
      { "  Bookmarks", "Spc m a", "Telescope marks" },
      { "  Themes", "Spc t h", "Telescope themes" },
    },
  },
}

M.plugins = "custom.plugins"

-- check core.mappings for table structure
M.mappings = require "custom.mappings"

return M
