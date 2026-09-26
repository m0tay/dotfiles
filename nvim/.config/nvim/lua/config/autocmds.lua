-- NOTE: Native LSP completion is disabled because nvim-cmp handles all
-- completion. Enabling both causes conflicts (e.g. C-n/C-p breaks in Java).
-- vim.api.nvim_create_autocmd('LspAttach', {
--     group = vim.api.nvim_create_augroup('my.lsp', {}),
--     callback = function(args)
--         local client = vim.lsp.get_client_by_id(args.data.client_id)
--         if client and client.server_capabilities.completionProvider then
--             vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
--         end
--     end,
-- })

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

vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function(args)
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line_count = vim.api.nvim_buf_line_count(args.buf)
        if mark[1] > 0 and mark[1] <= line_count then
            vim.api.nvim_win_set_cursor(0, mark)
            -- defer centering slightly so it's applied after render
            vim.schedule(function()
                vim.cmd("normal! zz")
            end)
        end
    end,
    desc = "restore cursor to file position in previous editing session"
})

vim.api.nvim_create_autocmd("VimResized", {
    command = "wincmd =",
    desc = "auto resize splits when the terminal's window is resized"
})

vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("no_auto_comment", {}),
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
    desc = "no auto continue comments on new line"
})

vim.api.nvim_create_autocmd("BufRead", {
    group = vim.api.nvim_create_augroup("dotenv_ft", { clear = true }),
    pattern = { ".env", ".env.*" },
    callback = function()
        vim.bo.filetype = "dosini"
    end,
    desc = "syntax highlighting for dotenv files"
})

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    group = vim.api.nvim_create_augroup("active_cursorline", { clear = true }),
    callback = function()
        vim.opt_local.cursorline = true
    end,
    desc = "show cursorline only in active window enable"
})

vim.api.nvim_create_user_command("PackClean", function()
    local inactive = vim.iter(vim.pack.get())
        :filter(function(x)
            return not x.active
        end)
        :map(function(x)
            return x.spec.name
        end)
        :totable()
    if #inactive == 0 then
        vim.notify("No inactive plugins to remove", vim.log.levels.INFO)
        return
    end
    vim.pack.del(inactive)
    vim.notify("Removed: " .. table.concat(inactive, ", "), vim.log.levels.INFO)
end, { desc = "Remove plugins not in vim.pack.add() specs" })
