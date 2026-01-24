---@brief
---
--- https://github.com/haskell/haskell-language-server
---
--- Installation instructions can be found [here](https://github.com/haskell/haskell-language-server#installation).
---
--- Workspace-specific settings can be provided in a `hls.json` file at the root of the workspace.
--- Alternatively, configuration may be passed as a "settings" object to `require('lspconfig').hls.setup({})`:
---
--- ```lua
--- require('lspconfig').hls.setup({
---     settings = {
---       haskell = {
---         formattingProvider = "ormolu";
---         checkProject = true;
---       }
---     }
--- })
--- ```

local root_pattern = vim.fs.root

---@type vim.lsp.Config
return {
  cmd = { "haskell-language-server-wrapper", "--lsp" },
  filetypes = { "haskell", "lhaskell" },
  root_dir = root_pattern(vim.fn.expand('%:p:h'), {"*.cabal", "stack.yaml", "cabal.project", "package.yaml", "hie.yaml"}),
  settings = {
    haskell = {
      formattingProvider = "ormolu",
      checkProject = true,
    }
  }
}
