require('nvim-treesitter').setup({
  ensure_installed = { "lua", "vim", "vimdoc", "rust", "python", "nix", "markdown", "markdown_inline" },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  },
})
