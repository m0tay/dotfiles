vim9script
nocomplain

var snippets = {
    'be': "\\begin{enumerate}\n\t\n\\end{enumerate}",
    'it': "\\textit{}",
    'bo': "\\textbf{}",
    'nd': "\\documentclass{article}\n\n\\begin{document}\n\t\n\\end{document}",
    'se': "\\section*{}\n% paragraph goes here"
}

# Set up keymaps to expand snippets
for key in keys(snippets)
    var rhs = snippets[key]
    # Remove the trigger characters and insert the snippet
    execute 'inoremap <buffer> ;' .. key .. ' <C-W>' .. rhs
endfor

