-- Skip theme switching for headless or embedded processes
if #vim.api.nvim_list_uis() == 0 then
  return
end

local group = vim.api.nvim_create_augroup("ThemeSync", { clear = true })

_G.sync_theme = function()
  -- Detect macOS system theme
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  local result = handle:read("*a")
  handle:close()
  
  local is_dark = result:match("Dark") ~= nil
  local target = is_dark and "Black" or "White"
  
  -- Only change if actually different to prevent unnecessary redraws
  if vim.g.colors_name ~= target then
    vim.cmd("colorscheme " .. target)
  end
end

-- 1. Sync on focus (effectively catches system theme changes when switching back to terminal)
vim.api.nvim_create_autocmd("FocusGained", {
  group = group,
  callback = function()
    _G.sync_theme()
  end,
})

-- 2. Initial sync on startup
vim.api.nvim_create_autocmd("VimEnter", {
  group = group,
  callback = function()
    _G.sync_theme()
  end,
})

-- 3. File Watcher for live theme editing
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "White.lua", "Black.lua" },
  group = group,
  callback = function()
    vim.cmd("colorscheme " .. (vim.g.colors_name or "White"))
    vim.notify("Theme Reloaded", vim.log.levels.INFO)
  end,
})

-- Run immediately to catch the current state
_G.sync_theme()
