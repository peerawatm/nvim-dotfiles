vim.loader.enable()

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- General options
vim.opt.swapfile = false
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.timeoutlen = 500  -- Wait 500ms for leader bar
vim.opt.undofile = false
vim.opt.backup = false
vim.opt.mouse = ""
vim.opt.termguicolors = true
vim.opt.cmdheight = 0
vim.opt.clipboard = "unnamedplus"
vim.opt.conceallevel = 2
vim.opt.list = true
vim.opt.listchars = { lead = "·", tab = "──▶" }
vim.opt.statusline = " %f %m %r %= %y %l:%c %p%% "
vim.opt.wrap = false

-- Core configurations
require("config.keymaps")
require("config.autocmds")
require("config.theme")
require("config.lsp")

-- Plugin setups
require("snacks").setup({
  bigfile = { enabled = true },
  dashboard = { enabled = false },
  notifier = { enabled = true },
  picker = { enabled = true },
  quickfile = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
})

require("nvim-treesitter").setup({
  ensure_installed = { "lua", "vim", "vimdoc", "rust", "python", "nix", "markdown", "markdown_inline" },
  highlight = { enable = true },
  indent = { enable = true },
})

-- Plugins command
vim.api.nvim_create_user_command("Plugins", function()
  local plugins = vim.fn.glob("~/.config/nvim/pack/manual/start/*", false, true)
  print("--- Manual Plugins ---")
  for _, path in ipairs(plugins) do
    print("- " .. vim.fn.fnamemodify(path, ":t"))
  end
end, {})

-- Activate initial colorscheme
vim.cmd("colorscheme white")
