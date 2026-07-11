require('nvim-treesitter').setup({
  ensure_installed = { "lua", "vim", "vimdoc", "rust", "javascript", "typescript", "python" },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true
  },
})
