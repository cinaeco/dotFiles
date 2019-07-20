# Default Flags for `less`
# e = quit at end of file
# i = searches ignore case, unless there are upper case characters
# r = display raw control characters (Ctrl-A is ^A)
# R = display raw ANSI colour escape sequences `^[[...m`
# M = verbose `less` prompt
# X = disable termcap init/deinit strings - sometimes these clear the screen
export LESS='-iRMX'

# Use `lesspipe` to display binary file contents.
[[ -n $(command -v lesspipe) ]] && eval "$(lesspipe)"
