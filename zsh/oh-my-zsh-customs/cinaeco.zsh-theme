## Override the default `git_prompt_info` function
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

## Using precmd instead of having a multiline prompt reduces the number of 
## `%{` and `%}` escape sequences needed. Actions like changing mode in vi-mode
## and using tab completion need the escapes to know the right number of printed
## characters in the prompt (and mode indicator) variable, otherwise, they
## offset (backwards or forwards) by the wrong number of characters.
function precmd() {
  print -rP '
$fg[cyan][%n@%m]  $fg[yellow]%3~  $(git_prompt_info)'
}

PROMPT='%{$fg[magenta]%}→ %{$reset_color%}'
RPROMPT='$(vi_mode_prompt_info) %T %{$fg[white]%}%h%{$reset_color%}'

MODE_INDICATOR="%{$fg[green]%}vi-mode%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="[git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="]$reset_color"
ZSH_THEME_GIT_PROMPT_CLEAN="$fg[green]"
ZSH_THEME_GIT_PROMPT_DIRTY="$fg[red]+"
