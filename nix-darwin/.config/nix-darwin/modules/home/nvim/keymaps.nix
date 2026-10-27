{...}: {
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        key = "<leader><leader>";
        action = ":Ex<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>w";
        action = ":write<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>q";
        action = ":quit<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>Q";
        action = ":qa<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>O";
        action = ":Open .<CR>";
        options.silent = true;
      }
      {
        mode = "n";
        key = "<leader>m";
        action = ":update<CR> :make<CR>";
        options.silent = true;
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>y";
        action = "\"+y";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>p";
        action = "\"+p";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>P";
        action = "\"+P";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>o";
        action = ":update<CR> :source<CR>";
      }
      {
        mode = "n";
        key = "n";
        action = "nzzzv";
        options.desc = "next search result (centered)";
      }
      {
        mode = "n";
        key = "N";
        action = "Nzzzv";
        options.desc = "previous search result (centered)";
      }
      {
        mode = "n";
        key = "<C-d>";
        action = "<C-d>zz";
        options.desc = "half page down (centered)";
      }
      {
        mode = "n";
        key = "<C-u>";
        action = "<C-u>zz";
        options.desc = "half page up (centered)";
      }
      {
        mode = "v";
        key = "<";
        action = "<gv";
        options.desc = "indent left and reselect";
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
        options.desc = "indent right and reselect";
      }
      {
        mode = "n";
        key = "<leader>z";
        action = "1z=";
      }
      {
        mode = "n";
        key = "<leader>g";
        action = "<cmd>Neogit<CR>";
        options.desc = "Open Neogit UI";
      }
      {
        mode = "n";
        key = "<leader>tv";
        action.__raw = ''
          function()
            vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })
          end
        '';
        options.desc = "toggle diagnostic virtual text";
      }
      {
        mode = "n";
        key = "<leader>cfg";
        action.__raw = ''
          function()
            vim.cmd(":e ~/.dotfiles/nix-darwin/.config/nix-darwin/modules/home/nvim/options.nix")
          end
        '';
        options.desc = "edit nixvim config";
      }
    ];

    extraConfigLua = ''
      if vim.g.neovide then
        vim.opt.clipboard = "unnamedplus"
        vim.g.neovide_input_use_logo = 1
        vim.keymap.set('v', '<D-c>', '"+y', { noremap = true, silent = true })
        vim.keymap.set({ 'n', 'v' }, '<D-v>', '"+P', { noremap = true, silent = true })
        vim.keymap.set('i', '<D-v>', '<C-r><C-p>+', { noremap = true, silent = true })
        vim.keymap.set('c', '<D-v>', '<C-r>+', { noremap = true, silent = true })
        vim.keymap.set('t', '<D-v>', '<C-\\><C-n>"+pi', { noremap = true, silent = true })
      end
    '';
  };
}
