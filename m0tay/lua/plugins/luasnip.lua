return {
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = (not vim.g.vscode) and "make install_jsregexp" or nil,
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		config = function()
			require("luasnip").config.set_config({
				history = true,
				updateevents = "TextChanged,TextChangedI",
			})

			require("luasnip.loaders.from_vscode").lazy_load()

			-- Snippet docs (opcional)
			local ft_extend = require("luasnip").filetype_extend
			ft_extend("typescript", { "tsdoc" })
			ft_extend("javascript", { "jsdoc" })
			ft_extend("lua", { "luadoc" })
			ft_extend("python", { "pydoc" })
			ft_extend("rust", { "rustdoc" })
			ft_extend("cs", { "csharpdoc" })
			ft_extend("java", { "javadoc" })
			ft_extend("c", { "cdoc" })
			ft_extend("cpp", { "cppdoc" })
			ft_extend("php", { "phpdoc" })
			ft_extend("kotlin", { "kdoc" })
			ft_extend("ruby", { "rdoc" })
			ft_extend("sh", { "shelldoc" })
		end,
	},
}
