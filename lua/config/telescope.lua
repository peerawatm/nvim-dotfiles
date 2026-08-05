require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
vim.keymap.set('n', '<leader>ds', function()
  local make_entry = require('telescope.make_entry')
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  if #clients > 0 then
    builtin.lsp_document_symbols({
      entry_maker = function(entry)
        local formatted = make_entry.gen_from_lsp_symbols({})(entry)
        if formatted then
          formatted.ordinal = formatted.symbol_name
        end
        return formatted
      end
    })
  else
    local ok = pcall(function()
      builtin.treesitter({
        entry_maker = function(entry)
          local formatted = make_entry.gen_from_treesitter({})(entry)
          if formatted then
            formatted.ordinal = formatted.node_text
          end
          return formatted
        end
      })
    end)
    if not ok then
      vim.notify("No active LSP client, and Treesitter parser is missing. Run :TSInstall " .. vim.bo.filetype, vim.log.levels.WARN)
    end
  end
end, { desc = 'Document Symbols (LSP / Treesitter)' })
vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Find Diagnostics' })
