{pkgs, config, ...}: {
  programs.nixvim = {
    colorschemes.vague = {
      enable = true;
      settings = {
        transparent = true;
      };
    };

    plugins = {
      web-devicons.enable = true;

      lualine = {
        enable = true;
        settings = {
          options = {
            theme = "vague";
            globalstatus = true;
            icons_enabled = true;
            component_separators = {
              left = "";
              right = "";
            };
            section_separators = {
              left = "";
              right = "";
            };
          };
          sections = {
            lualine_a = ["mode"];
            lualine_b = [
              "branch"
              "diff"
              "diagnostics"
            ];
            lualine_c = ["filename"];
            lualine_x = ["filetype"];
            lualine_y = ["progress"];
            lualine_z = ["location"];
          };
        };
      };

      treesitter = {
        enable = true;
        grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

      neogit.enable = true;
      diffview.enable = true;
      lazydev.enable = true;

      cmp-nvim-lsp.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;

      cmp = {
        enable = true;
        settings = {
          completion.autocomplete = false;
          snippet.expand = "function(args) vim.snippet.expand(args.body) end";
          sources = [
            {
              name = "lazydev";
              group_index = 0;
            }
            {name = "nvim_lsp";}
            {name = "buffer";}
            {name = "path";}
          ];
          mapping = {
            "<C-n>" = "cmp.mapping.select_next_item()";
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
            "<CR>" = "cmp.mapping.confirm({ select = false })";
          };
        };
      };

      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;

          nixd = {
            enable = true;
            settings = {
              nixpkgs = {
                expr = "import (builtins.getFlake \"${config.home.homeDirectory}/.dotfiles/nix\").inputs.nixpkgs { }";
              };
              options = {
                darwin = {
                  expr = ''(builtins.getFlake "${config.home.homeDirectory}/.dotfiles/nix").darwinConfigurations."Douglass-MacBook-Pro".options'';
                };
                home_manager = {
                  expr = ''(builtins.getFlake "${config.home.homeDirectory}/.dotfiles/nix").darwinConfigurations."Douglass-MacBook-Pro".options.home-manager.users.value.douglaslobo'';
                };
              };
            };
          };

          gopls.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          tinymist.enable = true;
          pyright.enable = true;
          ruff.enable = true;
          lua_ls.enable = true;
          bashls = {
            enable = true;
            filetypes = [
              "sh"
              "bash"
              "zsh"
            ];
          };
          racket_langserver = {
            enable = true;
            package = null;
          };
        };
      };

      typst-preview.enable = true;
    };
  };
}
