if !exists('g:env')
  finish
endif

lua << EOF
if type(vim.lsp) ~= "table" or type(vim.lsp.start) ~= "function" then
  return
end

local group = vim.api.nvim_create_augroup("my_lsp_setup", { clear = true })
local capabilities = vim.lsp.protocol.make_client_capabilities()

local function set_lsp_maps(bufnr)
  local opts = { buffer = bufnr, silent = true }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(args)
    set_lsp_maps(args.buf)
  end,
})

local function project_root(bufnr, markers)
  local fname = vim.api.nvim_buf_get_name(bufnr)
  local dir = vim.fs.dirname(fname)
  local root = nil
  if type(vim.fs) == "table" and type(vim.fs.root) == "function" then
    root = vim.fs.root(dir, markers)
  elseif type(vim.fs) == "table" and type(vim.fs.find) == "function" then
    local found = vim.fs.find(markers, { path = dir, upward = true })[1]
    if found then
      root = vim.fs.dirname(found)
    end
  end
  return root or vim.fn.getcwd()
end

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "go", "gomod", "gowork", "gotmpl" },
  callback = function(args)
    set_lsp_maps(args.buf)
    vim.lsp.start({
      name = "gopls",
      cmd = { "gopls" },
      root_dir = project_root(args.buf, { "go.work", "go.mod", ".git" }),
      capabilities = capabilities,
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
  callback = function(args)
    set_lsp_maps(args.buf)
    vim.lsp.start({
      name = "ts_ls",
      cmd = { "typescript-language-server", "--stdio" },
      root_dir = project_root(args.buf, {
        "package-lock.json",
        "yarn.lock",
        "pnpm-lock.yaml",
        "bun.lockb",
        "bun.lock",
        "tsconfig.json",
        "jsconfig.json",
        ".git",
      }),
      capabilities = capabilities,
    })
  end,
})
EOF
