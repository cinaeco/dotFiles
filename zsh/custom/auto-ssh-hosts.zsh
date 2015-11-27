# Automagic ssh to known hosts.
#
# Works in conjunction with .ssh/config for username@hostname
local _myhosts
_myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )

for host in $_myhosts; do
  alias $host="ssh $host"
done
