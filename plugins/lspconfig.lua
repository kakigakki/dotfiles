vim.diagnostic.config {
  virtual_text = false,
}

local on_attach = require("plugins.configs.lspconfig").on_attach
local my_on_attach = function(client, bufnr)
  -- show diagonostic float window when hover
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = "always",
        prefix = " ",
        scope = "cursor",
      }
      vim.diagnostic.open_float(nil, opts)
    end,
  })
end

local capabilities = require("plugins.configs.lspconfig").capabilities
capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

-- fold option
capabilities.textDocument.foldingRange = {
  dynamicRegistration = true,
  lineFoldingOnly = true,
}

local lspconfig = require "lspconfig"

-- for vue2
-- local servers = { "html", "cssls", "vuels", "tsserver", "clangd" }

-- for vue3
local servers = { "cssls", "clangd", "volar" }

lspconfig.volar.setup {
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = function(client, bufnr)
      on_attach(client, bufnr)
      my_on_attach(client, bufnr)
    end,
    capabilities = capabilities,
  }
end

lspconfig.eslint.setup {
  --- ...
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
}
