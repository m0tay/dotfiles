{...}: {
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
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

      neogit = {
        enable = true;
      };

      diffview = {
        enable = true;
      };

      lazydev = {
        enable = true;
      };

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
            "<C-n>" = "cmp.mapping(function(fallback) if cmp.visible() then cmp.select_next_item() else fallback() end end, { 'i', 's' })";
            "<C-p>" = "cmp.mapping(function(fallback) if cmp.visible() then cmp.select_prev_item() else fallback() end end, { 'i', 's' })";
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<Tab>" = "cmp.mapping(function(fallback) if vim.snippet.active({ direction = 1 }) then vim.snippet.jump(1) else fallback() end end, { 'i', 's' })";
            "<S-Tab>" = "cmp.mapping(function(fallback) if vim.snippet.active({ direction = -1 }) then vim.snippet.jump(-1) else fallback() end end, { 'i', 's' })";
          };
        };
      };

      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          gopls.enable = true;
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          tinymist.enable = true;
        };
      };

      typst-preview = {
        enable = true;
      };

      roslyn = {
        enable = true;
      };

      easy-dotnet = {
        enable = true;
      };

      java = {
        enable = true;
        settings = {
          java_test.enable = false;
          java_debug_adapter.enable = false;
        };
      };

      spring-boot = {
        enable = true;
      };
    };

    extraConfigLua = ''
      -- CMP manual trigger keymap
      vim.keymap.set('i', '<C-x><C-o>', function()
        require('cmp').complete()
      end, { noremap = true, silent = true })

      -- Filetypes for C# razor/cshtml
      vim.filetype.add({
        extension = {
          razor = "razor",
          cshtml = "razor",
        },
      })
    '';
  };
}
