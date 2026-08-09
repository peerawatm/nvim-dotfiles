-- Modern Neovim 0.11+ LSP configuration using vim.lsp.config
-- This resolves the deprecation warning for require('lspconfig')

-- Navigation/Keymaps when an LSP attaches
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local opts = { noremap = true, silent = true, buffer = bufnr }
    -- Navigation
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  end,
})

-- Setup rust_analyzer using the modern API
vim.lsp.config('rust_analyzer', {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', '.git' },
  settings = {
    ["rust-analyzer"] = {
      check = {
        command = "clippy",
      },
    },
  },
})

-- Enable the server for current/future buffers
vim.lsp.enable('rust_analyzer')

-- Setup lua_ls using the modern API
vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.git', 'init.lua' },
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim', 'Snacks' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
})

-- Enable the server for current/future buffers
vim.lsp.enable('lua_ls')

-- Setup clangd using the modern API
vim.lsp.config('clangd', {
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
  root_markers = { '.clang-format', 'compile_commands.json', 'CMakeLists.txt', '.git' },
})

-- Enable the server for current/future buffers
vim.lsp.enable('clangd')

-- Setup nil_ls using the modern API
vim.lsp.config('nil_ls', {
  cmd = { 'nil' },
  filetypes = { 'nix' },
  root_markers = { 'flake.nix', 'default.nix', '.git' },
})

-- Enable the server for current/future buffers
vim.lsp.enable('nil_ls')
