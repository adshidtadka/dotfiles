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

-- Resolve pyright-langserver, preferring Homebrew over a pyenv shim.
-- The pyenv shim only works when pyright happens to be installed in the
-- active Python version, so it breaks when switching versions.
local function resolve_pyright()
  for _, bin in ipairs({
    "/opt/homebrew/bin/pyright-langserver",
    "/home/linuxbrew/.linuxbrew/bin/pyright-langserver",
    "/usr/local/bin/pyright-langserver",
  }) do
    if vim.fn.executable(bin) == 1 then
      return bin
    end
  end
  return "pyright-langserver"
end

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = { "python" },
  callback = function(args)
    set_lsp_maps(args.buf)
    vim.lsp.start({
      name = "pyright",
      cmd = { resolve_pyright(), "--stdio" },
      root_dir = project_root(args.buf, {
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        ".git",
      }),
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

  -- Prefer the project-local eslint, walking up from the buffer's directory.
  -- The global (Homebrew) eslint_d bundles its own eslint and resolves plugins
  -- from the project root, which breaks under pnpm's non-hoisted node_modules
  -- (e.g. eslint-plugin-react-hooks declared by eslint-config-next). The
  -- project-local eslint resolves plugins relative to the config file and works.
  local function resolve_eslint(bufnr)
    local fname = vim.api.nvim_buf_get_name(bufnr)
    local dir = vim.fs.dirname(fname)
    local local_bin = vim.fs.find("node_modules/.bin/eslint", { path = dir, upward = true })[1]
    if local_bin and vim.fn.executable(local_bin) == 1 then
      return local_bin
    end
    return nil
  end

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
      local linter = "eslint_d"
      local local_eslint = resolve_eslint(ev.buf)
      if local_eslint then
        lint.linters.eslint.cmd = local_eslint
        linter = "eslint"
      end
      if root then
        lint.try_lint(linter, { cwd = root })
      else
        lint.try_lint(linter)
      end
    end,
  })
end

-- Format with prettier on save.
-- Prefer the project-local prettier (respects its version and config),
-- then fall back to a global prettier/prettierd on PATH.
local function resolve_prettier(bufnr)
  local fname = vim.api.nvim_buf_get_name(bufnr)
  local dir = vim.fs.dirname(fname)
  local local_bin = vim.fs.find("node_modules/.bin/prettier", { path = dir, upward = true })[1]
  if local_bin and vim.fn.executable(local_bin) == 1 then
    return { local_bin }
  end
  for _, bin in ipairs({ "prettierd", "prettier" }) do
    if vim.fn.executable(bin) == 1 then
      return { bin }
    end
  end
  return nil
end

vim.api.nvim_create_autocmd("BufWritePre", {
  group = group,
  pattern = { "*.json", "*.jsonc", "*.css", "*.scss", "*.html", "*.yaml", "*.yml", "*.md", "*.graphql" },
  callback = function(ev)
    local cmd = resolve_prettier(ev.buf)
    if not cmd then
      return
    end
    table.insert(cmd, "--stdin-filepath")
    table.insert(cmd, vim.api.nvim_buf_get_name(ev.buf))
    local lines = vim.api.nvim_buf_get_lines(ev.buf, 0, -1, false)
    local input = table.concat(lines, "\n")
    local formatted = vim.fn.systemlist(cmd, input)
    if vim.v.shell_error ~= 0 then
      return
    end
    if not vim.deep_equal(lines, formatted) then
      local view = vim.fn.winsaveview()
      vim.api.nvim_buf_set_lines(ev.buf, 0, -1, false, formatted)
      vim.fn.winrestview(view)
    end
  end,
})
EOF
