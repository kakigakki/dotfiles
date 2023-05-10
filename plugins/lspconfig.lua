local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- local servers = { "html", "cssls", "vuels", "tsserver", "clangd" }
local servers = { "html", "cssls", "tsserver", "clangd", "volar", "eslit" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- fold option
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

-- lspconfig.volar.setup {
--   on_attach = function(client)
--     client.resolved_capabilities.document_formatting = false
--     client.resolved_capabilities.document_range_formatting = false
--   end,
-- }
lspconfig.eslint.setup {
  --- ...
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
}
