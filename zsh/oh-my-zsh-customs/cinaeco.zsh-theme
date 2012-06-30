PROMPT='
$fg[yellow][%n@%m] $reset_color%T $fg[blue]%3~$reset_color $(git_prompt_info)$reset_color
→ '

MODE_INDICATOR="$fg[red]-- COMMAND MODE --$reset_color"
ZSH_THEME_GIT_PROMPT_PREFIX="$fg[magenta]==> $fg[cyan]git( "
ZSH_THEME_GIT_PROMPT_SUFFIX=" $fg[cyan])"
ZSH_THEME_GIT_PROMPT_CLEAN=" $fg[green]✔$fg[cyan] is clean"
ZSH_THEME_GIT_PROMPT_DIRTY=" $fg[red]✗$fg[cyan] has changes"
