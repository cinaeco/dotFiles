PROMPT='
$fg[yellow][%n@%m] $fg_bold[green]%T $fg[cyan]%3~ $fg[blue]$(git_prompt_info)$reset_color
→ $reset_color'

ZSH_THEME_GIT_PROMPT_PREFIX="is a git repo [branch: "
ZSH_THEME_GIT_PROMPT_SUFFIX="]"
ZSH_THEME_GIT_PROMPT_CLEAN=" ✔ is clean"
ZSH_THEME_GIT_PROMPT_DIRTY=" ✗ has changes"

MODE_INDICATOR="-- Command --"
