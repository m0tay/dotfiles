vim.pack.add {
    "https://github.com/JavaHello/spring-boot.nvim.git",
    "https://github.com/nvim-java/nvim-java.git",
}

require("java").setup({
    java_test = {
        enable = false,
    },
    java_debug_adapter = {
        enable = false,
    },
})
