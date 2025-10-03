vim.cmd([[set mouse=]])
vim.cmd([[set noswapfile]])
vim.opt.winborder = "rounded"
vim.opt.tabstop = 2
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.signcolumn = "yes"

vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/mason-org/mason.nvim" },
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


vim.cmd [[set completeopt+=noselect]]

vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

local map = vim.keymap.set
vim.g.mapleader = " "
map('n', '<leader>w', '<Cmd>write<CR>')
map('n', '<leader>q', '<Cmd>quit<CR>')
map('n', '<C-f>', '<Cmd>Open .<CR>')
map('n', '<leader>M', ':update<CR> :make<CR>')

map({ 'n', 'v', 'x' }, '<leader>m', ':move ')
map("n", "grf", ":lua vim.lsp.buf.format()<CR>")

-- I use norm and sed so much this makes sense
map({ 'n', 'v' }, '<leader>n', ':norm ')
map({ 'n', 'v' }, '<leader>s', ':s/')

map({ 'n', 'v' }, '<leader>y', '"+y')
map({ 'n', 'v' }, '<leader>d', '"+d')

map({ 'n', 'v' }, '<leader>o', ':update<CR> :source<CR>')

map('n', '<leader>f', "<Cmd>Pick files<CR>")
map('n', '<leader>r', "<Cmd>Pick buffers<CR>")
map('n', '<leader>h', "<Cmd>Pick help<CR>")
map('n', '<leader>e', "<Cmd>Oil<CR>")
map('n', '<leader>g', ':Pick grep_live<CR>')

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })


local api = vim.api

api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
})
