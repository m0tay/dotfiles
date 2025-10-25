vim.cmd([[set mouse=]])
vim.cmd([[set noswapfile]])
vim.opt.winborder = "rounded"
vim.opt.tabstop = 2
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.shiftwidth = 2
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 19
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.signcolumn = "yes:2"

vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/echaya/neowiki.nvim" },
	{ src = "https://github.com/iamcco/markdown-preview.nvim" },
})

-- local ts = require("treesitter")
-- ts.setup()
-- ts.disable("cpp")
require "mini.pick".setup()
require "oil".setup({
	view_options = {
		show_hidden = true }
}
)
require "mason".setup()
require "neowiki".setup({
	wiki_dirs = {
		{ name = "wiki",  path = "~/Documents/wiki" },
		{ name = "m0tay", path = "~/Documents/wiki/m0tay" },
		{ name = "ua",    path = "~/Documents/wiki/ua" },
	},
})


vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method('textDocument/completion') then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end,
})

vim.lsp.enable(
	{
		"lua_ls",
		"emmetls",
		"ts_ls",
		"clangd",
		"ruff",
		"texlab",
		"bashls",
	}
)
-- vim.diagnostic.config({ virtual_text = true })

vim.cmd [[set completeopt+=menuone,noinsert,noselect,preview,fuzzy,popup]]

vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

local map = vim.keymap.set
vim.g.mapleader = " "
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>q', ':quit<CR>')
map('n', '<leader>Q', ':qa<CR>')
map('n', '<C-f>', ':Open .<CR>')
map('n', '<leader>m', ':update<CR> :make<CR>')

map("n", "grf", ":lua vim.lsp.buf.format()<CR>")

-- I use norm and sed so much this makes sense
map({ 'n', 'v' }, '<leader>n', ':norm ')
map({ 'n', 'v' }, '<leader>s', ':s/')

map({ 'n', 'v' }, '<leader>y', '"+y')
map({ 'n', 'v' }, '<leader>d', '"+d')

map({ 'n', 'v' }, '<leader>o', ':update<CR> :source<CR>')

map('n', '<leader>f', ":Pick files<CR>")
map('n', '<leader>r', ":Pick buffers<CR>")
map('n', '<leader>h', ":Pick help<CR>")
map('n', '<leader>e', ":Oil<CR>")
map('n', '<leader>g', ':Pick grep_live<CR>')

map("n", "n", "nzzzv", { desc = "next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "previous search result (centered)" })
map("n", "<c-d>", "<c-d>zz", { desc = "half page down (centered)" })
map("n", "<c-u>", "<c-u>zz", { desc = "half page up (centered)" })

map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

map('n', '<leader>ww', "<cmd>lua require('neowiki').open_wiki()<cr>")

local api = vim.api

api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})
