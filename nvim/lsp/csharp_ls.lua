---@type vim.lsp.Config
return {
  cmd = { 'csharp-ls' },
  filetypes = { 'cs' },
  -- Explicit root_dir instead of broken glob markers
  root_dir = function(bufnr, on_dir)
    -- 1) Prefer a git repo root
    local root = vim.fs.root(bufnr, { '.git' })
    if not root then
      -- 2) Fallback to the directory of the file
      local name = vim.api.nvim_buf_get_name(bufnr)
      if name ~= '' then
        root = vim.fs.dirname(name)
      end
    end
    on_dir(root)
  end,
  settings = {},
}
