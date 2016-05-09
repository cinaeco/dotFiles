# Command Prompt
#
#     [host]  directory  gitinfo  jobinfo
#     user -
#
PROMPT_COMMAND='PS1="
${FG[6]}[\h]  ${FG[3]}$(shortcwd)$(__gitp "  %s")$(getajob)
${FG[5]}\u - $cReset";'$PROMPT_COMMAND

# Display suspended/backgrounded job count, if any.
function getajob() {
  local jobcount=$(jobs | wc -l)
  [[ $jobcount -ne 0 ]] && printf "  ${FG[63]}[jobs]: ${FG[1]}\j" || printf ''
}

# Display up to 3 segments of the current working directory.
function shortcwd() {
  local fld='[^/]*'
  folder=${PWD/$HOME/"~"}
  folder=$(echo $folder | sed 's|.*/\('$fld'/'$fld'/'$fld'\)|\1|')
  printf "$folder"
}
