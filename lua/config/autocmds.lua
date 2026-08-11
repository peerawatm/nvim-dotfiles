local group = vim.api.nvim_create_augroup("ThemeSync", { clear = true })

_G.sync_theme = function()
  if #vim.api.nvim_list_uis() == 0 then
    return
  end
  local handle = io.popen("defaults read -g AppleInterfaceStyle 2>/dev/null")
  local result = handle:read("*a")
  handle:close()

  local is_dark = result:match("Dark") ~= nil
  local target = is_dark and "default" or "white"

  if is_dark then
    vim.o.background = "dark"
  end

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
  pattern = { "white.lua" },
  group = group,
  callback = function()
    vim.cmd("colorscheme " .. (vim.g.colors_name or "white"))
    vim.notify("Theme Reloaded", vim.log.levels.INFO)
  end,
})

-- Initial sync run
_G.sync_theme()

-- Auto-reload buffers when modified externally (event-driven via libuv fs_event)
vim.opt.autoread = true
local watchers = {}

local function watch_buf(buf)
  if not vim.api.nvim_buf_is_valid(buf) then return end
  local path = vim.api.nvim_buf_get_name(buf)
  if path == "" then return end
  if watchers[buf] then
    watchers[buf]:stop()
    watchers[buf] = nil
  end
  local handle = vim.uv.new_fs_event()
  if not handle then return end
  handle:start(path, {}, vim.schedule_wrap(function(err, _, events)
    if err then return end
    if vim.api.nvim_buf_is_valid(buf) then
      vim.cmd("silent! checktime " .. buf)
    end
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
vim.api.nvim_create_autocmd("FocusGained", {
  command = "silent! checktime",
})

for _, buf in ipairs(vim.api.nvim_list_bufs()) do
  watch_buf(buf)
end

-- Automatically open file picker when Neovim starts with no file arguments
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 and vim.api.nvim_buf_get_name(0) == "" then
      Snacks.picker.files()
    end
  end,
})
