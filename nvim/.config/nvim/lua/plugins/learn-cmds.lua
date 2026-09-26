vim.api.nvim_create_user_command(
    'LCmd',
    function(opts)
        print(vim.inspect(opts))
    end,
    {
        nargs = '*', -- You need this if you plan on passing arguments to test it
        desc = 'Dump opts table'
    }
)

