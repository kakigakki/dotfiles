local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  -- Lua
  b.formatting.stylua,

  -- frontend
  b.code_actions.eslint_d,
  b.diagnostics.eslint_d,
  b.formatting.eslint_d,
  -- b.code_actions.eslint,
  -- b.diagnostics.eslint.with {
  --   debounce = 500,
  --   diagnostics_format = "[#{c}] #{m} (#{s})",
  --   diagnostic_config = {
  --     -- see :help vim.diagnostic.config()
  --     underline = true,
  --     virtual_text = false,
  --     signs = false,
  --     update_in_insert = false,
  --     severity_sort = false,
  --   },
  -- },
  -- b.formatting.eslint,
}

-- sync format
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
  if client.supports_method "textDocument/formatting" then
    vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
        vim.lsp.buf.format {
          bufnr = bufnr,
        }
      end,
    })
  end
end

null_ls.setup {
  debug = false,
  sources = sources,
  on_attach = on_attach,
}

-- async formart
-- local async_formatting = function(bufnr)
--   bufnr = bufnr or vim.api.nvim_get_current_buf()
--
--   vim.lsp.buf_request(bufnr, "textDocument/formatting", vim.lsp.util.make_formatting_params {}, function(err, res, ctx)
--     if err then
--       local err_msg = type(err) == "string" and err or err.message
--       -- you can modify the log message / level (or ignore it completely)
--       vim.notify("formatting: " .. err_msg, vim.log.levels.WARN)
--       return
--     end
--
--     -- don't apply results if buffer is unloaded or has been modified
--     if not vim.api.nvim_buf_is_loaded(bufnr) or vim.api.nvim_buf_get_option(bufnr, "modified") then
--       return
--     end
--
--     if res then
--       local client = vim.lsp.get_client_by_id(ctx.client_id)
--       vim.lsp.util.apply_text_edits(res, bufnr, client and client.offset_encoding or "utf-16")
--       vim.api.nvim_buf_call(bufnr, function()
--         vim.cmd "silent noautocmd update"
--       end)
--     end
--   end)
-- end
--
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
--
-- null_ls.setup {
--   -- add your sources / config options here
--   sources = sources,
--   debug = false,
--   on_attach = function(client, bufnr)
--     if client.supports_method "textDocument/formatting" then
--       vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
--       vim.api.nvim_create_autocmd("BufWritePost", {
--         group = augroup,
--         buffer = bufnr,
--         callback = function()
--           async_formatting(bufnr)
--         end,
--       })
--     end
--   end,
-- }
