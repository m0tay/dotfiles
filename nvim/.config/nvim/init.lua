vim.g.mapleader = " "

local paths_to_add = {
    "/opt/homebrew/bin",
    vim.fn.expand("~/.dotnet/tools"),
    vim.fn.expand("~/.cargo/bin"),
    vim.fn.expand("~/.npm-global/bin")
}
for _, p in ipairs(paths_to_add) do
    if not string.find(vim.env.PATH, p, 1, true) then
        vim.env.PATH = p .. ":" .. vim.env.PATH
    end
end

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

vim.pack.add {
    "https://github.com/vague-theme/vague.nvim",
    "https://github.com/chomosuke/typst-preview.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/NeogitOrg/neogit",
    "https://github.com/sindrets/diffview.nvim",
    "https://github.com/nvim-tree/nvim-web-devicons.git",
    "https://github.com/neovim/nvim-lspconfig.git",
    "https://github.com/williamboman/mason.nvim.git",
    "https://github.com/williamboman/mason-lspconfig.nvim.git",
    "https://github.com/romus204/tree-sitter-manager.nvim.git",
    "https://github.com/seblyng/roslyn.nvim.git",
    "https://github.com/x3ero0/dired.nvim.git",
    "https://github.com/MunifTanjim/nui.nvim.git",
    "https://github.com/mfussenegger/nvim-dap.git",
    "https://github.com/nvim-neotest/nvim-nio.git",
    "https://github.com/rcarriga/nvim-dap-ui.git",
    "https://github.com/jay-babu/mason-nvim-dap.nvim.git",
    "https://github.com/JavaHello/spring-boot.nvim.git",
    "https://github.com/nvim-java/nvim-java.git"
}



require("vague").setup { transparent = true }

vim.cmd.colorscheme 'vague'
vim.cmd.highlight 'statusline guibg=NONE'
vim.cmd.packadd 'nohlsearch' -- life changer

require("mason").setup({
    registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
    },
})
require("tree-sitter-manager").setup()

require("java").setup()

require("mason-lspconfig").setup({
    handlers = {
        function(server_name)
            if server_name ~= "roslyn" then
                require("lspconfig")[server_name].setup({})
            end
        end,
    },
})

vim.filetype.add({
    extension = {
        razor = "razor",
        cshtml = "razor",
    },
})

require("roslyn").setup()

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('my.lsp', {}),
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.completionProvider then
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end
    end,
})

local dap = require("dap")
local dapui = require("dapui")

dapui.setup()

require("mason-nvim-dap").setup({
    automatic_installation = false,
    handlers = {
        function(config)
            require('mason-nvim-dap').default_setup(config)
        end,
    },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

vim.keymap.set('n', '<F5>', dap.continue, { desc = "Debug: Continue" })
vim.keymap.set('n', '<F10>', dap.step_over, { desc = "Debug: Step Over" })
vim.keymap.set('n', '<F11>', dap.step_into, { desc = "Debug: Step Into" })
vim.keymap.set('n', '<F12>', dap.step_out, { desc = "Debug: Step Out" })
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })

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
