vim.cmd("hi clear")
vim.o.background = "light"
vim.g.colors_name = "white"

local hl = vim.api.nvim_set_hl
local white = "#FFFFFF"
local black = "#000000"
local grey = "#888888"
local light_grey = "#EEEEEE"

-- Editor Core
hl(0, "Normal", { bg = white, fg = "#000000" })
hl(0, "NormalNC", { bg = white, fg = "#000000" })
hl(0, "CursorLine", { bg = "#F5F5F5" })
hl(0, "LineNr", { fg = "#CCCCCC" })
hl(0, "EndOfBuffer", { fg = '#FFFFFF' })

-- UI Elements
hl(0, "Visual", { bg = "#E0E0E0" })
hl(0, "Search", { bg = "#FFFF00", fg = '#000000' })
hl(0, "IncSearch", { bg = black, fg = '#FFFFFF' })
hl(0, "Pmenu", { bg = light_grey, fg = '#000000' })
hl(0, "PmenuSel", { bg = black, fg = '#FFFFFF' })
hl(0, "VertSplit", { fg = light_grey })
hl(0, "NormalFloat", { bg = "NONE", fg = black })
hl(0, "FloatBorder", { bg = "NONE", fg = grey })

-- Statusline (White Theme)
hl(0, "StatusLine", { bg = white, fg = black, bold = true })
hl(0, "StatusLineNC", { bg = light_grey, fg = grey })

-- Syntax (Monochrome)
local syntax = { "Constant", "String", "Identifier", "Function", "Statement", "PreProc", "Type", "Special", "Comment" }
for _, g in ipairs(syntax) do hl(0, g, { fg = '#000000' }) end
hl(0, "Comment", { fg = '#888888', italic = true })
