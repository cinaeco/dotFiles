## Set tab title to hostname
print -Pn "\e]1;`hostname | cut -d. -f1`\a"
## multi line prompt
PROMPT='
%{$fg[cyan]%}[%m]  %{$fg[yellow]%}%3~  $(git_prompt_info)
%{$fg[magenta]%}%n → %{$reset_color%}'
RPROMPT='$(vi_mode_prompt_info) %{$reset_color%}%T %{$fg[white]%}%h%{$reset_color%}'

MODE_INDICATOR="%{$fg[green]%}vi-mode%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}"
ZSH_THEME_GIT_STATUS_MAX=20
ZSH_THEME_GIT_PROMPT_UNMERGED="U"
ZSH_THEME_GIT_PROMPT_UNTRACKED="?"
ZSH_THEME_GIT_TREE_MODIFIED="+"
ZSH_THEME_GIT_TREE_DELETED="x"
ZSH_THEME_GIT_INDEX_MODIFIED="+"
ZSH_THEME_GIT_INDEX_ADDED="±"
ZSH_THEME_GIT_INDEX_DELETED="x"
ZSH_THEME_GIT_INDEX_RENAMED="r"
ZSH_THEME_GIT_INDEX_COPIED="c"

##############################
# FUNCTIONS
##############################

## Override the default `git_prompt_info` function
## Git commit id and mode code taken from:
## https://github.com/benhoskings/dot-files/blob/master/files/bin/git_cwd_info
function git_prompt_info() {
  GIT_REPO_PATH=$(git rev-parse --git-dir 2>/dev/null)
  [[ $GIT_REPO_PATH == "" ]] && return

  GIT_COMMIT_ID=`git rev-parse --short HEAD 2>/dev/null`

  GIT_MODE=""
  if [[ -e "$GIT_REPO_PATH/BISECT_LOG" ]]; then
    GIT_MODE=" BISECT"
  elif [[ -e "$GIT_REPO_PATH/MERGE_HEAD" ]]; then
    GIT_MODE=" MERGE"
  elif [[ -e "$GIT_REPO_PATH/rebase" || -e "$GIT_REPO_PATH/rebase-apply" || -e "$GIT_REPO_PATH/rebase-merge" || -e "$GIT_REPO_PATH/../.dotest" ]]; then
    GIT_MODE=" REBASE"
  fi

  GIT_BRANCH=$(current_branch)
  [[ $GIT_BRANCH == '' ]] && GIT_BRANCH="%{$fg[red]%}no branch$(parse_git_dirty)"
  echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX$(current_repository):$GIT_BRANCH:$GIT_COMMIT_ID$ZSH_THEME_GIT_PROMPT_SUFFIX%{$fg[magenta]%}$GIT_MODE $(git_prompt_status)"
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
  echo $INDEX | while IFS= read LINE; do
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
## Cope with non-ssh repos by not relying on ':'. Instead, we look for text
## between a '/' and '.git'.
##
## We don't need to test if HEAD is a symbolic ref - that gets controlled in
## git_prompt_info(). Unlike `current_branch` there are no oh-my-zsh shortcuts
## that will be broken if we don't test for this.
function current_repository() {
  echo $(git remote -v | head -1 | sed 's/.*\/\([^/]*\)\.git.*/\1/')
}
