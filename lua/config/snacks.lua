-- Mock lazy.stats for snacks.nvim dashboard since we use manual packages
package.preload["lazy.stats"] = function()
  return {
    stats = function()
      local plugins = vim.fn.glob(vim.fn.stdpath("config") .. "/pack/manual/start/*", 0, 1)
      return {
        startuptime = 0,
        loaded = #plugins,
        count = #plugins,
      }
    end
  }
end

require("snacks").setup({
  bigfile = { enabled = true },
  dashboard = { enabled = false },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
})
