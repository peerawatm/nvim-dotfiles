-- Skip theme switching for headless or embedded processes
if #vim.api.nvim_list_uis() == 0 then
  return
end

local group = vim.api.nvim_create_augroup("ThemeSync", { clear = true })

_G.sync_theme = function()
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  local result = handle:read("*a")
  handle:close()

  local is_dark = result:match("Dark") ~= nil
  local target = is_dark and "Black" or "White"

  if vim.g.colors_name ~= target then
    vim.cmd("colorscheme " .. target)
  end
end

-- Sync theme on focus and initial startup
vim.api.nvim_create_autocmd({ "FocusGained", "VimEnter" }, {
  group = group,
  callback = function()
    _G.sync_theme()
  end,
})

-- Live reload custom theme files on write
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "White.lua", "Black.lua" },
  group = group,
  callback = function()
    vim.cmd("colorscheme " .. (vim.g.colors_name or "White"))
    vim.notify("Theme Reloaded", vim.log.levels.INFO)
  end,
})

-- Initial sync run
_G.sync_theme()

-- Auto-reload buffers when modified externally
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  pattern = "*",
  command = "silent! checktime",
})
