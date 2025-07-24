vim.keymap.set("n", "-", "<cmd>Oil --float<CR>", { desc = "Open Parent Directory in Oil" })

vim.keymap.set("n", "<leader>gl", function()
	vim.diagnostic.open_float()
end, { desc = "Open diagnostics in a floating window" })

-- Copy to system clipboard
vim.keymap.set("n", "y", '"+y', { noremap = true, silent = true })
vim.keymap.set("n", "yy", '"+yy', { noremap = true, silent = true })
vim.keymap.set("v", "y", '"+y', { noremap = true, silent = true })
vim.keymap.set("x", "y", '"+y', { noremap = true, silent = true })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true })

vim.keymap.set("n", "<leader>bh", ":new<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>bv", ":vnew<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

vim.keymap.set("n", "<leader>cf", function()
	require("conform").format({
		lsp_format = "fallback",
	})
end, { desc = "Format current file" })

vim.keymap.set("n", "<leader>gg", function()
	require("snacks").lazygit.open()
end, { desc = "Lazygit (snacks)" })

-- vim.keymap.set("n", "<leader>t", ":sp | term<CR>i", { noremap = true, silent = true, desc = "Open Terminal" })
vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true, desc = "Open Terminal" })
vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", { noremap = true, silent = true })

vim.keymap.set("t", "<leader>t", "<C-\\><C-N><C-w>t", { noremap = true, silent = true })
vim.keymap.set("t", "<C-h>", "<C-\\><C-N><C-w>h", { noremap = true, silent = true })
vim.keymap.set("t", "<C-j>", "<C-\\><C-N><C-w>j", { noremap = true, silent = true })
vim.keymap.set("t", "<C-k>", "<C-\\><C-N><C-w>k", { noremap = true, silent = true })
vim.keymap.set("t", "<C-l>", "<C-\\><C-N><C-w>l", { noremap = true, silent = true })
