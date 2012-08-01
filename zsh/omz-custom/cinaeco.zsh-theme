## Set tab title to hostname
print -Pn "\e]1;`hostname | cut -d. -f1`\a"

## single line prompt
#PROMPT='%{$fg[cyan]%}[%n@%m] %{$fg[yellow]%}%3~ %{$fg[magenta]%}→ %{$reset_color%}'
#RPROMPT='$(vi_mode_prompt_info) $(git_prompt_info) %{$reset_color%}%T %{$fg[white]%}%h%{$reset_color%}'

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
#
# UPDATE2: have found a modification to the vi-mode plugin that allows for
# better catering for multiline prompts, without overwriting history lines.
# Refer to custom directory for more details
#function precmd() {}

## multi line prompt
PROMPT='
%{$fg[cyan]%}[%m]  %{$fg[yellow]%}%3~  $(git_prompt_info) 
%{$fg[magenta]%}%n → %{$reset_color%}'
RPROMPT='$(vi_mode_prompt_info) %{$reset_color%}%T %{$fg[white]%}%h%{$reset_color%}'

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


##############################
# FUNCTIONS
##############################

## Override the default `git_prompt_info` function
## We decide if we show nothing, status with no branch (like in submodules) or
## with a branch using regex comparisons. Is there a better way?
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2>&1)
  [[ $ref =~ "Not a git" ]] && return
  [[ $ref =~ "not a symbolic" ]] && echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_repository):%{$fg[red]%}no branch$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX $(git_prompt_status)" && return
  echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_repository):$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX $(git_prompt_status)"
}

## Override the default `git_prompt_status` function
## This one will try to print a symbol for each change listed in git status.
## The old version only listed if each type existed or not.
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

## Override the default `current_repository` function
## We don't need to test if HEAD is a symbolic ref - that gets controlled in
## git_prompt_info(). Unlike `current_branch` there are no oh-my-zsh shortcuts
## that will be broken if we don't test for this.
##
## also, the built-in function cannot cope with non-ssh repos because it relies
## on there being a ':' before the repo name
function current_repository() {
  echo $(git remote -v | head -1 | grep -o '[^/]*\.git' | sed 's/.git//')
}
