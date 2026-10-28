{...}: {
  programs.nixvim = {
    autoCmd = [
      {
        event = "TextYankPost";
        command = "silent! lua vim.highlight.on_yank()";
        desc = "highlight yanked text";
      }
      {
        event = "VimResized";
        command = "wincmd =";
        desc = "auto resize splits when window is resized";
      }
      {
        event = "FileType";
        pattern = "help";
        command = "wincmd L";
        desc = "open help in vertical split";
      }
    ];
  };
}
