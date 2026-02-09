---@brief
---
--- https://github.com/haskell/haskell-language-server
---
--- Pure Neovim 0.12 configuration (no nvim-lspconfig).
---

local root_pattern = vim.fs.root

---@type vim.lsp.Config
return {
  cmd = { "haskell-language-server-wrapper", "--lsp" },
  filetypes = { "haskell", "lhaskell" },
  root_dir = root_pattern(vim.fn.expand("%:p:h"), {
    "*.cabal",
    "stack.yaml",
    "cabal.project",
    "package.yaml",
    "hie.yaml",
  }),
  settings = {
    haskell = {
      formattingProvider = "ormolu",
      checkProject = true,
    },
  },
}
