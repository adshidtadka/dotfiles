if !exists('g:env')
  finish
endif

lua << EOF
if type(vim.lsp) ~= "table" or type(vim.lsp.start) ~= "function" then
  return
end

require("blink.cmp").setup({
  keymap = { preset = "default" },
  fuzzy = {
    implementation = "prefer_rust",
  },
  completion = {
    trigger = {
      show_on_trigger_character = true,
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    },
  },
  sources = {
    default = { "lsp", "path", "buffer" },
  },
})

local group = vim.api.nvim_create_augroup("my_lsp_setup", { clear = true })
local capabilities = require("blink.cmp").get_lsp_capabilities()

local function set_lsp_maps(bufnr)
  local opts = { buffer = bufnr, silent = true }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = group,
  callback = function(args)
    set_lsp_maps(args.buf)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "qf",
  callback = function()
    vim.keymap.set("n", "<CR>", "<CR>:cclose<CR>", { buffer = true, silent = true })
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

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

local ok_lint, lint = pcall(require, "lint")
if ok_lint then
  lint.linters_by_ft = {
    javascript = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    typescript = { "eslint_d" },
    typescriptreact = { "eslint_d" },
  }

  -- eslint_d はカレントディレクトリ基準でローカルの eslint を解決する。
  -- nvim の cwd がプロジェクト外（monorepo ルート等）だと同梱の新しい eslint に
  -- フォールバックし、eslint-config-next の rushstack patch が壊れて
  -- "Cannot read config file" を吐く。バッファごとにプロジェクトルートを
  -- cwd として渡すことで、必ずローカルの eslint を使わせる。
  local eslint_root_markers = {
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.cjs",
    "eslint.config.ts",
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.json",
    ".eslintrc.yml",
    ".eslintrc.yaml",
    "package.json",
  }

  vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
    group = group,
    pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.mjs", "*.cjs" },
    callback = function(ev)
      local root = vim.fs.root(ev.buf, eslint_root_markers)
      if root then
        lint.try_lint(nil, { cwd = root })
      else
        lint.try_lint()
      end
    end,
  })
end
EOF
