function fish_prompt
  set_color red
  echo -n '['
  set_color magenta
  echo -n (prompt_pwd)
  set_color red
  echo -n '] '
  set -l git_info (fish_git_prompt "on %s ")  
  if test -n "$git_info"  
    set_color white  
    echo -n $git_info  
  end     
  set_color cyan
  echo -n 'λ '
  set_color normal
end
