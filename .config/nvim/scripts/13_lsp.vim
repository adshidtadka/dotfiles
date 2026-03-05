if !exists('g:env')
  finish
endif

lua << EOF
local ok, lspconfig = pcall(require, "lspconfig")
if not ok then
  return
end

local on_attach = function(_, bufnr)
  local map = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
  end

  map("n", "gd", vim.lsp.buf.definition)
  map("n", "gr", vim.lsp.buf.references)
  map("n", "K", vim.lsp.buf.hover)
  map("n", "<leader>rn", vim.lsp.buf.rename)
  map("n", "<leader>ca", vim.lsp.buf.code_action)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

if lspconfig.gopls then
  lspconfig.gopls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

-- Support both old/new server names across lspconfig versions.
if lspconfig.ts_ls then
  lspconfig.ts_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
elseif lspconfig.tsserver then
  lspconfig.tsserver.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end
EOF
