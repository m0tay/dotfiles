vim.api.nvim_create_user_command(
    'TMan',
    function(opts)
        vim.cmd('tab Man ' .. opts.args)
    end,
    {
        nargs = '+',
        complete = function(arg_lead, cmdline, cursor_pos)
            return require('man').man_complete(arg_lead, cmdline, cursor_pos)
        end,
        desc = 'Open man page in new tab'
    }
)

vim.api.nvim_create_user_command(
    'THelp',
    function(opts)
        vim.cmd('tab help ' .. opts.args)
    end,
    {
        nargs = '?',
        complete = 'help',
        desc = 'Open help page in new tab'
    }
)

vim.api.nvim_create_user_command(
    'Help',
    function(opts)
        local topic = opts.args == '' and 'help' or opts.args
        local url = 'https://neovim.io/doc/user/' .. topic .. '.html'
        local ok, err = pcall(vim.ui.open, url)
        if not ok then
            vim.notify('Failed to open browser: ' .. tostring(err), vim.log.levels.ERROR)
        end
    end,
    {
        nargs = '?',
        complete = 'help',
        desc = 'Open Neovim web documentation for a specific topic'
    }
)
