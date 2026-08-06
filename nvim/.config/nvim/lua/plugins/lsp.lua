vim.pack.add { "https://github.com/neovim/nvim-lspconfig.git" }

require("mason-lspconfig").setup({
    handlers = {
        function(server_name)
            if server_name ~= "roslyn" then
                require("lspconfig")[server_name].setup({})
            end
        end,
    },
})

require("plugins.setup_java")
require("plugins.setup_csharp")
