create_symlink () {
    rm -f $2
    ln -s $1 $2 
}

copy () {
    rm -f $2
    cp $1 $2 
}

copy xbindkeys/.xbindkeysrc ~/.xbindkeysrc
copy bspwm/bspwmrc ~/.config/bspwm/bspwmrc
copy sxhkd/sxhkdrc ~/.config/sxhkd/sxhkdrc
copy polybar/config ~/.config/polybar/config
copy fish/config.fish ~/.config/fish/config.fish
copy tmux/.tmux.conf ~/.tmux.conf

