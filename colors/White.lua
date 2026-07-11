vim.cmd("hi clear")
vim.o.background = "light"
vim.g.colors_name = "White"

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

-- NeoTree (Monochrome - No Green)
hl(0, "NeoTreeNormal", { bg = white, fg = '#000000' })
hl(0, "NeoTreeNormalNC", { bg = white, fg = '#000000' })
hl(0, "NeoTreeDirectoryName", { fg = '#000000', bold = true })
hl(0, "NeoTreeDirectoryIcon", { fg = '#888888' })
hl(0, "NeoTreeExpander", { fg = '#888888' })
hl(0, "NeoTreeFileName", { fg = '#000000' })
hl(0, "NeoTreeIndentMarker", { fg = light_grey })
hl(0, "NeoTreeGitAdded", { fg = '#000000' })
hl(0, "NeoTreeGitConflict", { fg = '#000000', bold = true })
hl(0, "NeoTreeGitDeleted", { fg = '#000000' })
hl(0, "NeoTreeGitIgnored", { fg = '#888888' })
hl(0, "NeoTreeGitModified", { fg = '#000000' })
hl(0, "NeoTreeGitUntracked", { fg = '#000000' })
hl(0, "NeoTreeDotfile", { fg = '#888888' })

-- Syntax (Monochrome)
local syntax = { "Constant", "String", "Identifier", "Function", "Statement", "PreProc", "Type", "Special", "Comment" }
for _, g in ipairs(syntax) do hl(0, g, { fg = '#000000' }) end
hl(0, "Comment", { fg = '#888888', italic = true })

-- VIVID ICONS (Official Brand Colors)
hl(0, "MiniIconsCyan",   { fg = "#00ADD8" }) -- Go/React
hl(0, "MiniIconsBlue",   { fg = "#004482" }) -- Official C Deep Blue
hl(0, "MiniIconsGreen",  { fg = '#888888' })      -- Neutralized for Tree
hl(0, "MiniIconsYellow", { fg = "#F7DF1E" }) -- Official JS Yellow
hl(0, "MiniIconsOrange", { fg = "#E34F26" }) -- HTML/Rust
hl(0, "MiniIconsPurple", { fg = "#9B4F96" }) -- Official C# Purple
hl(0, "MiniIconsRed",    { fg = "#FF0000" })
hl(0, "MiniIconsAzure",  { fg = "#00599C" }) -- Official C++ Blue
