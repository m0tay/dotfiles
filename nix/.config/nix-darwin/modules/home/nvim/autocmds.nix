{...}: {
  programs.nixvim = {
    autoCmd = [
      {
        event = "LspAttach";
        callback.__raw = ''
          function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client then
              pcall(vim.lsp.completion.enable, false, client.id, args.buf, { autotrigger = false })
            end
          end
        '';
        desc = "disable native lsp autotrigger on keystroke";
      }
      {
        event = "FileType";
        pattern = "help";
        command = "wincmd L";
        desc = "open help in vertical split";
      }
      {
        event = "TextYankPost";
        callback.__raw = "function() vim.highlight.on_yank() end";
        desc = "briefly highlight yanked text";
      }
      {
        event = "BufReadPost";
        callback.__raw = ''
          function(args)
            local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
            local line_count = vim.api.nvim_buf_line_count(args.buf)
            if mark[1] > 0 and mark[1] <= line_count then
              vim.api.nvim_win_set_cursor(0, mark)
              vim.schedule(function() vim.cmd("normal! zz") end)
            end
          end
        '';
        desc = "restore cursor to file position in previous editing session";
      }
      {
        event = "VimResized";
        command = "wincmd =";
        desc = "auto resize splits when window is resized";
      }
      {
        event = "FileType";
        callback.__raw = ''
          function()
            vim.opt_local.formatoptions:remove({ "c", "r", "o" })
          end
        '';
        desc = "no auto continue comments on new line";
      }
      {
        event = "BufRead";
        pattern = [
          ".env"
          ".env.*"
        ];
        callback.__raw = ''
          function()
            vim.bo.filetype = "dosini"
          end
        '';
        desc = "syntax highlighting for dotenv files";
      }
      {
        event = [
          "WinEnter"
          "BufEnter"
        ];
        callback.__raw = ''
          function()
            vim.opt_local.cursorline = true
          end
        '';
        desc = "show cursorline only in active window";
      }
    ];

    extraConfigLua = ''
      -- Custom helper commands
      vim.api.nvim_create_user_command('TMan', function(opts)
        vim.cmd('tab Man ' .. opts.args)
      end, {
        nargs = '+',
        complete = function(arg_lead, cmdline, cursor_pos)
          return require('man').man_complete(arg_lead, cmdline, cursor_pos)
        end,
        desc = 'Open man page in new tab'
      })

      vim.api.nvim_create_user_command('THelp', function(opts)
        vim.cmd('tab help ' .. opts.args)
      end, { nargs = '?', complete = 'help', desc = 'Open help page in new tab' })

      vim.api.nvim_create_user_command('Help', function(opts)
        local topic = opts.args == "" and "help" or opts.args
        local url = "https://neovim.io/doc/user/" .. topic .. ".html"
        local ok, err = pcall(vim.ui.open, url)
        if not ok then
          vim.notify("Failed to open browser: " .. tostring(err), vim.log.levels.ERROR)
        end
      end, { nargs = "?", complete = "help", desc = "Open Neovim web documentation for a specific topic" })

      vim.api.nvim_create_user_command('LCmd', function(opts)
        print(vim.inspect(opts))
      end, { nargs = '*', desc = 'Dump opts table' })
    '';
  };
}
