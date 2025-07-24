vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_liststyle = 3


vim.opt.completeopt="menuone,noselect,popup" -- see `:h completeopt`

vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.shiftwidth = 4 -- Amount to indent with << and >>
vim.opt.tabstop = 4 -- How many spaces are shown per Tab
vim.opt.softtabstop = 4 -- How many spaces are applied when pressing Tab
vim.opt.cmdheight = 0 -- Disable commandline until it is needed

vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true -- Inherit indentation from previous line
vim.opt.breakindent = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.cursorline = true -- Show line under cursor

vim.opt.undofile = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"  -- Store undos between sessions
vim.opt.undofile = true

vim.opt.showmode = false -- Don't show the mode, since it's already in the status line
vim.opt.showcmd = true -- Show (partial) command in the last line of the screen
vim.opt.visualbell = true -- Use visual bell instead of beeping
vim.opt.incsearch = true -- Show search matches while typing
vim.opt.hlsearch = true -- Highlight search results

vim.opt.ignorecase = true -- Search in both realms if not provided one or more capital letters
vim.opt.smartcase = true

vim.opt.signcolumn = "yes" -- Keep signcolumn on by default

vim.opt.splitright = true
vim.opt.splitbelow = true

-- vim.opt.clipboard:append("unnamed") -- Use system clipboard

vim.opt.inccommand = "split" -- Preview substitutions live, as you type

vim.opt.scrolloff = 10 -- Minimal number of lines to keep above and below the cursor

vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("YankHighlight", {
		clear = true,
	}),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank()
	end,
	desc = "Highlight yank",
})

