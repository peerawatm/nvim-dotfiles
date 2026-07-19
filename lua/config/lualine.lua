-- Detect project version from Cargo.toml (Rust) or #define VERSION headers (C)
local _project_version_cache = ""
local function project_version()
  return _project_version_cache
end
local function _update_project_version()
  local root = vim.fn.getcwd()
  for _, dir in ipairs({ root, vim.fn.expand("%:p:h"), vim.fn.expand("%:p:h:h") }) do
    if dir == "" then goto continue end
    local f = io.open(dir .. "/Cargo.toml", "r")
    if f then
      for line in f:lines() do
        local v = line:match('^version%s*=%s*"([^"]+)"')
        if v then f:close(); _project_version_cache = "󱘗 " .. v; return end
      end
      f:close()
    else
      for _, pat in ipairs({ dir .. "/src/*.h", dir .. "/include/*.h", dir .. "/*.h" }) do
        for _, path in ipairs(vim.fn.glob(pat, false, true)) do
          f = io.open(path, "r")
          if f then
            for line in f:lines() do
              local v = line:match('#define%s+%w+_VERSION%s+"(.-)"')
              if v then f:close(); _project_version_cache = "󰏗 " .. v; return end
            end
            f:close()
          end
        end
      end
    end
    ::continue::
  end
  _project_version_cache = ""
end

local _git_head_cache = ""
local function git_head_id()
  return _git_head_cache
end
local function _update_git_head()
  local dir = vim.fn.expand("%:p:h")
  if dir == "" then dir = vim.fn.getcwd() end
  local cmd = string.format("git -C %s rev-parse --short HEAD 2>/dev/null", vim.fn.shellescape(dir))
  local head = vim.fn.systemlist(cmd)[1]
  if vim.v.shell_error ~= 0 or head == nil or head == "" then
    _git_head_cache = ""
  else
    _git_head_cache = " " .. head
  end
end

-- Update caches on buffer/focus events only, not on every lualine tick
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
  callback = function()
    _update_git_head()
    _update_project_version()
  end,
})
_update_git_head()
_update_project_version()

require('lualine').setup({
  options = {
    globalstatus = true,
    refresh = { statusline = 1e9, tabline = 1e9, winbar = 1e9 }, -- disable timer
    theme = "auto",
    component_separators = " ",
    section_separators = "",
    disabled_filetypes = {
      statusline = { "neo-tree" },
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", git_head_id, project_version, "filename" },
    lualine_c = { "diff", "progress", "location" },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  }
})

-- Event-driven refresh instead of timer
local lualine = require('lualine')
vim.api.nvim_create_autocmd({
  "ModeChanged", "BufEnter", "BufWritePost", "BufModifiedSet",
  "CursorMoved", "CursorMovedI", "DiagnosticChanged", "FocusGained",
}, {
  callback = function() lualine.refresh() end,
})

-- Watch .git dir via kqueue — catches git's full write sequence earlier
local function watch_git_head()
  local git_dir = vim.fn.getcwd() .. '/.git'
  if vim.fn.isdirectory(git_dir) == 0 then return end
  local handle = vim.uv.new_fs_event()
  if not handle then return end
  handle:start(git_dir, { recursive = false }, vim.schedule_wrap(function(err, filename)
    if not err and (filename == 'HEAD' or filename == 'HEAD.lock') then
      _update_git_head()
      lualine.refresh()
    end
  end))
end
watch_git_head()
