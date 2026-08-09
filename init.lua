vim.loader.enable()

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

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

-- Custom plugins
require("config.keymaps")
require("config.autocmds")

-- 3rd party plugins
require("config.treesitter")
require("config.lsp")
require("config.theme")
require("config.snacks")
require("render-markdown").setup({})

-- Plugins command
vim.api.nvim_create_user_command("Plugins", function()
  local plugins = vim.fn.glob("~/.config/nvim/pack/manual/start/*", false, true)
  print("--- Manual Plugins ---")
  for _, path in ipairs(plugins) do
    print("- " .. vim.fn.fnamemodify(path, ":t"))
  end
end, {})

-- Activate the White colorscheme
vim.cmd("colorscheme White")
