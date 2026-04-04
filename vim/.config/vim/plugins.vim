vim9script

var plugin_dir = expand('~/.config/vim/plugged')

def Ensure(repo: string)
  var name = split(repo, '/')[len(split(repo, '/')) - 1]
  var path = plugin_dir .. '/' .. name

  if !isdirectory(path)
    if !isdirectory(plugin_dir)
      mkdir(plugin_dir, 'p')
    endif
    system('git clone --depth=1 https://github.com/' .. repo .. ' ' .. shellescape(path))
  endif

  execute('set runtimepath+=' .. fnameescape(path))
enddef

Ensure('rose-pine/vim')
Ensure('junegunn/fzf')
Ensure('junegunn/fzf.vim')
Ensure('itchyny/lightline.vim')
Ensure('yegappan/lsp')

