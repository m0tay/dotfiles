vim.g.mapleader = " "

vim.keymap.set('n', '<leader><leader>', ':Ex<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>Q', ':qa<CR>')
vim.keymap.set('n', '<leader>O', ':Open .<CR>')
vim.keymap.set('n', '<leader>m', ':update<CR> :make<CR>')
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y')
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p')
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P')
vim.keymap.set({ 'n', 'v' }, '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set("n", "n", "nzzzv", { desc = "next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "half page up (centered)" })
vim.keymap.set("v", "<", "<gv", { desc = "indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "indent right and reselect" })
vim.keymap.set("n", "<leader>tv", function()
    vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
end, { desc = "toggle diagnostic virtual text" })
vim.keymap.set("n", "<leader>z", "1z=")
vim.keymap.set("n", "<leader>g", "<cmd>Neogit<cr>", { desc = "Open Neogit UI" })

vim.keymap.set("n", "<leader>cfg", function()
    vim.cmd(":e ~/.config/nvim/init.lua")
    vim.cmd(":Explore")
end, { desc = "edit config" })

if vim.g.neovide then
    vim.opt.clipboard = "unnamedplus"
    vim.g.neovide_input_use_logo = 1

    vim.keymap.set('v', '<D-c>', '"+y', { noremap = true, silent = true })
    vim.keymap.set({ 'n', 'v' }, '<D-v>', '"+P', { noremap = true, silent = true })
    vim.keymap.set('i', '<D-v>', '<C-r><C-p>+', { noremap = true, silent = true })
    vim.keymap.set('c', '<D-v>', '<C-r>+', { noremap = true, silent = true })
    vim.keymap.set('t', '<D-v>', '<C-\\><C-n>"+pi', { noremap = true, silent = true })
end


