---@brief
---
--- https://github.com/phpactor/phpactor
---
--- Installation: Latest PHAR version (2025.10.17.0)

---@type vim.lsp.Config
return {
  -- The command to start phpactor's language server
  -- Using latest PHAR version with full PHP 8.x support
  cmd = { '/Users/douglaslobo/.local/bin/phpactor-latest', 'language-server' },

  -- Which file types should trigger this LSP
  filetypes = { 'php' },

  -- Files/folders that indicate the project root
  root_markers = {
    'composer.json',
    '.git',
    '.phpactor.json',
    '.phpactor.yml'
  },
}
