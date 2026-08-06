vim.pack.add {
    "https://github.com/seblyng/roslyn.nvim.git",
    "https://github.com/GustavEikaas/easy-dotnet.nvim.git",
}

vim.filetype.add({
    extension = {
        razor = "razor",
        cshtml = "razor",
    },
})

require("roslyn").setup()

require("easy-dotnet").setup()
