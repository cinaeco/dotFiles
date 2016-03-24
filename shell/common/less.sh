# Default Flags for `less`
# e = quit at end of file
# i = searches ignore case, unless there are upper case characters
# r = display raw control characters (Ctrl-A is ^A)
# M = verbose `less` prompt
# X = disable termcap init/deinit strings - sometimes these clear the screen.
export LESS='-iRMX'

if srchilitepath=$(command -v src-hilite-lesspipe.sh); then
  export LESSOPEN="| $srchilitepath %s"
fi
