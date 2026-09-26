vim.pack.add { "https://github.com/hrsh7th/nvim-cmp.git" }
vim.pack.add { "https://github.com/hrsh7th/cmp-nvim-lsp.git" }
vim.pack.add { "https://github.com/hrsh7th/cmp-buffer.git" }
vim.pack.add { "https://github.com/hrsh7th/cmp-path.git" }

local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then return end

cmp.setup({
    completion = {
        autocomplete = false,
    },
    snippet = {
        expand = function(args)
            vim.snippet.expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-p>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if vim.snippet.active({ direction = 1 }) then
                vim.snippet.jump(1)
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if vim.snippet.active({ direction = -1 }) then
                vim.snippet.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
        { name = "lazydev", group_index = 0 },
        { name = "nvim_lsp" },
    }, {
        { name = "buffer" },
        { name = "path" },
    }),
})

vim.keymap.set('i', '<C-x><C-o>', function()
    require('cmp').complete()
end, { noremap = true, silent = true })
