vim.diagnostic.config {
  virtual_text = false,
  signs = true,
}

local on_attach = require("plugins.configs.lspconfig").on_attach
-- local my_on_attach = function(client, bufnr)
--   -- show diagonostic float window when hover
--   vim.api.nvim_create_autocmd("CursorHold", {
--     buffer = bufnr,
--     callback = function()
--       local opts = {
--         focusable = false,
--         close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
--         border = "rounded",
--         source = "always",
--         prefix = " ",
--         scope = "cursor",
--       }
--       vim.diagnostic.open_float(nil, opts)
--     end,
--   })
-- end

-- fold option
-- capabilities.textDocument.foldingRange = {
--   dynamicRegistration = true,
--   lineFoldingOnly = true,
-- }

local lspconfig = require "lspconfig"

-- for vue2
-- local servers = { "html", "cssls", "vuels", "tsserver" }

-- for vue3
local servers = { "cssls", "volar", "tsserver", "solargraph" }
-- local capabilities = require("plugins.configs.lspconfig").capabilities -- when use take over mode
-- capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true -- when use take over mode
-- lspconfig.volar.setup {
--   filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
-- } -- when use take over mode

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      -- my_on_attach(client, bufnr)
    end,
    -- capabilities = capabilities,
  }
end

-- eslint
lspconfig.eslint.setup {
  --- ...
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
}

--rubocop
lspconfig.rubocop.setup {
  on_attach = function(client, bufnr)
    vim.opt.signcolumn = "yes"
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "ruby",
      callback = function()
        vim.lsp.start {
          name = "rubocop",
          cmd = { "bundle", "exec", "rubocop", "--lsp" },
        }
      end,
    })
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.rb",
      callback = function()
        vim.lsp.buf.format()
      end,
    })
  end,
}
