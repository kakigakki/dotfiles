local M = {}

-- alpha button
local function button(sc, txt, keybind)
  local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

  local opts = {
    position = "center",
    text = txt,
    shortcut = sc,
    cursor = 5,
    width = 36,
    align_shortcut = "right",
    hl = "AlphaButtons",
  }

  if keybind then
    opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
  end

  return {
    type = "button",
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true) or ""
      vim.api.nvim_feedkeys(key, "normal", false)
    end,
    opts = opts,
  }
end

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "typescript",
    "c",
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "vue",
    "vetur-vls",
    "eslint_d",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

M.alpha = {
  header = {
    type = "text",
    val = {
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
    opts = {
      position = "center",
      hl = "AlphaHeader",
    },
  },
  buttons = {
    type = "group",
    val = {
      button("SPC f f", "🕹 Find File  ", ":Telescope find_files<CR>"),
      button("SPC f o", "📋 Recent File  ", ":Telescope oldfiles<CR>"),
      button("SPC f w", "🅰️  Find Word  ", ":Telescope live_grep<CR>"),
      button("SPC b m", "📎 Bookmarks  ", ":Telescope marks<CR>"),
      button("SPC t h", "💖 Themes  ", ":Telescope themes<CR>"),
      button("SPC e s", "🎚 Settings", ":e $MYVIMRC | :cd %:p:h <CR>"),
    },
    opts = {
      spacing = 1,
    },
  },
}

return M
