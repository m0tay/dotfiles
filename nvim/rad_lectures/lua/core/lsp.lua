local configurations = {}

for _, v in ipairs(vim.api.nvim_get_runtime_file("lsp/*", true)) do
  local name = vim.fn.fnamemodify(v, ":t:r")
  configurations[name] = true
end

vim.lsp.enable(vim.tbl_keys(configurations))

vim.diagnostic.config({
    -- virtual_lines = { current_line = true },
    virtual_text = { current_line = true },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN]  = "󰀪 ",
            [vim.diagnostic.severity.INFO]  = "󰋽 ",
            [vim.diagnostic.severity.HINT]  = "󰌶 ",
        },
        numhl = {
            [vim.diagnostic.severity.ERROR] = "ErrorMsg",
            [vim.diagnostic.severity.WARN]  = "WarningMsg",
        },
    },
})
