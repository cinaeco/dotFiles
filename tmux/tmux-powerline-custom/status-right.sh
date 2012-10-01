#!/usr/bin/env bash
# This script prints a string will be evaluated for text attributes (but not shell commands) by tmux. It consists of a bunch of segments that are simple shell scripts/programs that output the information to show. For each segment the desired foreground and background color can be specified as well as what separator to use. The script the glues together these segments dynamically so that if one script suddenly does not output anything (= nothing should be shown) the separator colors will be nicely handled.

# custom left/right status and segments
custom_dir=$(dirname $0)

# The powerline root directory. TODO any other neater way of getting fullpath?
cd ~/dotfiles/tmux/tmux-powerline
cwd=$(pwd)

# Source global configurations.
source "${custom_dir}/config.sh"

# Source lib functions.
source "${cwd}/lib.sh"

segments_path="${cwd}/${segments_dir}"
custom_segments_path="${custom_dir}/${segments_dir}"

# Mute this statusbar?
mute_status_check "right"

# Segment
# Comment/uncomment the register function call to enable or disable a segment.

declare -A weather
weather+=(["script"]="${custom_segments_path}/weather.sh")
weather+=(["foreground"]="colour255")
weather+=(["background"]="colour37")
weather+=(["separator"]="${separator_left_bold}")
#register_segment "weather"

declare -A date_day
date_day+=(["script"]="${segments_path}/date_day.sh")
date_day+=(["foreground"]="colour136")
date_day+=(["background"]="colour235")
date_day+=(["separator"]="${separator_left_bold}")
register_segment "date_day"

declare -A date_full
date_full+=(["script"]="${segments_path}/date_full.sh")
date_full+=(["foreground"]="colour136")
date_full+=(["background"]="colour235")
date_full+=(["separator"]="${separator_left_thin}")
date_full+=(["separator_fg"]="default")
register_segment "date_full"

declare -A time
time+=(["script"]="${segments_path}/time.sh")
time+=(["foreground"]="colour136")
time+=(["background"]="colour235")
time+=(["separator"]="${separator_left_thin}")
time+=(["separator_fg"]="default")
register_segment "time"

declare -A wan_ip
wan_ip+=(["script"]="${segments_path}/wan_ip.sh")
wan_ip+=(["foreground"]="colour235")
wan_ip+=(["background"]="colour136")
wan_ip+=(["separator"]="${separator_left_bold}")
register_segment "wan_ip"

# Print the status line in the order of registration above.
print_status_line_right

exit 0
