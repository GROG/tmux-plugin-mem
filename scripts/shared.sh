command_exists() {
    local cmd=$1
    command -v "$cmd" >/dev/null 2>&1
}

get_tmux_option() {
	local option=$1
	local default_value=$2
	local option_value=$(tmux show-option -gqv "$option")
	if [ -z "$option_value" ]; then
		echo "$default_value"
	else
		echo "$option_value"
	fi
}

set_tmux_option() {
	local option="$1"
	local value="$2"
	tmux set-option -gq "$option" "$value"
}

init_var() {
    local d_var="d_$2"
    eval $2=$(get_tmux_option "@$1_$2" "${!d_var}")
}

print_color() {
    local color="$1_color"
    echo "$pre_color${!color}$2$post_color"
}

is_osx() {
    [ $(uname) == "Darwin" ]
}

is_cygwin() {
    command_exists "WMIC"
}
