local snippets = {
	be = [[\begin{${1|item,enumerate,tabular,minted|}}
	${2:-- body}
\end{$1}]],
	it = [[\textit{$1}]],
	bo = [[\textbf{$1}]],
	nd = [[\documentclass{${1|article,book,report|}}

\begin{document}
	${2:% komm süsser Tod}
\end{document}]],
 	se = [[\section*{$1}
${2:% paragraph goes her}]],
 	ss = [[\subsection*{$1}
${2:% paragraph goes her}]],
}

for key, body in pairs(snippets) do
	vim.keymap.set('i', ';' .. key, function()
		vim.snippet.expand(body)
	end, { buffer = true })
end

vim.lsp.enable 'texlab'
