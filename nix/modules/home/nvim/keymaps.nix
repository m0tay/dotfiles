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
        action = "<cmd>lua vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })<CR>";
        options.desc = "toggle diagnostic virtual text";
      }
      {
        mode = "n";
        key = "<leader>cfg";
        action = ":e ~/.dotfiles/nix/modules/home/nvim/options.nix<CR>";
        options.desc = "edit nixvim config";
      }
      # Neovide / macOS clipboard
      {
        mode = "v";
        key = "<D-c>";
        action = "\"+y";
        options.silent = true;
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<D-v>";
        action = "\"+P";
        options.silent = true;
      }
      {
        mode = "i";
        key = "<D-v>";
        action = "<C-r><C-p>+";
        options.silent = true;
      }
      {
        mode = "c";
        key = "<D-v>";
        action = "<C-r>+";
        options.silent = true;
      }
    ];
  };
}
