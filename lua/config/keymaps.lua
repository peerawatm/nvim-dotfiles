-- Add any additional keymaps here

-- Toggle between White (light) and Black (dark) modes
vim.keymap.set("n", "<leader>uw", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
  vim.notify("Appearance: " .. vim.o.background)
end, { desc = "Toggle White/Black Mode" })

-- Smart Window Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

-- Insert mode deletions
vim.keymap.set("i", "<M-BS>", "<C-w>")
vim.keymap.set("i", "<D-BS>", "<C-u>")
vim.keymap.set("n", "<F2>", ":wq<CR>")
