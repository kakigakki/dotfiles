vim.g.code_action_menu_show_details = false
vim.g.code_action_menu_window_border = "single"
vim.g.camelcasemotion_key = ","

return {
  -- In order to modify the `lspconfig` configuration:
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  {
    "neovim/nvim-lspconfig",

    dependencies = {
      "jose-elias-alvarez/null-ls.nvim",
      config = function()
        require "custom.configs.null-ls"
      end,
    },

    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  -- ["goolord/alpha-nvim"] = { disable = false } -- enables dashboard

  { "folke/which-key.nvim", disable = false },

  -- overrde plugin configs
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame
      numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
      current_line_blame_opts = {
        delay = 200,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>(<abbrev_sha>)",
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate", -- for nvim-ufo
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "typescript",
        "vue",
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- lua stuff
        "lua-language-server",
        "stylua",

        -- web dev stuff
        "typescript-language-server",
        -- "vetur-vls",
        "eslint_d",
        "vue-language-server",
      },
    },
  },

  {
    "nvim-tree/nvim-tree.lua",
    disable = false,
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      -- Unless you are still migrating, remove the deprecated commands from v1.x
      vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]

      -- If you want icons for diagnostic errors, you'll need to define them somewhere:
      vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
      -- NOTE: this is changed from v1.x, which used the old style of highlight groups
      -- in the form "LspDiagnosticsSignWarning"

      require("neo-tree").setup {
        close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        sort_case_insensitive = false, -- used when sorting files and directories in the tree
        sort_function = nil, -- use a custom function for sorting files and directories in the tree
        -- sort_function = function (a,b)
        --       if a.type == b.type then
        --           return a.path > b.path
        --       else
        --           return a.type > b.type
        --       end
        --   end , -- this sorts files and directories descendantly
        default_component_configs = {
          container = {
            enable_character_fade = true,
          },
          indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "ﰊ",
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "*",
            highlight = "NeoTreeFileIcon",
          },
          modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },
          git_status = {
            symbols = {
              -- Change type
              added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
              deleted = "✖", -- this can only be used in the git_status source
              renamed = "", -- this can only be used in the git_status source
              -- Status type
              untracked = "",
              ignored = "",
              unstaged = "",
              staged = "",
              conflict = "",
            },
          },
        },
        window = {
          position = "left",
          width = 40,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            -- ["<space>"] = {
            --   "toggle_node",
            --   nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
            -- },
            ["<2-LeftMouse>"] = "open",
            ["<space>"] = "open",
            ["<esc>"] = "revert_preview",
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["l"] = "focus_preview",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            -- ["S"] = "split_with_window_picker",
            -- ["s"] = "vsplit_with_window_picker",
            ["t"] = "open_tabnew",
            -- ["<cr>"] = "open_drop",
            -- ["t"] = "open_tab_drop",
            ["w"] = "open_with_window_picker",
            --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            --["Z"] = "expand_all_nodes",
            ["a"] = {
              "add",
              -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = "none", -- "none", "relative", "absolute"
              },
            },
            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            -- ["c"] = {
            --  "copy",
            --  config = {
            --    show_path = "none" -- "none", "relative", "absolute"
            --  }
            --}
            ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
          },
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            hide_by_name = {
              --"node_modules"
            },
            hide_by_pattern = { -- uses glob style patterns
              --"*.meta",
              --"*/src/*/tsconfig.json",
            },
            always_show = { -- remains visible even if other settings would normally hide it
              --".gitignored",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
              --".DS_Store",
              --"thumbs.db"
            },
            never_show_by_pattern = { -- uses glob style patterns
              --".null-ls_*",
            },
          },
          follow_current_file = true, -- This will find and focus the file in the active buffer every
          -- time the current file is changed while the tree is open.
          group_empty_dirs = false, -- when true, empty folders will be grouped together
          hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
          -- in whatever position is specified in window.position
          -- "open_current",  -- netrw disabled, opening a directory opens within the
          -- window like netrw would, regardless of window.position
          -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
          use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
          -- instead of relying on nvim autocmd events.
          window = {
            mappings = {
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["H"] = "toggle_hidden",
              ["/"] = "fuzzy_finder",
              ["D"] = "fuzzy_finder_directory",
              ["f"] = "filter_on_submit",
              ["<c-x>"] = "clear_filter",
              ["[g"] = "prev_git_modified",
              ["]g"] = "next_git_modified",
            },
          },
        },
        buffers = {
          follow_current_file = true, -- This will find and focus the file in the active buffer every
          -- time the current file is changed while the tree is open.
          group_empty_dirs = true, -- when true, empty folders will be grouped together
          show_unloaded = true,
          window = {
            mappings = {
              ["bd"] = "buffer_delete",
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
            },
          },
        },
        git_status = {
          window = {
            position = "float",
            mappings = {
              ["A"] = "git_add_all",
              ["gu"] = "git_unstage_file",
              ["ga"] = "git_add_file",
              ["gr"] = "git_revert_file",
              ["gc"] = "git_commit",
              ["gp"] = "git_push",
              ["gg"] = "git_commit_and_push",
            },
          },
        },
      }

      vim.cmd [[nnoremap \ :Neotree reveal<cr>]]
    end,
  },

  -- Install a plugin
  "lukas-reineke/lsp-format.nvim",

  -- code formatting, linting etc
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "tpope/vim-fugitive",
    lazy = false,
  },

  {
    "kdheepak/lazygit.nvim",
    lazy = false,
  },

  -- カーソルが当たった単語を光らせる
  {
    "RRethy/vim-illuminate",
    lazy = false,
  },

  -- モードが行数の色でわかるようになる
  {
    "mvllow/modes.nvim",
    lazy = false,
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
  {
    "ggandor/lightspeed.nvim",
    lazy = false,
  },

  -- <leader>s
  {
    "gbprod/substitute.nvim",
    lazy = false,
    config = function()
      require("substitute").setup {}
    end,
  },

  {
    "kevinhwang91/nvim-ufo",
    lazy = false,
    dependencies = { "kevinhwang91/promise-async" },
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

  {
    "RishabhRD/popfix",
    lazy = false,
  },

  -- fold plugin
  -- za toggle
  -- zR open all fold
  {
    "RishabhRD/nvim-lsputils",
    lazy = false,
  },

  -- lsp gd preview
  {
    "rmagatti/goto-preview",
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
  -- S-s + object
  {
    "kylechui/nvim-surround",
    lazy = false,
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  -- mark
  -- <leader>ma   add mark
  -- <leader>mm   open mark list
  {
    "ThePrimeagen/harpoon",
    config = function()
      require("harpoon").setup {
        menu = {
          width = vim.api.nvim_win_get_width(0) - 4,
        },
      }
    end,
  },

  -- m;  toggle mark
  -- mm  jump to next mark
  {
    "chentoast/marks.nvim",
    lazy = false,
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
  {
    "Shatur/neovim-session-manager",
    lazy = false,
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

  -- git tool, for copy file permalinks
  {
    "ruifm/gitlinker.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("gitlinker").setup()
    end,
  },

  -- git tool , mainly for file history
  {
    "sindrets/diffview.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("diffview").setup {
        file_panel = {
          listing_style = "tree", -- One of 'list' or 'tree'
          win_config = { -- See ':h diffview-config-win_config'
            position = "left",
            width = 60,
          },
        },
      }
    end,
  },

  {
    "windwp/nvim-ts-autotag",
    lazy = false,
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- ctrl + n
  {
    "terryma/vim-multiple-cursors",
    lazy = false,
  },

  -- highlight N search
  {
    "kevinhwang91/nvim-hlslens",
    lazy = false,
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
      vim.api.nvim_set_keymap("n", "*", [[*<Cmd>('hlslens').start()<CR>]], kopts)
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
  {
    "weilbith/nvim-code-action-menu",
    lazy = false,
    cmd = "CodeActionMenu",
  },
  -- use key "-" edit directory or file like edit text
  {
    "elihunter173/dirbuf.nvim",
    lazy = false,
  },

  -- when open history
  -- ["<c-p>"] = mapping.put("p"),
  -- ["<c-k>"] = mapping.put("P"),
  -- ["<c-x>"] = mapping.delete(),
  --　copy more paste more
  -- ["gbprod/yanky.nvim"] = {
  --   config = function()
  --     require("yanky").setup {
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     }
  --     vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
  --     vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
  --     vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
  --     vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
  --   end,
  -- },

  -- align plugin use ga + textObject
  {
    "junegunn/vim-easy-align",
    lazy = false,
    config = function()
      vim.keymap.set({ "n", "x" }, "ga", "<Plug>(EasyAlign)")
    end,
  },

  {
    "NvChad/nvterm",
    config = function()
      require("nvterm").setup {
        terminals = {
          shell = vim.o.shell,
          list = {},
          type_opts = {
            float = {
              relative = "editor",
              row = 0.3,
              col = 0.25,
              width = 0.9,
              height = 0.7,
              border = "double",
            },
            horizontal = { location = "rightbelow", split_ratio = 0.3 },
            vertical = { location = "rightbelow", split_ratio = 0.5 },
          },
        },
        behavior = {
          autoclose_on_quit = {
            enabled = false,
            confirm = true,
          },
          close_on_exit = true,
          auto_insert = true,
        },
      }
    end,
  },

  {
    "Exafunction/codeium.vim",
    lazy = false,
    config = function()
      vim.keymap.set("i", "kk", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true })
    end,
  },

  -- replace plugin :S /xx/xx
  -- ["chrisgrieser/nvim-alt-substitute"] = {
  --   config = function()
  --     require("alt-substitute").setup {}
  --   end,
  -- },

  -- <leader>re
  {
    "AckslD/muren.nvim",
    lazy = false,
    config = function()
      require("muren").setup {
        {
          -- general
          create_commands = true,
          filetype_in_preview = true,
          -- default togglable options
          two_step = false,
          all_on_line = true,
          preview = true,
          -- keymaps
          keys = {
            close = "q",
            toggle_side = "<Tab>",
            toggle_options_focus = "<C-s>",
            toggle_option_under_cursor = "<CR>",
            scroll_preview_up = "<Up>",
            scroll_preview_down = "<Down>",
            do_replace = "<CR>",
          },
          -- ui sizes
          patterns_width = 50,
          patterns_height = 50,
          options_width = 15,
          preview_height = 50,
          -- options order in ui
          order = {
            "buffer",
            "two_step",
            "all_on_line",
            "preview",
          },
          -- highlights used for options ui
          hl = {
            options = {
              on = "@string",
              off = "@variable.builtin",
            },
          },
        },
      }
    end,
  },

  -- Uixx.vue和xx.vue可以互相跳转
  {
    "rgroli/other.nvim",
    lazy = false,
    config = function()
      require("other-nvim").setup {
        mappings = {
          -- custom mapping
          {
            pattern = "/main/(.*)/containers/(.*).vue$",
            target = "/main/%1/components/Ui%2.vue",
            context = "container",
          },
          {
            pattern = "/main/(.*)/containers/(.*)/(.*).vue$",
            target = "/main/%1/components/%2/Ui%3.vue",
            context = "container",
          },
          {
            pattern = "/main/(.*)/containers/(.*)/(.*).vue$",
            target = "/main/%1/components/Ui%2/Ui%3.vue",
            context = "container",
          },
          {
            pattern = "/main/(.*)/containers/.*/(.*).vue$",
            target = "/main/%1/components/Ui%2.vue",
            context = "container",
          },
          {
            pattern = "/main/(.*)/containers/(.*).vue$",
            target = "/main/%1/components/%2/Ui%2.vue",
            context = "container",
          },
          {
            pattern = "/main/(.*)/containers/(.*).vue$",
            target = "/main/%1/components/Ui%2/Ui%2.vue",
            context = "container",
          },
          {
            pattern = "/main/(.*)/components/Ui(.*).vue$",
            target = "/main/%1/containers/%2.vue",
            context = "component",
          },
          {
            pattern = "/main/(.*)/components/(.*)/Ui(.*).vue$",
            target = "/main/%1/containers/%2/%3.vue",
            context = "component",
          },
          {
            pattern = "/main/(.*)/components/.*/Ui(.*).vue$",
            target = "/main/%1/containers/%2.vue",
            context = "component",
          },
          {
            pattern = "/main/(.*)/components/Ui(.*)/Ui(.*).vue$",
            target = "/main/%1/containers/%2.vue",
            context = "component",
          },
          {
            pattern = "/main/(.*)/components/Ui.*/Ui(.*).vue$",
            target = "/main/%1/containers/%2/%2.vue",
            context = "component",
          },
          {
            pattern = "/main/(.*)/components/Ui(.*).vue$",
            target = "/main/%1/containers/%2/%2.vue",
            context = "component",
          },
          {
            pattern = "/main/(.*)/stores/.*/(.*)Store.ts$",
            target = "/main/%1/modules/use%2Module.ts",
            context = "stores",
          },
          {
            pattern = "/main/(.*)/stores/.*/(.*)Store.ts$",
            target = "/main/%1/modules/%2Module/use%2Module.ts",
            context = "stores",
          },
          {
            pattern = "/main/(.*)/modules/use(.*)Module.ts$",
            target = "/main/%1/stores/%2Store/%2Store.ts",
            context = "modules",
          },
          {
            pattern = "/main/(.*)/modules/(.*)Module/use(.*)Module.ts$",
            target = "/main/%1/stores/%2Store/%2Store.ts",
            context = "modules",
          },
        },
        style = {
          -- How the plugin paints its window borders
          -- Allowed values are none, single, double, rounded, solid and shadow
          border = "solid",

          -- Column seperator for the window
          seperator = "|",

          -- width of the window in percent. e.g. 0.5 is 50%, 1.0 is 100%
          width = 0.7,

          -- min height in rows.
          -- when more columns are needed this value is extended automatically
          minHeight = 2,
        },
        showMissingFiles = false,
      }
    end,
  },
}
