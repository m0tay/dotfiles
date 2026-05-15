vim.g.mapleader = " "

-- OPTIONS ------------------------------------------------------------------
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes:1"
vim.opt.confirm = true
vim.opt.completeopt = { "menuone", "noinsert", "preview", "fuzzy", "popup" }
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
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/vague-theme/vague.nvim",
    "https://github.com/chomosuke/typst-preview.nvim",
    "https://github.com/alex35mil/pi.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/ej-shafran/compile-mode.nvim",
    "https://github.com/m00qek/baleia.nvim",
}

-- baleia's PATTERN only matches SGR sequences (ending in 'm'), so non-SGR CSI
-- sequences like ESC[K (Erase in Line, emitted by GCC/Clang color diagnostics)
-- are never stripped and show up literally as ^[[K in the buffer.
-- Fix: extend the pattern to all CSI sequences and guard apply() so non-SGR
-- sequences (which have no digit params and would otherwise trigger reset())
-- become no-ops instead of accidentally clearing active colors.
do
    local ansi = require("baleia.ansi")
    ansi.PATTERN = "\x1b%[[%d;:]*[A-Za-z]"
    local orig_apply = ansi.apply
    ansi.apply = function(seq, style)
        if seq:sub(-1) ~= "m" then return style or {} end
        return orig_apply(seq, style)
    end
end

---module "compile-mode"
---@type CompileModeOpts
vim.g.compile_mode = {
    baleia_setup = true,
    bang_expansion = true,
    use_pseudo_terminal = true,
    default_command = function()
        local filetype = vim.bo.filetype
        if filetype == "cpp" then
            return "c++ -std=c++23 -Wall -Wextra -o %< % && ./%<"
        elseif filetype == "c" then
            return "cc -std=c23 -Wall -Wextra -o %< % && ./%<"
        else
            return ""
        end
    end,
}

require("vague").setup { transparent = true }
require("pi").setup({
    layout = {
        -- Default layout when opening the chat: "side" or "float".
        default = "side",
        side = {
            -- Side panel position: "right" or "bottom".
            position = "right",
            -- Width in columns when position is "right".
            width = 60,
            panels = {
                -- Show winbars on each panel in side layout.
                history = { winbar = true },
                prompt = { winbar = true },
                attachments = { winbar = true },
            },
        },
        float = {
            -- Width/height: fraction (<1) or columns/lines (>=1).
            width = 0.6,
            height = 0.8,
            border = "rounded",
        },
    },
})
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
    "jdtls",
    "lua_ls",
    "racket_langserver",
    "tinymist",
}

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
        if client:supports_method('textDocument/completion') then
            local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
            client.server_capabilities.completionProvider.triggerCharacters = chars
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })

            -- Don't accept completion with Enter, only Ctrl-y
            vim.keymap.set('i', '<CR>', function()
                return vim.fn.pumvisible() == 1 and '<C-e><CR>' or '<CR>'
            end, { buffer = args.buf, expr = true })

            vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, { buffer = args.buf })
            vim.keymap.set('n', 'grD', vim.lsp.buf.declaration,      { buffer = args.buf })
            vim.keymap.set('n', 'grf', vim.lsp.buf.format,           { buffer = args.buf })
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
vim.keymap.set("n", "n", "nzzzv",    { desc = "next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv",    { desc = "previous search result (centered)" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "half page down (centered)" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "half page up (centered)" })
vim.keymap.set("v", "<", "<gv",      { desc = "indent left and reselect" })
vim.keymap.set("v", ">", ">gv",      { desc = "indent right and reselect" })
vim.keymap.set("n", "<leader>tv", function()
    vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
end, { desc = "toggle diagnostic virtual text" })
vim.keymap.set("n", "<leader>z", "1z=")
vim.keymap.set({ "n", "v" }, "<Leader>pp", function() vim.cmd("Pi layout=side")  end, { desc = "Pi side"  })
vim.keymap.set({ "n", "v" }, "<Leader>pl", "<Cmd>PiToggleLayout<CR>",                 { desc = "Pi toggle layout" })
vim.keymap.set({ "n", "v" }, "<Leader>pc", "<Cmd>PiContinue<CR>",                     { desc = "Pi continue last session" })
vim.keymap.set({ "n", "v" }, "<Leader>pr", "<Cmd>PiResume<CR>",                       { desc = "Pi resume past session" })
vim.keymap.set({ "n", "v" }, "<Leader>pm", "<Cmd>PiSendMention<CR>",                  { desc = "Pi mention file/selection" })
vim.keymap.set({ "n", "v" }, "<Leader>pa", "<Cmd>PiAttention<CR>",                    { desc = "Pi open next attention request" })

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
