vim.g.mapleader = " "

-- OPTIONS ------------------------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes:1"
vim.opt.confirm = true
vim.opt.completeopt = { "menuone", "noinsert", "fuzzy", "popup" }
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
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'marker'
-- vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr'
vim.g.netrw_banner = 0
vim.diagnostic.config({ virtual_text = true })

-- PLUGINS ------------------------------------------------------------------
vim.pack.add {
    "neovim/nvim-lspconfig",
    "vague-theme/vague.nvim",
    "chomosuke/typst-preview.nvim",
    "nvim-lua/plenary.nvim",
    "NeogitOrg/neogit",
    "sindrets/diffview.nvim",
    "ibhagwan/fzf-lua",
}


require("vague").setup { transparent = true }

vim.cmd.colorscheme 'vague'
vim.cmd.highlight 'statusline guibg=NONE'
vim.cmd.packadd 'nohlsearch' -- life changer

-- LSP ----------------------------------------------------------------------
vim.lsp.enable {
    "basedpyright",
    "bashls",
    "clangd",
    "emmet_ls",
    "fish_lsp",
    "html",
    "lua_ls",
    "racket_langserver",
    "tinymist",
    "zls"
}

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })

            -- -- Don't accept completion with Enter, only Ctrl-y
            -- vim.keymap.set('i', '<CR>', function()
            --     return vim.fn.pumvisible() == 1 and '<C-e><CR>' or '<CR>'
            -- end, { buffer = args.buf, expr = true })

            vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, { buffer = args.buf })
            vim.keymap.set('n', 'grD', vim.lsp.buf.declaration, { buffer = args.buf })
            vim.keymap.set('n', 'grf', vim.lsp.buf.format, { buffer = args.buf })
        end
    end,
})

-- KEYMAPS ------------------------------------------------------------------
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

-- AUTOCMDS -----------------------------------------------------------------
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('help_vertical', { clear = true }),
    pattern = 'help',
    command = 'wincmd L',
    desc = 'open help in vertical split',
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup('yank_highlight', { clear = true }),
    callback = function() vim.highlight.on_yank() end,
    desc = 'briefly highlight yanked text',
})

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    local pid = vim.fn.jobpid(vim.b.terminal_job_id)
    vim.api.nvim_buf_set_name(0, "terminal " .. pid)
  end,
})
