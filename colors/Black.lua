vim.cmd("hi clear")
vim.o.background = "dark"
vim.g.colors_name = "Black"

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

-- NeoTree (Monochrome - No Green)
hl(0, "NeoTreeNormal", { bg = black, fg = white })
hl(0, "NeoTreeNormalNC", { bg = black, fg = white })
hl(0, "NeoTreeDirectoryName", { fg = white, bold = true })
hl(0, "NeoTreeDirectoryIcon", { fg = grey })
hl(0, "NeoTreeExpander", { fg = grey })
hl(0, "NeoTreeFileName", { fg = white })
hl(0, "NeoTreeIndentMarker", { fg = dark_grey })
hl(0, "NeoTreeGitAdded", { fg = white })
hl(0, "NeoTreeGitConflict", { fg = white, bold = true })
hl(0, "NeoTreeGitDeleted", { fg = white })
hl(0, "NeoTreeGitIgnored", { fg = grey })
hl(0, "NeoTreeGitModified", { fg = white })
hl(0, "NeoTreeGitUntracked", { fg = white })
hl(0, "NeoTreeDotfile", { fg = grey })

-- Syntax (Monochrome)
local syntax = { "Constant", "String", "Identifier", "Function", "Statement", "PreProc", "Type", "Special", "Comment" }
for _, g in ipairs(syntax) do hl(0, g, { fg = white }) end
hl(0, "Comment", { fg = grey, italic = true })

-- VIVID ICONS (Official Brand Colors)
hl(0, "MiniIconsCyan",   { fg = "#00FFFF" }) -- Go/React
hl(0, "MiniIconsBlue",   { fg = "#004482" }) -- Official C Deep Blue
hl(0, "MiniIconsGreen",  { fg = grey })      -- Neutralized for Tree
hl(0, "MiniIconsYellow", { fg = "#F7DF1E" }) -- Official JS Yellow
hl(0, "MiniIconsOrange", { fg = "#FFA500" }) -- HTML/Rust
hl(0, "MiniIconsPurple", { fg = "#9B4F96" }) -- Official C# Purple
hl(0, "MiniIconsRed",    { fg = "#FF0000" })
hl(0, "MiniIconsAzure",  { fg = "#00599C" }) -- Official C++ Blue
