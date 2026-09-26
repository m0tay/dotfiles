vim.pack.add { "https://github.com/neovim/nvim-lspconfig.git" }
vim.pack.add { "https://github.com/folke/lazydev.nvim.git" }

require("lazydev").setup({})

local capabilities = vim.lsp.protocol.make_client_capabilities()
local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if has_cmp then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

require("mason-lspconfig").setup({
    handlers = {
        function(server_name)
            if server_name ~= "roslyn" then
                require("lspconfig")[server_name].setup({
                    capabilities = capabilities,
                })
            end
        end,
    },
})

require("plugins.setup_java")
require("plugins.setup_csharp")
