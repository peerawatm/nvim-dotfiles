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
  hl(0, "@keyword.import", { fg = colors.keyword, bold = true })
  hl(0, "@keyword.function", { fg = colors.keyword, bold = true })
  hl(0, "@keyword.return", { fg = colors.keyword, bold = true })
  hl(0, "@keyword.operator", { fg = colors.keyword })

  hl(0, "@function", { fg = colors.func, bold = true })
  hl(0, "@function.call", { fg = colors.func })
  hl(0, "@function.builtin", { fg = colors.func, bold = true })
  hl(0, "@function.macro", { fg = colors.func })

  hl(0, "@string", { fg = colors.str })
  hl(0, "@string.documentation", { fg = colors.str })
  hl(0, "@string.escape", { fg = colors.type })
  hl(0, "@string.special", { fg = is_dark and "#7AA2F7" or "#00599C" })
  hl(0, "@string.special.path", { fg = is_dark and "#7AA2F7" or "#00599C" })
  hl(0, "@string.special.url", { fg = is_dark and "#7AA2F7" or "#00599C" })

  hl(0, "@type", { fg = colors.type })
  hl(0, "@type.builtin", { fg = colors.type })
  hl(0, "@type.definition", { fg = colors.type })

  hl(0, "@variable", { fg = colors.variable })
  hl(0, "@variable.builtin", { fg = colors.keyword })
  hl(0, "@variable.parameter", { fg = is_dark and "#E0AF68" or "#B565D8" })
  hl(0, "@variable.member", { fg = is_dark and "#7AA2F7" or "#00599C" })
  hl(0, "@property", { fg = is_dark and "#7AA2F7" or "#00599C" })
  hl(0, "@field", { fg = is_dark and "#7AA2F7" or "#00599C" })

  hl(0, "@constant", { fg = colors.constant })
  hl(0, "@constant.builtin", { fg = colors.constant })
  hl(0, "@boolean", { fg = colors.constant })
  hl(0, "@number", { fg = colors.constant })
  hl(0, "@number.float", { fg = colors.constant })

  hl(0, "@comment", { fg = colors.comment, italic = true })
  hl(0, "@operator", { fg = is_dark and "#FFFFFF" or "#000000" })
  hl(0, "@punctuation.bracket", { fg = is_dark and "#888888" or "#555555" })
  hl(0, "@punctuation.delimiter", { fg = is_dark and "#888888" or "#666666" })
  hl(0, "@punctuation.special", { fg = colors.keyword })

  -- Also apply to standard vim groups to catch non-TS buffers
  hl(0, "Statement", { fg = colors.keyword, bold = true })
  hl(0, "Function", { fg = colors.func, bold = true })
  hl(0, "String", { fg = colors.str })
  hl(0, "Type", { fg = colors.type })

  -- Mute listchars / indentation markers
  local ws_color = is_dark and "#2D2D2D" or "#E0E0E0"
  hl(0, "Whitespace", { fg = ws_color })
  hl(0, "NonText", { fg = ws_color })
  hl(0, "SpecialKey", { fg = ws_color })

  -- Fix cursor visibility across dark/light themes
  hl(0, "Cursor", { fg = is_dark and "#000000" or "#FFFFFF", bg = is_dark and "#FFFFFF" or "#000000" })
  hl(0, "TermCursor", { fg = is_dark and "#000000" or "#FFFFFF", bg = is_dark and "#FFFFFF" or "#000000" })
end

-- Create an autocmd to re-apply syntax highlights whenever the theme changes
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    setup_syntax()
  end,
})

-- Initial run
setup_syntax()
