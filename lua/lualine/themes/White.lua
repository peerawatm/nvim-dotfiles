local bg = "#FFFFFF"
local fg = "#000000"
local sub = "#444444"
local detail = "#888888"

return {
  normal   = { a = { bg = bg, fg = fg }, b = { bg = bg, fg = sub }, c = { bg = bg, fg = detail }, x = { bg = bg, fg = detail }, y = { bg = bg, fg = detail }, z = { bg = bg, fg = detail } },
  insert   = { a = { bg = bg, fg = fg }, b = { bg = bg, fg = sub }, c = { bg = bg, fg = detail }, x = { bg = bg, fg = detail }, y = { bg = bg, fg = detail }, z = { bg = bg, fg = detail } },
  visual   = { a = { bg = bg, fg = fg }, b = { bg = bg, fg = sub }, c = { bg = bg, fg = detail }, x = { bg = bg, fg = detail }, y = { bg = bg, fg = detail }, z = { bg = bg, fg = detail } },
  replace  = { a = { bg = bg, fg = fg }, b = { bg = bg, fg = sub }, c = { bg = bg, fg = detail }, x = { bg = bg, fg = detail }, y = { bg = bg, fg = detail }, z = { bg = bg, fg = detail } },
  command  = { a = { bg = bg, fg = fg }, b = { bg = bg, fg = sub }, c = { bg = bg, fg = detail }, x = { bg = bg, fg = detail }, y = { bg = bg, fg = detail }, z = { bg = bg, fg = detail } },
  inactive = { a = { bg = bg, fg = sub }, b = { bg = bg, fg = sub }, c = { bg = bg, fg = sub }, x = { bg = bg, fg = sub }, y = { bg = bg, fg = sub }, z = { bg = bg, fg = sub } },
}
