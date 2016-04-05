# Functions used in building the command prompt.

# Display suspended/backgrounded job count, if any.
function getajob() {
  local jobcount=$(jobs | wc -l)
  [[ $jobcount -ne 0 ]] && printf "  ${FG[63]}[jobs]: ${FG[1]}\j" || printf ''
}

# Display up to 3 segments of the current working directory.
function shortcwd() {
  local folder=$(pwd) fld='[^/]*'
  folder=${folder/$HOME/"~"}
  folder=$(echo $folder | sed 's|.*/\('$fld'/'$fld'/'$fld'\)|\1|')
  printf "$folder"
}
