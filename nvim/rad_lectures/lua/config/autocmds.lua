local api = vim.api

api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

-- Highlight on yank
api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Enable spell checking for certain file types
api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    -- { pattern = { "*.txt", "*.md", "*.tex" }, command = [[setlocal spell<cr> setlocal spelllang=en,de<cr>]] }
    {
        pattern = { "*.txt", "*.md", "*.tex" },
        callback = function()
            vim.opt.spell = true
            vim.opt.spelllang = "en"
        end,
    }
)

vim.api.nvim_create_autocmd("FileType", {
    callback = function()
        pcall(vim.treesitter.start)
    end,
})
