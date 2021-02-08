#!/bin/bash
create_symlink () {
    rm -f $2
    ln -s $1 $2 
}

copy () {
    rm -f $2
    cp $1 $2 
}

copy xbindkeys/.xbindkeysrc ~/.xbindkeysrc || true
copy bspwm/bspwmrc ~/.config/bspwm/bspwmrc || true
copy polybar/config ~/.config/polybar/config || true
copy fish/config.fish ~/.config/fish/config.fish || true
copy tmux/.tmux.conf ~/.tmux.conf || true

copy sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc || true
copy sxhkd/show_all_windows_in_desktop.sh ~/.config/sxhkd/show_all_windows_in_desktop.sh || true
