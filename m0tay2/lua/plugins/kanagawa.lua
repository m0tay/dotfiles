return {
	"rebelot/kanagawa.nvim",
	config = function()
		require("kanagawa").setup({
			compile = true,
			undercurl = true,
			commentStyle = { italic = true },
			keywordStyle = { italic = true },
		})
		vim.cmd("colorscheme kanagawa-dragon")
	end,
	build = function()
		vim.cmd("KanagawaCompile")
	end,
}
