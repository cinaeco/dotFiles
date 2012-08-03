## Set tab title to hostname
print -Pn "\e]1;`hostname | cut -d. -f1`\a"
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
ZSH_THEME_GIT_STATUS_MAX=20
ZSH_THEME_GIT_PROMPT_UNMERGED="U"
ZSH_THEME_GIT_PROMPT_UNTRACKED="?"
ZSH_THEME_GIT_TREE_MODIFIED="+"
ZSH_THEME_GIT_TREE_DELETED="x"
ZSH_THEME_GIT_INDEX_MODIFIED="+"
ZSH_THEME_GIT_INDEX_ADDED="+"
ZSH_THEME_GIT_INDEX_DELETED="x"
ZSH_THEME_GIT_INDEX_RENAMED="r"
ZSH_THEME_GIT_INDEX_COPIED="c"

##############################
# FUNCTIONS
##############################

## Override the default `git_prompt_info` function
## We decide if we show nothing, status with no branch (like in submodules) or
## with a branch using regex comparisons.
## Is there a better way than relying on error output?
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2>&1)
  [[ $ref =~ "Not a git" ]] && return
  [[ $ref =~ "not a symbolic" ]] && echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_repository):%{$fg[red]%}no branch$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX $(git_prompt_status)" && return
  echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_repository):$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX $(git_prompt_status)"
}

## Override the default `git_prompt_status` function
## Preferably only use with multiline prompts
## Try to print a each change instead of just indicating if each type exists.
## This gives a better visual sense of how much has changed
## Status is computed from the short version of git status that lists out
##     xy filename1
##     xy filename2
## where x and y are statuses such as A (added), M (modified). Details in the
## git-status manpage.
## TODO Is this as fast as it gets? Maybe. The speed of this script appears to
## be limited by the speed of --porcelain or -s in any given repo.
git_prompt_status() {
  INDEX=$(git status --porcelain 2> /dev/null)
  [[ -z $INDEX ]] && return
  X_SET=""
  Y_SET=""
  UN_SET=""
  echo $INDEX | while read LINE; do
    X=$LINE[1]
    Y=$LINE[2]
    [[ $X$Y == '??' ]] && UN_SET="$UN_SET$ZSH_THEME_GIT_PROMPT_UNTRACKED" && continue
    [[ $X == 'U' ]] || [[ $Y == 'U' ]] && UN_SET="$UN_SET$ZSH_THEME_GIT_PROMPT_UNMERGED" && continue
    [[ $X$Y == 'DD' ]] || [[ $X$Y == 'AA' ]] && UN_SET="$UN_SET$ZSH_THEME_GIT_PROMPT_UNMERGED" && continue
    [[ $Y == 'M' ]] && Y_SET="$Y_SET$ZSH_THEME_GIT_TREE_MODIFIED"
    [[ $Y == 'D' ]] && Y_SET="$Y_SET$ZSH_THEME_GIT_TREE_DELETED"
    [[ $X == 'M' ]] && X_SET="$X_SET$ZSH_THEME_GIT_INDEX_MODIFIED" && continue
    [[ $X == 'A' ]] && X_SET="$X_SET$ZSH_THEME_GIT_INDEX_ADDED" && continue
    [[ $X == 'D' ]] && X_SET="$X_SET$ZSH_THEME_GIT_INDEX_DELETED" && continue
    [[ $X == 'R' ]] && X_SET="$X_SET$ZSH_THEME_GIT_INDEX_RENAMED" && continue
    [[ $X == 'C' ]] && X_SET="$X_SET$ZSH_THEME_GIT_INDEX_COPIED" && continue
  done
  STATUS="%{$FG[070]%}$X_SET%{$FG[124]%}$Y_SET%{$FG[220]%}$UN_SET"
  echo $STATUS
}

## Override the default `current_repository` function
## Cope with non-ssh repos by not relying on ':'. Instead, we look for the name
## suffixed with .git
##
## We don't need to test if HEAD is a symbolic ref - that gets controlled in
## git_prompt_info(). Unlike `current_branch` there are no oh-my-zsh shortcuts
## that will be broken if we don't test for this.
## Is there another way? 4 pipelines seems excessive
function current_repository() {
  echo $(git remote -v | head -1 | grep -o '[^/]*\.git' | sed 's/\.git//')
}
