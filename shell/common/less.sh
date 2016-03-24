if srchilitepath=$(command -v src-hilite-lesspipe.sh); then
  export LESSOPEN="| $srchilitepath %s"
fi
