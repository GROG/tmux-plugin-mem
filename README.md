# tmux-plugin-mem

This plugin let's you add the memory usage to tmux status fields.


### Dependencies

This plugin needs `top`, `grep`, `tail`, `xargs` and `awk` to be available.

### Usage

Add one of the available values to your existing `status-left` or
`status-right` tmux option.

| Value | Description |
|-------|-------------|
| `#{mem_percentage}` | Memory usage in percent |

The plugin also has some options to change the indicator.

| Value | Description | Default |
|-------|-------------|---------|
| `@mem_pre_color` | Color code prepended to value | / |
| `@mem_post_color` | Color code appended to value | `#[default]` |
| `@mem_high_color` | Color code prepended for high memory usage | `#[fg=colour1]` |
| `@mem_high_percentage` | Value for high CPU load |  75 |
| `@mem_mid_color` | Color code prepended for middle memory usage | `#[fg=colour3]` |
| `@mem_mid_percentage` | Value for middle CPU load |  35 |
| `@mem_low_color` | Color code prepended for low memory usage | `#[fg=colour2]` |
| `@mem_error_color` | Color code prepended for error codes | `#[fg=colour0]#[bg=colour1]` |
| `@mem_ignore_cached` | Ignore memory used for caching (`yes`/`no`) | `yes` |

Example:

    set -g status-right 'Mem:#{mem_percentage}% | %a %h-%d %H:%M '

    set -g @plugin 'GROG/tmux-plugin-mem'
    set -g @mem_high_percentage "80"
    set -g @mem_low_percentage "40"
    set -g @mem_ignore_cached "no"


### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'GROG/tmux-plugin-mem'

Hit `prefix + I` to fetch the plugin and source it.


### Manual Installation

Clone the repo:

    $ git clone https://github.com/GROG/tmux-plugin-mem ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/mem.tmux

Reload TMUX environment:

    # type this in terminal
    $ tmux source-file ~/.tmux.conf


### Special credit

This plugin is roughly based on the various plugins in
[https://github.com/tmux-plugins](https://github.com/tmux-plugins).


### License

[MIT](LICENSE)


### Contibuting

All assistance, changes or ideas
[welcome](https://github.com/GROG/tmux-plugin-mem/issues)!


### Author

By [G. Roggemans](https://github.com/groggemans)
