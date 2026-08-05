vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n","<leader>pv", vim.cmd.Ex)

-- Pure Manual Config
vim.opt.swapfile = false
vim.opt.number = true
vim.opt.relativenumber = false
vim.loader.enable()
vim.opt.timeoutlen = 500  -- Wait 500ms for leader bar
vim.opt.undofile = false
vim.opt.backup = false
vim.opt.mouse = ""
vim.opt.termguicolors = true
vim.opt.cmdheight = 0
vim.opt.clipboard = "unnamedplus"

-- Custom plugins
require("config.keymaps")
require("config.autocmds")

-- 3rd party plugins
require("config.neotree")
require("config.lualine")
require("config.treesitter")
require("config.lsp")
require("config.mini")
require("config.theme")
require("config.snacks")
require("config.telescope")

-- Plugins command
vim.api.nvim_create_user_command('Plugins', function()
  local plugins = vim.fn.glob('~/.config/nvim/pack/manual/start/*', false, true)
  print("--- Manual Plugins ---")
  for _, path in ipairs(plugins) do
    print("- " .. vim.fn.fnamemodify(path, ':t'))
  end
end, {})

-- Activate the White colorscheme
vim.cmd("colorscheme White")

-- Render Markdown
vim.opt.conceallevel = 2
require('render-markdown').setup({})
