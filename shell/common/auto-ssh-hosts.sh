# Automagic ssh to known hosts.
# Configure usernames for hosts in .ssh/config
auto_ssh_hosts() {
  local line host
  IFS=$'\n\t'
  for line in $(grep "^[a-zA-Z]" ~/.ssh/known_hosts); do
    host=${line%%[, ]*}
    alias $host="ssh $host"
  done
  unset IFS
}

if [[ -f ~/.ssh/known_hosts ]]; then
  auto_ssh_hosts
fi

# Hosts file
alias hosts='sudo vim /etc/hosts'
