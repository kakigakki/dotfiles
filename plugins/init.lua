local overrides = require "custom.plugins.overrides"
vim.g.code_action_menu_show_details = false
vim.g.code_action_menu_window_border = "single"

return {

  -- ["goolord/alpha-nvim"] = { disable = false } -- enables dashboard

  -- Override plugin definition options
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },

  ["lewis6991/gitsigns.nvim"] = {
    override_options = {
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame
      numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
      current_line_blame_opts = {
        delay = 200,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>(<abbrev_sha>)",
    },
  },

  -- overrde plugin configs
  ["nvim-treesitter/nvim-treesitter"] = {
    run = ":TSUpdate", -- for nvim-ufo
    override_options = overrides.treesitter,
  },

  ["williamboman/mason.nvim"] = {
    override_options = overrides.mason,
  },

  ["kyazdani42/nvim-tree.lua"] = {
    override_options = overrides.nvimtree,
  },

  -- Install a plugin
  ["max397574/better-escape.nvim"] = {
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- code formatting, linting etc
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },

  ["tpope/vim-fugitive"] = {},

  ["goolord/alpha-nvim"] = {
    override_options = overrides.alpha,
    disable = false,
  },

  ["kdheepak/lazygit.nvim"] = {},

  ["folke/which-key.nvim"] = { disable = false },

  -- カーソルが当たった単語を光らせる
  ["RRethy/vim-illuminate"] = {},

  -- モードが行数の色でわかるようになる
  ["mvllow/modes.nvim"] = {
    tag = "v0.2.0",
    config = function()
      require("modes").setup()
    end,
    colors = {
      copy = "#f5c359",
      delete = "#c75c6a",
      insert = "#78ccc5",
      visual = "#9745be",
    },
    -- Set opacity for cursorline and number background
    line_opacity = 0.15,
    -- Enable cursor highlights
    set_cursor = true,
    -- Enable cursorline initially, and disable cursorline for inactive windows
    -- or ignored filetypes
    set_cursorline = true,
    -- Enable line number highlights to match cursorline
    set_number = true,
    -- Disable modes highlights in specified filetypes
    -- Please PR commonly ignored filetypes
    ignore_filetypes = { "NvimTree", "TelescopePrompt" },
  },

  -- word search tool
  ["ggandor/lightspeed.nvim"] = {},

  ["gbprod/substitute.nvim"] = {
    config = function()
      require("substitute").setup {}
    end,
  },

  ["RishabhRD/popfix"] = {},
  ["RishabhRD/nvim-lsputils"] = {},

  ["kevinhwang91/nvim-ufo"] = {
    requires = "kevinhwang91/promise-async",
    config = function()
      require("ufo").setup {
        provider_selector = function(bufnr, filetype)
          return { "treesitter", "indent" }
        end,
      }
      vim.keymap.set("n", "zR", require("ufo").openAllFolds)
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    end,
  },

  -- lsp gd preview
  ["rmagatti/goto-preview"] = {
    config = function()
      require("goto-preview").setup {
        resizing_mappings = true,
        width = vim.api.nvim_win_get_width(0) - 4,
        height = vim.api.nvim_win_get_height(0) - 4,
        default_mappings = true,
      }
    end,
  },

  -- like v-surround
  ["kylechui/nvim-surround"] = {
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  -- mark
  ["ThePrimeagen/harpoon"] = {
    config = function()
      require("harpoon").setup {
        menu = {
          width = vim.api.nvim_win_get_width(0) - 4,
        },
      }
    end,
  },
  ["chentoast/marks.nvim"] = {
    config = function()
      require("marks").setup {
        default_mappings = true,
        signs = true,
        mappings = {
          prev = "MM",
          next = "mm",
        },
      }
    end,
  },

  -- session
  ["Shatur/neovim-session-manager"] = {
    config = function()
      require("session_manager").setup {
        sessions_dir = require("plenary.path"):new(vim.fn.stdpath "data", "sessions"), -- The directory where the session files will be saved.
        path_replacer = "__", -- The character to which the path separator will be replaced for session files.
        colon_replacer = "++", -- The character to which the colon symbol will be replaced for session files.
        autoload_mode = require("session_manager.config").AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
        autosave_last_session = true, -- Automatically save last session on exit and on session switch.
        autosave_ignore_not_normal = true, -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
        autosave_ignore_dirs = {}, -- A list of directories where the session will not be autosaved.
        autosave_ignore_filetypes = { -- All buffers of these file types will be closed before the session is saved.
          "gitcommit",
        },
        autosave_ignore_buftypes = {}, -- All buffers of these bufer types will be closed before the session is saved.
        autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
        max_path_length = 80, -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
      }
    end,
  },

  -- -- git tool , mainly for hunk preview
  -- ["tanvirtin/vgit.nvim"] = {
  --   requires = {
  --     "nvim-lua/plenary.nvim",
  --   },
  --   after = "nvim-web-devicons",
  --   config = function()
  --     require("vgit").setup()
  --   end,
  -- },

  -- git tool, for copy file permalinks
  ["ruifm/gitlinker.nvim"] = {
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("gitlinker").setup()
    end,
  },

  -- git tool , mainly for file history
  ["sindrets/diffview.nvim"] = {
    requires = {
      "nvim-lua/plenary.nvim",
    },
  },

  ["windwp/nvim-ts-autotag"] = {
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  ["terryma/vim-multiple-cursors"] = {},

  -- translator
  ["potamides/pantran.nvim"] = {
    config = function()
      require("pantran").setup {
        -- Default engine to use for translation. To list valid engine names run
        -- `:lua =vim.tbl_keys(require("pantran.engines"))`.
        default_engine = "argos",
        -- Configuration for individual engines goes here.
        engines = {
          argos = {
            -- Default languages can be defined on a per engine basis. In this case
            -- `:lua require("pantran.async").run(function()
            -- vim.pretty_print(require("pantran.engines").yandex:languages()) end)`
            -- can be used to list available language identifiers.
            default_source = "jp",
            default_target = "en",
          },
        },
      }
    end,
  },
  -- highlight N search
  ["kevinhwang91/nvim-hlslens"] = {
    config = function()
      require("hlslens").setup {
        calm_down = true,
        nearest_only = true,
        nearest_float_when = "always",
      }

      local kopts = { noremap = true, silent = true }

      vim.api.nvim_set_keymap(
        "n",
        "n",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap(
        "n",
        "N",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)

      vim.api.nvim_set_keymap("n", "<Leader>l", "<Cmd>noh<CR>", kopts) -- run `:nohlsearch` and export results to quickfix
      -- if Neovim is 0.8.0 before, remap yourself.
      vim.keymap.set({ "n", "x" }, "<Leader>L", function()
        vim.schedule(function()
          if require("hlslens").exportLastSearchToQuickfix() then
            vim.cmd "cw"
          end
        end)
        return ":noh<CR>"
      end, { expr = true })
    end,
  },

  -- popup code action
  ["weilbith/nvim-code-action-menu"] = {
    cmd = "CodeActionMenu",
  },
}
