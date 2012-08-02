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
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$FG[160]%}u"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$FG[244]%}?"
ZSH_THEME_GIT_INDEX_MODIFIED="%{$FG[076]%}+"
ZSH_THEME_GIT_INDEX_ADDED="%{$FG[076]%}+"
ZSH_THEME_GIT_INDEX_DELETED="%{$FG[076]%}x"
ZSH_THEME_GIT_INDEX_RENAMED="%{$FG[076]%}>"
ZSH_THEME_GIT_INDEX_COPIED="%{$FG[076]%}c"
ZSH_THEME_GIT_TREE_MODIFIED="%{$FG[124]%}+"
ZSH_THEME_GIT_TREE_DELETED="%{$FG[124]%}x"


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
## Status is computed from the short version of git status that lists out
##     xy filename1
##     xy filename2
## where x and y are statuses such as A (added), M (modified). Details in the
## git-status manpage
git_prompt_status() {
  INDEX=$(git status -s 2> /dev/null)
  X_SET=""
  Y_SET=""
  UN_SET=""
  echo $INDEX | while IFS= read LINE; do
    X=$LINE[1]
    Y=$LINE[2]
    [[ $X$Y == '??' ]] && UN_SET="$UN_SET$ZSH_THEME_GIT_PROMPT_UNTRACKED" && continue
    [[ $X$Y == 'UU' ]] && UN_SET="$UN_SET$ZSH_THEME_GIT_PROMPT_UNMERGED" && continue
    X_SET="$X_SET$X"
    Y_SET="$Y_SET$Y"
  done
  X_SET=$(sed "s/[ ]//g" <<< $X_SET)
  X_SET=$(sed "s/M/$ZSH_THEME_GIT_INDEX_MODIFIED/g" <<< $X_SET)
  X_SET=$(sed "s/A/$ZSH_THEME_GIT_INDEX_ADDED/g" <<< $X_SET)
  X_SET=$(sed "s/D/$ZSH_THEME_GIT_INDEX_DELETED/g" <<< $X_SET)
  X_SET=$(sed "s/R/$ZSH_THEME_GIT_INDEX_RENAMED/g" <<< $X_SET)
  X_SET=$(sed "s/C/$ZSH_THEME_GIT_INDEX_COPIED/g" <<< $X_SET)
  Y_SET=$(sed "s/[ ]//g" <<< $Y_SET)
  Y_SET=$(sed "s/M/$ZSH_THEME_GIT_TREE_MODIFIED/g" <<< $Y_SET)
  Y_SET=$(sed "s/D/$ZSH_THEME_GIT_TREE_DELETED/g" <<< $Y_SET)
  STATUS="$X_SET$Y_SET$UN_SET"
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
  echo $(git remote -v | head -1 | grep -o '[^/]*\.git' | sed 's/\.git//')
}
