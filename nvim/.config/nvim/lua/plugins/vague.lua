vim.pack.add { "https://github.com/vague-theme/vague.nvim" }

require("vague").setup { transparent = true } -- colorscheme
vim.cmd.colorscheme 'vague'
vim.cmd.highlight 'statusline guibg=NONE'
