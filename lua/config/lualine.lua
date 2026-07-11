-- Detect project version from Cargo.toml (Rust) or #define VERSION headers (C)
local function project_version()
  local root = vim.fn.getcwd()
  for _, dir in ipairs({ root, vim.fn.expand("%:p:h"), vim.fn.expand("%:p:h:h") }) do
    if dir == "" then goto continue end
    -- Try Cargo.toml first
    local f = io.open(dir .. "/Cargo.toml", "r")
    if f then
      for line in f:lines() do
        local v = line:match('^version%s*=%s*"([^"]+)"')
        if v then f:close(); return "󱘗 " .. v end
      end
      f:close()
    else
      -- Try header files
      for _, pat in ipairs({ dir .. "/src/*.h", dir .. "/include/*.h", dir .. "/*.h" }) do
        for _, path in ipairs(vim.fn.glob(pat, false, true)) do
          f = io.open(path, "r")
          if f then
            for line in f:lines() do
              local v = line:match('#define%s+%w+_VERSION%s+"(.-)"')
              if v then f:close(); return "󰏗 " .. v end
            end
            f:close()
          end
        end
      end
    end
    ::continue::
  end
  return ""
end
local function git_head_id()
  local dir = vim.fn.expand("%:p:h")
  if dir == "" then dir = vim.fn.getcwd() end
  local cmd = string.format("git -C %s rev-parse --short HEAD 2>/dev/null", vim.fn.shellescape(dir))
  local head = vim.fn.systemlist(cmd)[1]
  if vim.v.shell_error ~= 0 or head == nil or head == "" then
    return ""
  end
  return " " .. head
end

-- We will execute the exact logic that was in your opts function
local is_dark = vim.o.background == "dark"
local bg = is_dark and "NONE" or "#FFFFFF"
local fg = is_dark and "#aaaaaa" or "#000000"
local sub = is_dark and "#666666" or "#444444"
local detail = is_dark and "#555555" or "#888888"

require('lualine').setup({
  options = {
    globalstatus = true,
    theme = {
      normal   = { a = { bg = bg, fg = fg }, b = { bg = bg, fg = sub }, c = { bg = bg, fg = detail }, x = { bg = bg, fg = detail }, y = { bg = bg, fg = detail }, z = { bg = bg, fg = detail } },
      insert   = { a = { bg = bg, fg = fg }, b = { bg = bg, fg = sub }, c = { bg = bg, fg = detail }, x = { bg = bg, fg = detail }, y = { bg = bg, fg = detail }, z = { bg = bg, fg = detail } },
      visual   = { a = { bg = bg, fg = fg }, b = { bg = bg, fg = sub }, c = { bg = bg, fg = detail }, x = { bg = bg, fg = detail }, y = { bg = bg, fg = detail }, z = { bg = bg, fg = detail } },
      replace  = { a = { bg = bg, fg = fg }, b = { bg = bg, fg = sub }, c = { bg = bg, fg = detail }, x = { bg = bg, fg = detail }, y = { bg = bg, fg = detail }, z = { bg = bg, fg = detail } },
      command  = { a = { bg = bg, fg = fg }, b = { bg = bg, fg = sub }, c = { bg = bg, fg = detail }, x = { bg = bg, fg = detail }, y = { bg = bg, fg = detail }, z = { bg = bg, fg = detail } },
      inactive = { a = { bg = bg, fg = sub }, b = { bg = bg, fg = sub }, c = { bg = bg, fg = sub }, x = { bg = bg, fg = sub }, y = { bg = bg, fg = sub }, z = { bg = bg, fg = sub } },
    },
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
