## Override the default `git_prompt_info` function
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$(git_prompt_status) $(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"

}

## Override the default `git_prompt_status` function
git_prompt_status() {
  INDEX=$(git status -s 2> /dev/null)
  STATUS=""
  echo $INDEX | while IFS= read line; do
    if $(echo "$line" | grep '^?? ' &> /dev/null); then
      STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED"
    fi
    if $(echo "$line" | grep '^A  ' &> /dev/null); then
      STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_ADDED"
    elif $(echo "$line" | grep '^M. ' &> /dev/null); then
      STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_ADDED"
    fi
    if $(echo "$line" | grep '^.M ' &> /dev/null); then
      STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_MODIFIED"
    elif $(echo "$line" | grep '^AM ' &> /dev/null); then
      STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_MODIFIED"
    elif $(echo "$line" | grep '^ T ' &> /dev/null); then
      STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_MODIFIED"
    fi
    if $(echo "$line" | grep '^R  ' &> /dev/null); then
      STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_RENAMED"
    fi
    if $(echo "$line" | grep '^ D ' &> /dev/null); then
      STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_DELETED"
    elif $(echo "$line" | grep '^AD ' &> /dev/null); then
      STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_DELETED"
    fi
    if $(echo "$line" | grep '^UU ' &> /dev/null); then
      STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNMERGED"
    fi
  done
  echo $STATUS
}

# Using precmd instead of having a multiline prompt reduces the number of 
# `%{` and `%}` escape sequences needed. Actions like changing mode in vi-mode
# and using tab completion need the escapes to know the right number of printed
# characters in the prompt or rprompt, otherwise, they will offset displayed
# characters by too many or too few. The precmd text is just printed text.
#
# UPDATE: was told that precmd slows things down. Sure enough, after building a
# new prompt not based on precmd, found that prompt renders half a second faster
# which is much less annoying over prolonged usage. Have moved git status to the
# right prompt. Less exciting, but more functional. Drats.
#function precmd() {}

## Set tab title to hostname
print -Pn "\e]1;`hostname | cut -d. -f1`\a"

PROMPT='%{$fg[cyan]%}[%n@%m] %{$fg[yellow]%}%3~ %{$fg[magenta]%}→ %{$reset_color%}'
RPROMPT='$(vi_mode_prompt_info) $(git_prompt_info) %{$reset_color%}%T %{$fg[white]%}%h%{$reset_color%}'

MODE_INDICATOR="%{$fg[green]%}vi-mode%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="[git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}"


ZSH_THEME_GIT_PROMPT_ADDED="%{$FG[082]%}+%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$FG[160]%}+%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$FG[160]%}x%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$FG[220]%}>%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$FG[082]%}u%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$FG[160]%}?%{$reset_color%}"
