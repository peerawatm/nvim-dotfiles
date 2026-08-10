-- File Explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open Netrw Explorer" })

-- Window Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window" })

-- Editing & Saving
vim.keymap.set("i", "<M-BS>", "<C-w>")
vim.keymap.set("i", "<D-BS>", "<C-u>")
vim.keymap.set("n", "<F2>", ":wq<CR>", { desc = "Save and Quit" })

-- Appearance Toggle
vim.keymap.set("n", "<leader>uw", function()
  if vim.o.background == "dark" then
    vim.o.background = "light"
  else
    vim.o.background = "dark"
  end
  vim.notify("Appearance: " .. vim.o.background)
end, { desc = "Toggle White/Black Mode" })

-- Search Root Helper
local function get_search_root()
  local file_dir = vim.fn.expand("%:p:h")
  if file_dir == "" or file_dir == "." then
    file_dir = vim.fn.getcwd()
  end
  local root = Snacks.git.get_root() or file_dir
  if root == vim.env.HOME then
    root = file_dir
  end
  return root
end

-- Snacks Picker
vim.keymap.set("n", "<leader>g", function()
  Snacks.picker.grep({ cwd = get_search_root() })
end, { desc = "Grep Code" })

vim.keymap.set("n", "<leader>f", function()
  Snacks.picker.files({ cwd = get_search_root() })
end, { desc = "Find Files" })
