# Command Prompt
#
#     [host]  directory  gitinfo  jobinfo
#     user -                                           vimode time histeventno
#
setopt PROMPT_SUBST
PROMPT='
$FG[6][%m]  $FG[3]%3~$(__gitp "  %s")%(1j.  $FG[63][jobs]: $FG[1]%j.)
$FG[5]%n - $cReset'
RPROMPT='$(vimode) $cReset%T $FG[7]%h$cReset'
