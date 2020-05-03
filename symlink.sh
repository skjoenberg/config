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
