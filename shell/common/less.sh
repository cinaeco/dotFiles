# Default Flags for `less`
# e = quit at end of file
# i = searches ignore case, unless there are upper case characters
# r = display raw control characters (Ctrl-A is ^A)
# M = verbose `less` prompt
# X = disable termcap init/deinit strings - sometimes these clear the screen.
export LESS='-iRMX'

# Try to perform syntax highlighting.
# `pygments` has slightly friendlier defaults than `source-highlight`.
if [[ -n $(command -v pygmentize) ]]; then
  export LESSOPEN="| pygmentize -g %s"
elif [[ -n $(command -v src-hilite-lesspipe.sh) ]]; then
  export LESSOPEN="| src-hilite-lesspipe.sh %s"
fi
