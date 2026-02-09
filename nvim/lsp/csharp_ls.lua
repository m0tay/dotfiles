---@brief
---
--- https://github.com/razzmatazz/csharp-language-server
---
--- Language Server for C#.
---
---
--- csharp-ls upstream config uses `lspconfig.util.root_pattern`; here we
--- replicate the same behavior using Neovim's built-in `vim.fs` helpers so
--- no external plugin is required.

---@type vim.lsp.Config
return {
	cmd = { '/Users/douglaslobo/.dotnet/tools/csharp-ls' },
	root_dir = function(bufnr, on_dir)
		local root = vim.fs.root(bufnr, function(name, _)
			return name:match('%.sln[x]?$') ~= nil or name:match('%.csproj$') ~= nil
		end)
		if not root then
			root = vim.fs.root(bufnr, { '.git' })
		end
		if root then
			on_dir(root)
		end
	end,
  filetypes = { 'cs' },
  init_options = {
    AutomaticWorkspaceInit = true,
  },
}
