local M = {}

M.general = {
  n = {
    -- go to  beginning and end
    ["<C-e>"] = { "<ESC>^i", "beginning of line" },
    ["<C-b>"] = { "<End>a", "end of line" },

    -- switch between windows
    ["<leader>v"] = { "<C-w>v", "new vetical window" },
    ["<leader>h"] = { "<C-w>s", "new horizontal window" },
    ["<leader>q"] = { "<C-w>q", "quit window" },
    ["<C-h>"] = { "<C-w>h", "window left" },
    ["<C-l>"] = { "<C-w>l", "window right" },
    ["<C-j>"] = { "<C-w>j", "window down" },
    ["<C-k>"] = { "<C-w>k", "window up" },

    [";"] = { ":", "command mode", opts = { nowait = true } },
    ["_"] = { "/", "search mode", opts = { nowait = true } },

    ["J"] = { "10j", "move faster" },
    ["K"] = { "10k", "move faster" },
    ["Y"] = { "yy", "copy whole line" },
    ["L"] = { "$", "move to end" },
    ["H"] = { "^", "move to head" },

    ["<leader>j"] = { "d0i<BS>jj", "move to prev line" },
    ["<leader>bb"] = { "<cmd>%bd<cr>", "close all buffers" },
    ["<leader>se"] = { "g*", "g*" },

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

    -- VGit preview
    -- ["<leader>fg"] = { "<cmd>VGit buffer_history_preview<cr>", "file history preview" },
    -- ["<leader>pp"] = { "<cmd>VGit buffer_hunk_preview<cr>", "hunk preview" },
    -- ["[c"] = { "<cmd>VGit hunk_up<cr>", "prev VGit hunk" },
    -- ["]c"] = { "<cmd>VGit hunk_down<cr>", "next VGit hunk" },

    -- diffview
    ["<leader>da"] = { "<cmd>DiffviewFileHistory<cr>", "open branch commits history" },
    ["<leader>df"] = { "<cmd>DiffviewFileHistory %<cr>", "open current file history" },
    ["<leader>do"] = { "<cmd>DiffviewOpen<cr>", "open diffview" },
    ["<leader>dx"] = { "<cmd>DiffviewClose<cr>", "close diffview" },

    -- goto preview
    ["<leader>cv"] = { "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", "definition preview" },

    ["<leader>ca"] = { "<cmd>CodeActionMenu<cr>", "show codeActionMenu popup" },

    ["<leader>gu"] = { "<S-~>", "toggle case" },

    -- neotree focus
    ["<leader>e"] = { "<cmd> Neotree focus <CR>", "neoTree focus" },

    -- replacement ui
    ["<leader>re"] = { "<cmd> MurenToggle <CR>", "toggle replacement ui" },

    -- other.nvim
    ["<leader>ll"] = { "<cmd> Other <CR>", "Jump to related file" },
  },

  i = {
    -- go to  beginning and end
    ["<C-b>"] = { "<ESC>^i", "beginning of line" },
    ["<C-e>"] = { "<End>", "end of line" },
    ["<C-s>"] = { "<ESC><cmd> w <CR>", "save file" },

    ["jj"] = { "<ESC>" },
    ["JJ"] = { "<ESC>" },
  },

  v = {
    [";"] = { ":", "command mode", opts = { nowait = true } },
    ["_"] = { "/", "search mode", opts = { nowait = true } },

    -- save
    ["<C-s>"] = { "<ESC><cmd> w <CR>", "save file" },

    ["J"] = { "10j", "move faster" },
    ["K"] = { "10k", "move faster" },
    ["L"] = { "$h", "select until end" },
    ["H"] = { "^", "select until head" },

    -- 置换工具
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
    ["[d"] = {
      function()
        vim.diagnostic.goto_prev()
      end,
      "goto prev",
    },

    ["]d"] = {
      function()
        vim.diagnostic.goto_next()
      end,
      "goto_next",
    },

    ["<leader>dl"] = {
      function()
        vim.diagnostic.setloclist()
      end,
      "diagnostic setloclist",
    },

    ["<leader>fm"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "lsp formatting",
    },
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
    ["<leader>rh"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },
    ["]]"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },

    ["[["] = {
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to prev hunk",
      opts = { expr = true },
    },
  },
}

M.comment = {
  plugin = true,

  -- toggle comment in both modes
  n = {
    ["<leader>cc"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      "toggle comment",
    },
  },

  v = {
    ["<leader>cc"] = {
      "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      "toggle comment",
    },
  },
}

M.telescope = {
  n = {
    ["<leader>a"] = { "<cmd> Telescope yank_history <CR>", "yank_history" },
  },
  v = {
    ["<leader>a"] = { "<cmd> Telescope yank_history <CR>", "yank_history" },
  },
}

return M
