vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes:1"
vim.opt.confirm = true
vim.opt.completeopt = "menuone,noinsert,preview,fuzzy,popup"
vim.opt.textwidth = 100
vim.opt.swapfile = false
vim.opt.wildoptions:append { 'fuzzy' }
vim.opt.path:append { '**' }
vim.opt.smoothscroll = true
vim.opt.termguicolors = true
vim.opt.winborder = "rounded"
vim.opt.cursorline = true
vim.opt.wrap = true
vim.opt.ignorecase = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 16
vim.opt.smartindent = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.undofile = true
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr'
vim.g.netrw_banner = 0
vim.diagnostic.config({ virtual_text = true })


vim.pack.add { 
	"https://github.com/neovim/nvim-lspconfig",
    "https://github.com/vague-theme/vague.nvim",
	"https://github.com/chomosuke/typst-preview.nvim",
}

require("vague").setup {
	transparent = true
}
vim.cmd [[colorscheme vague]]
vim.cmd [[hi statusline guibg=NONE]]
vim.cmd [[packadd nohlsearch]] -- life changer


vim.g.mapleader = " "

vim.keymap.set('n', '<leader><leader>', ":Ex<CR>")
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
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })
vim.keymap.set("n", "<leader>tv", ":lua vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })<CR><CR>")
vim.keymap.set("n", "<leader>z", "1z=")



-- open help in vertical split
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'help',
    command = [[wincmd L]],
})

-- highlight briefly yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})
