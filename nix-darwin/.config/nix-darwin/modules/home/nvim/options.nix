{...}: {
  programs.nixvim = {
    globals = {
      mapleader = " ";
      netrw_banner = 0;
      netrw_liststyle = 1;
    };

    opts = {
      number = true;
      relativenumber = true;
      signcolumn = "yes:1";
      confirm = true;
      completeopt = [
        "menuone"
        "noinsert"
        "noselect"
      ];
      textwidth = 100;
      swapfile = false;
      wildoptions = ["fuzzy"];
      path = ["**"];
      smoothscroll = true;
      termguicolors = true;
      winborder = "rounded";
      cursorline = true;
      wrap = true;
      ignorecase = true;
      expandtab = true;
      shiftwidth = 4;
      tabstop = 4;
      scrolloff = 8;
      sidescrolloff = 16;
      smartindent = true;
      splitright = true;
      splitbelow = true;
      undofile = true;
      foldenable = true;
      foldlevel = 99;
      foldmethod = "marker";
      cmdheight = 0;
    };

    diagnostic = {
      settings = {
        virtual_text = true;
      };
    };
  };
}
