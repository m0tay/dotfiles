vim.opt.mouse = ""
vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
vim.opt.swapfile = false
vim.opt.winborder = "rounded"
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 16
vim.opt.smartindent = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.signcolumn = "yes:2"
vim.opt.completeopt = { "menuone", "noinsert", "preview", "fuzzy", "popup" }
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr'
vim.g.netrw_banner = 0
vim.diagnostic.config({ virtual_text = true })

vim.pack.add({
  { src = "https://github.com/rose-pine/neovim" },
  { src = "https://github.com/chomosuke/typst-preview.nvim" },
  { src = "https://github.com/Myriad-Dreamin/tinymist" },
})

-- Native Neovim 0.11+ Treesitter (yes!)
local parsers = { "just", "typst", "ada", "bash", "c", "cpp", "css", "html", "java", "javascript", "json", "latex", "lua", "markdown",
  "markdown_inline", "perl", "php", "python", "racket", "sql", "typescript", "vim", "vimdoc" }

vim.treesitter.language.register('bash', 'sh')
vim.treesitter.language.register('just', 'just')

for _, lang in ipairs(parsers) do
  vim.treesitter.language.add(lang)
end

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})


vim.lsp.enable({
  "ada_language_server",
  "bashls",
  "clangd",
  "cssls",
  "emmet_ls",
  "html",
  "intelephense",
  "jdtls",
  "lua_ls",
  "perlnavigator",
  "racket_langserver",
  "rust_analyzer",
  "ruff",
  "sqlls",
  "marksman",
  "sqls",
  "ts_ls",
  "tinymist",
})

require "rose-pine".setup({
  styles = {
    bold = false,
    italic = true,
    transparency = true,
  }
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

      -- Disable Enter to accept completion, only use Ctrl-y
      vim.keymap.set('i', '<CR>', function()
        if vim.fn.pumvisible() == 1 then
          return '<C-e><CR>'
        else
          return '<CR>'
        end
      end, { buffer = args.buf, expr = true })

      vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help)
      vim.keymap.set('n', 'grd', vim.lsp.buf.definition)
      vim.keymap.set('n', 'grD', vim.lsp.buf.declaration)
      vim.keymap.set('n', 'grf', vim.lsp.buf.format)
      vim.keymap.set('n', 'gri', vim.lsp.buf.implementation)
      vim.keymap.set('n', 'grr', vim.lsp.buf.references)
      vim.keymap.set('n', 'grn', vim.lsp.buf.rename)
      vim.keymap.set('n', 'gra', vim.lsp.buf.code_action)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover)
    end
  end,
})

vim.cmd [[colorscheme rose-pine]]
vim.cmd [[hi statusline guibg=NONE]]
vim.cmd [[packadd nohlsearch]] -- life changer

local map = vim.keymap.set
vim.g.mapleader = " "
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>q', ':quit<CR>')
map('n', '<leader>Q', ':qa<CR>')
map('n', '<leader>O', ':Open .<CR>')
map('n', '<leader>m', ':update<CR> :make<CR>')

map({ 'n', 'v' }, '<leader>y', '"+y')
map({ 'n', 'v' }, '<leader>d', '"+d')

map({ 'n', 'v' }, '<leader>o', ':update<CR> :source<CR>')

map('n', '<leader>e', ":Ex<CR>")

map("n", "n", "nzzzv", { desc = "next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "previous search result (centered)" })
map("n", "<C-d>", "<C-d>zz", { desc = "half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "half page up (centered)" })

map("v", "<", "<gv", { desc = "Indent left and reselect" })
map("v", ">", ">gv", { desc = "Indent right and reselect" })

-- highlight briefly yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- open help in vertical split
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'help',
  command = [[wincmd L]],
})

-- vim.net.request('tmpfile.com',
--   { retry = 3 },
--   vim.schedule_wrap(function(err, content)
--     if err then
--       vim.notify(tostring(err), vim.log.levels.INFO)
--       return
--     end
--
--     vim.print((vim.split(content.body, '\n', { plain = true })[1]))
--   end))
