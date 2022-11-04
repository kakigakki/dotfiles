local M = {}

M.general = {
  n = {
    -- go to  beginning and end
    ["<C-e>"] = { "<ESC>^i", "beginning of line" },
    ["<C-b>"] = { "<End>a", "end of line" },

    [";"] = { ":", "command mode", opts = { nowait = true } },

    ["J"] = { "10j", "move faster" },
    ["K"] = { "10k", "move faster" },
    ["Y"] = { "yy", "copy whole line" },
    ["L"] = { "$", "move to end" },
    ["H"] = { "^", "move to head" },

    -- hopWord
    ["<leader>h"] = {
      function()
        require("hop").hint_words()
      end,
      "HopWord",
    },
    ["<leader>hh"] = {
      function()
        require("hop").hint_words()
      end,
      "HopWord",
    },
    ["<leader>h1"] = {
      function()
        require("hop").hint_char1()
      end,
      "HopChar1",
    },
    ["<leader>h2"] = {
      function()
        require("hop").hint_char2()
      end,
      "HopChar2",
    },

    -- 置换工具
    ["<leader>s"] = {
      "<cmd>lua requoperatorire('substitute.range').operator()<cr>",
      "substitute.range",
    },

    ["<leader>ss"] = {
      "<cmd>lua require('substitute.range').operator()<cr>",
      "substitute.range",
    },

    -- mark Actions
    ["<leader>ma"] = {
      function()
        require("harpoon.mark").add_file()
      end,
      "add mark file",
    },

    ["<leader>mm"] = {
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      "toggle quick mark",
    },

    ["<leader>mn"] = {
      function()
        require("harpoon.ui").nav_next()
      end,
      "next marked file",
    },

    ["<leader>mp"] = {
      function()
        require("harpoon.ui").nav_prev()
      end,
      "prev marked file",
    },
  },

  i = {
    -- go to  beginning and end
    ["<C-e>"] = { "<ESC>^i", "beginning of line" },
    ["<C-b>"] = { "<End>", "end of line" },
    ["<C-s>"] = { "<ESC><cmd> w <CR>", "save file" },

    ["jj"] = { "<ESC>" },
    ["JJ"] = { "<ESC>" },
  },

  v = {
    [";"] = { ":", "command mode", opts = { nowait = true } },

    -- save
    ["<C-s>"] = { "<ESC><cmd> w <CR>", "save file" },

    ["J"] = { "10j", "move faster" },
    ["K"] = { "10k", "move faster" },
    ["L"] = { "$h", "select until end" },
    ["H"] = { "^", "select until head" },

    ["<leader>s"] = {
      function()
        require("substitute.range").operator()
      end,
      "substitute.range",
    },
  },
}

M.packer = {
  n = {
    ["<leader>ps"] = { "<cmd>PackerSync<cr>", "Packer Sync" },
    ["<leader>pS"] = { "<cmd>PackerStatus<cr>", "Packer Status" },
    ["<leader>pu"] = { "<cmd>PackerUpdate<cr>", "Packer Update" },
  },
}

M.git = {
  n = {
    ["<leader>lg"] = { "<cmd>LazyGit<CR>", "open lazygit" },
    ["<leader>gc"] = { "<cmd> Telescope git_commits<CR>", "git commits" },
    ["<leader>gs"] = { "<cmd> Telescope git_status<CR>", "git status" },
  },
}

M.nvterm = {
  plugin = true,

  t = {
    -- toggle in terminal mode
    ["qq"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "toggle floating term",
    },
  },

  n = {
    -- toggle in normal mode
    ["<leader>tm"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "toggle floating term",
    },
  },
}

M.lspconfig = {
  plugin = true,

  n = {
    ["gh"] = {
      function()
        vim.lsp.buf.hover()
      end,
      "lsp hover",
    },
  },
}

M.nvimtree = {
  plugin = true,

  n = {
    -- toggle
    ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "toggle nvimtree" },

    -- focus
    ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "focus nvimtree" },

    ["<leader>r+"] = { "<cmd> NvimTreeResize +20<CR>", "resize nvimtree" },

    ["<leader>r-"] = { "<cmd> NvimTreeResize -20<CR>", "resize nvimtree" },

    ["<leader>rf"] = { "<cmd> NvimTreeFindFile <CR>", "find current file postion" },
  },
}

M.gitsigns = {
  plugin = true,

  n = {
    -- Actions
    ["<leader>pp"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },
  },
}

return M
