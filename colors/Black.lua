vim.cmd("hi clear")
vim.o.background = "dark"
vim.g.colors_name = "black"

local hl = vim.api.nvim_set_hl
local black = "#000000"
local white = "#FFFFFF"
local grey = "#666666"
local dark_grey = "#222222"

-- Editor Core
hl(0, "Normal", { bg = black, fg = white })
hl(0, "NormalNC", { bg = black, fg = white })
hl(0, "CursorLine", { bg = "#111111" })
hl(0, "LineNr", { fg = grey })
hl(0, "EndOfBuffer", { fg = black })

-- UI Elements
hl(0, "Visual", { bg = "#333333" })
hl(0, "Search", { bg = "#FFFF00", fg = black })
hl(0, "IncSearch", { bg = white, fg = black })
hl(0, "Pmenu", { bg = dark_grey, fg = white })
hl(0, "PmenuSel", { bg = white, fg = black })
hl(0, "VertSplit", { fg = dark_grey })
hl(0, "NormalFloat", { bg = "NONE", fg = white })
hl(0, "FloatBorder", { bg = "NONE", fg = grey })

-- Statusline (Black Theme)
hl(0, "StatusLine", { bg = dark_grey, fg = white, bold = true })
hl(0, "StatusLineNC", { bg = black, fg = grey })

-- Syntax (Monochrome)
local syntax = { "Constant", "String", "Identifier", "Function", "Statement", "PreProc", "Type", "Special", "Comment" }
for _, g in ipairs(syntax) do hl(0, g, { fg = white }) end
hl(0, "Comment", { fg = grey, italic = true })
