local function setup_syntax()
  local is_dark = vim.o.background == "dark"
  local hl = vim.api.nvim_set_hl

  -- Use your "Official Brand Colors" for the code
  local colors = {
    keyword  = is_dark and "#BB9AF7" or "#8959A8", -- Purple
    func     = "#00599C",                         -- Official C++ Blue (Azure)
    str      = is_dark and "#9ECE6A" or "#718C00", -- Green
    type     = is_dark and "#F7DF1E" or "#E34F26", -- Yellow/Orange
    variable = is_dark and "#A9B1D6" or "#4D4D4C", -- Subtle Grey/Blue
    comment  = is_dark and "#666666" or "#888888", -- Grey
    constant = "#FF0000",                         -- Red
  }

  -- Apply to Tree-sitter groups
  hl(0, "@keyword", { fg = colors.keyword, bold = true })
  hl(0, "@function", { fg = colors.func, bold = true })
  hl(0, "@function.call", { fg = colors.func })
  hl(0, "@string", { fg = colors.str })
  hl(0, "@type", { fg = colors.type })
  hl(0, "@variable", { fg = colors.variable })
  hl(0, "@comment", { fg = colors.comment, italic = true })
  hl(0, "@constant", { fg = colors.constant })
  hl(0, "@parameter", { fg = colors.variable })
  hl(0, "@property", { fg = colors.variable })
  hl(0, "@operator", { fg = is_dark and "#FFFFFF" or "#000000" })
  
  -- Also apply to standard vim groups to catch non-TS buffers
  hl(0, "Statement", { fg = colors.keyword, bold = true })
  hl(0, "Function", { fg = colors.func, bold = true })
  hl(0, "String", { fg = colors.str })
  hl(0, "Type", { fg = colors.type })
end

local function setup_icons()
  local is_dark = vim.o.background == "dark"
  local grey = is_dark and "#666666" or "#888888"

  local icon_colors = {
    Azure  = "#00599C", -- Official C++ Blue
    Blue   = "#004482", -- Official C Deep Blue
    Cyan   = is_dark and "#00FFFF" or "#00ADD8",
    Green  = grey, -- Neutralize green icons
    Grey   = grey,
    Orange = is_dark and "#FFA500" or "#E34F26",
    Purple = is_dark and "#FF00FF" or "#800080",
    Red    = "#FF0000",
    Yellow = "#F7DF1E", -- Official JS Yellow
    }
  for name, color in pairs(icon_colors) do
    vim.cmd(string.format("hi MiniIcons%s guifg=%s gui=NONE", name, color))
  end
end

-- Create an autocmd to re-apply these highlights whenever the theme changes
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    setup_syntax()
    setup_icons()
  end,
})

-- Initial run
setup_syntax()
setup_icons()
