#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source $CURRENT_DIR/shared.sh

pre_color=""
post_color=""
high_color=""
high_percentage=""
mid_color=""
mid_percentage=""
low_color=""
error_color=""
ignore_cached=""
custom_percentage=""

d_pre_color=""
d_post_color="#[default]"
d_high_color="#[fg=colour1]"
d_high_percentage="75"
d_mid_color="#[fg=colour3]"
d_mid_percentage="35"
d_low_color="#[fg=colour2]"
d_error_color="#[fg=colour0]#[bg=colour1]"
d_ignore_cached="yes"
d_custom_percentage=""

init_vars() {
    init_var "mem" "pre_color"
    init_var "mem" "post_color"
    init_var "mem" "high_color"
    init_var "mem" "high_percentage"
    init_var "mem" "mid_color"
    init_var "mem" "mid_percentage"
    init_var "mem" "low_color"
    init_var "mem" "error_color"
    init_var "mem" "ignore_cached"
    init_var "mem" "custom_percentage"
}

mem_value() {
    if [ -x $custom_percentage ];then
        eval $custom_percentage
    elif is_osx; then
        if [ "$ignore_cached" == "yes" ]; then
            top -l 1 |\
            grep 'PhysMem' |\
            sed 's/[^0-9 ]*//g' |\
            awk '{d = ($1+$3)/100}{m = $1-$2}{printf("%02d\n", m/d)}'
        else
            top -l 1 |\
            grep 'PhysMem' |\
            sed 's/[^0-9 ]*//g' |\
            awk '{d = ($1+$3)/100}{printf("%02d\n", $1/d)}'
        fi
    elif command_exists "top"; then
        if [ "$ignore_cached" == "yes" ]; then
            top -d 0.5 -b -n 2 |\
            grep 'Mem' |\
            tail -2 |\
            xargs |\
            awk '{d = $3/100}{m = $5-$19}{printf("%02d\n", m/d)}'
        else
            top -d 0.5 -b -n 2 |\
            grep 'Mem:' |\
            tail -1 |\
            awk '{d = $3/100}{printf("%02d\n", $5/d)}'
        fi
    fi
}

mem_percentage() {
    local mem_p=$(mem_value)

    if [ -z "$mem_p" ]; then
        print_color "error" "EE"
    elif [ "$mem_p" -gt "$high_percentage" ]; then
        print_color "high" "$mem_p"
    elif [ "$mem_p" -gt "$mid_percentage" ]; then
        print_color "mid" "$mem_p"
    else
        print_color "low" "$mem_p"
    fi
}

main() {
    init_vars
	mem_percentage
}
main
