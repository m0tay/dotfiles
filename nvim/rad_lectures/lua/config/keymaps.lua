-- Center screen when jumping
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- Quick file navigation
vim.keymap.set("n", "<leader>ff", ":find ", { desc = "Find file" })

-- Toggle netrw
vim.keymap.set("n", "<leader>pv", function()
  if vim.bo.filetype == "netrw" then
    vim.cmd("bd")
  else
    vim.cmd("Ex")
  end
end, { noremap = true, silent = true, desc = "Toggle file explorer" })

-- Quick config editing
vim.keymap.set("n", "<leader>rc", ":e ~/.config/$NVIM_APPNAME/init.lua<CR>", { desc = "Edit config" })

-- Quick sed keymap
vim.keymap.set("n", "S", ":s/", { desc = "Quick sed" })
vim.keymap.set("x", "S", ":s/", { desc = "Quick sed" })
