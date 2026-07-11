vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n","<leader>pv", vim.cmd.Ex)

-- Pure Manual Config
vim.opt.swapfile = false
vim.opt.number = true
vim.opt.relativenumber = false
vim.loader.enable()
vim.opt.updatetime = 200
vim.opt.timeoutlen = 500  -- Wait 500ms for leader bar
vim.opt.undofile = false
vim.opt.backup = false
vim.opt.mouse = ""
vim.opt.termguicolors = true

-- Load Plugins and Configs
require("config.keymaps")
require("config.autocmds")

-- Load other components
require("config.neotree")
require("config.lualine")
require("config.treesitter")
require("config.lsp")
require('mini.icons').setup({
  file = {
    ['.c']   = { glyph = '󰙱' },
    ['.cpp'] = { glyph = '󰙲' },
    ['.cs']  = { glyph = '󰙳' },
  },
})
MiniIcons.mock_nvim_web_devicons()
require("config.theme") -- Apply theme and icon overrides

-- Keymaps
vim.keymap.set("i", "<M-BS>", "<C-w>")
vim.keymap.set("i", "<D-BS>", "<C-u>")
vim.keymap.set("n", "<F2>", ":wq<CR>")

-- NeoTree Auto-setup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      require("neo-tree.command").execute({ toggle = false, dir = vim.fn.getcwd() })
    end
  end,
})

-- Plugins command
vim.api.nvim_create_user_command('Plugins', function()
  local plugins = vim.fn.glob('~/.config/nvim/pack/manual/start/*', 0, 1)
  print("--- Manual Plugins ---")
  for _, path in ipairs(plugins) do
    print("- " .. vim.fn.fnamemodify(path, ':t'))
  end
end, {})

-- Monochromatic Neo-tree overrides
local mono_colors = {
  NeoTreeNormal         = { fg = "#000000", bg = "NONE" },
  NeoTreeNormalNC       = { fg = "#000000", bg = "NONE" },
  NeoTreeDirectoryName  = { fg = "#000000", bold = true },
  NeoTreeDirectoryIcon  = { fg = "#000000" },
  NeoTreeFileName       = { fg = "#000000" },
  NeoTreeExpander       = { fg = "#666666" },
  NeoTreeGitAdded       = { fg = "#000000" },
  NeoTreeGitConflict    = { fg = "#000000", bold = true },
  NeoTreeGitDeleted     = { fg = "#888888" },
  NeoTreeGitIgnored     = { fg = "#888888" },
  NeoTreeGitModified    = { fg = "#000000" },
  NeoTreeGitUntracked   = { fg = "#000000", italic = true },
}

for group, settings in pairs(mono_colors) do
  vim.api.nvim_set_hl(0, group, settings)
end

-- Activate the White colorscheme
vim.cmd("colorscheme White")

-- Neo-tree Floating Window/Popup Overrides
local neo_tree_popups = {
  NeoTreeFloatBorder = { fg = "#000000", bg = "#FFFFFF" },
  NeoTreeFloatTitle  = { fg = "#FFFFFF", bg = "#000000", bold = true },
  NeoTreeNormal      = { fg = "#000000", bg = "#FFFFFF" },
  -- For input/rename dialogs
  NormalFloat        = { fg = "#000000", bg = "#FFFFFF" },
  FloatBorder        = { fg = "#000000", bg = "#FFFFFF" },
  FloatTitle         = { fg = "#FFFFFF", bg = "#000000" },
}

for group, settings in pairs(neo_tree_popups) do
  vim.api.nvim_set_hl(0, group, settings)
end
