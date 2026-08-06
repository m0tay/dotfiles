vim.pack.add {
    "https://github.com/williamboman/mason.nvim.git",
    "https://github.com/williamboman/mason-lspconfig.nvim.git",
}

require("mason").setup({
    registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
    },
})
