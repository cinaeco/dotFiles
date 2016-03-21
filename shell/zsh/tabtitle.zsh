# Set tab title to hostname
print -Pn "\e]1;`hostname | cut -d. -f1`\a"
