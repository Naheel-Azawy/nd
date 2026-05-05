#!/bin/sh

# Profile file. Runs on login.

export TERM='screen-256color'
export EDITOR='edit'
export VISUAL="$EDITOR"
export WWW_HOME='https://searx.naheel.xyz'
export WINDOW_MANAGER='bspwm'

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# TODO: move to personal
export ORG_TODO="$HOME/Notes/TODO.org"

export SHHH_JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on' # check bashrc
export _JAVA_AWT_WM_NONREPARENTING=1 # https://unix.stackexchange.com/a/428908/183147
export NEWT_COLORS='root=,black'
#export LESS="$LESS --mouse -K"

export PI=3.14159265358979323844
export EU=2.71828182845904523537

try_export() {
    [ -d "$2" ] && export "$1=$2";:;
}

try_add_path() {
    for p; do
        [ -d "$p" ] && export PATH="$PATH:$p";:
    done
}

# Start graphical server if wm not already running.
if [ "$(tty)" = "/dev/tty1" ]; then
    pgrep -x "$WINDOW_MANAGER" || exec startx
fi
