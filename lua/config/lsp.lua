-- Modern Neovim 0.11+ LSP configuration using vim.lsp.config

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { noremap = true, silent = true, buffer = args.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  end,
})

local servers = {
  rust_analyzer = {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { 'Cargo.toml', '.git' },
    settings = { ["rust-analyzer"] = { check = { command = "clippy" } } },
  },
  lua_ls = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = { '.git', 'init.lua' },
    settings = {
      Lua = {
        diagnostics = { globals = { 'vim', 'Snacks' } },
        workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  },
  clangd = {
    cmd = { 'clangd' },
    filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
    root_markers = { '.clang-format', 'compile_commands.json', 'CMakeLists.txt', '.git' },
  },
  nil_ls = {
    cmd = { 'nil' },
    filetypes = { 'nix' },
    root_markers = { 'flake.nix', 'default.nix', '.git' },
  },
}

for name, config in pairs(servers) do
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end
