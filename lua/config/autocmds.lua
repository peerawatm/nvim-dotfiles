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

-- Watch macOS system theme change instantly using Swift observer (Distributed Notification Center)
local function watch_system_theme()
  local observer_path = vim.fn.expand("~/.config/nvim/lua/config/theme_observer.swift")
  if vim.fn.filereadable(observer_path) == 0 then return end

  vim.fn.jobstart({ "swift", observer_path }, {
    stdout_buffered = false,
    on_stdout = function(_, data)
      if not data then return end
      for _, line in ipairs(data) do
        if line == "dark" then
          if vim.g.colors_name ~= "Black" then
            vim.cmd("colorscheme Black")
          end
        elseif line == "light" then
          if vim.g.colors_name ~= "White" then
            vim.cmd("colorscheme White")
          end
        end
      end
    end,
  })
end
watch_system_theme()

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

-- Auto-reload: event-driven via libuv fs_event (kqueue on macOS, zero polling)
vim.opt.autoread = true
local watchers = {}

local function watch_buf(buf)
  local path = vim.api.nvim_buf_get_name(buf)
  if path == "" then return end
  -- Stop any existing (possibly stale) watcher before re-registering
  if watchers[buf] then
    watchers[buf]:stop()
    watchers[buf] = nil
  end
  local handle = vim.uv.new_fs_event()
  if not handle then return end
  handle:start(path, {}, vim.schedule_wrap(function(err, _, events)
    if err then return end
    vim.cmd("silent! checktime " .. buf)
    -- Atomic rename (overwrite) replaces the inode — restart watcher on new file
    if events and events.rename then
      watch_buf(buf)
    end
  end))
  watchers[buf] = handle
end

local function unwatch_buf(buf)
  if watchers[buf] then
    watchers[buf]:stop()
    watchers[buf] = nil
  end
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  callback = function(ev) watch_buf(ev.buf) end,
})
vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
  callback = function(ev) unwatch_buf(ev.buf) end,
})
-- Fallback: checktime on focus in case a watcher missed an event
vim.api.nvim_create_autocmd("FocusGained", {
  command = "silent! checktime",
})

for _, buf in ipairs(vim.api.nvim_list_bufs()) do
  watch_buf(buf)
end
