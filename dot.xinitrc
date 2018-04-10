#!/bin/sh
#
# xinitrc file for XFce 3 startxfce script
export XCURSOR_THEME=Adwaita
export XCURSOR_SIZE=128

# Unselect the following line to get a BIG mouse cursor in Xfce :
# xset +fp "/usr/local/share/xfce/cursors"

# Set up additionnal fonts that ship with Xfce (Change id38121117)
xset fp+ "/usr/local/share/xfce/fonts"

# For ordinary keyboard
#setxkbmap -model pc105 -layout us,ru -variant dvorak, -option grp:caps_toggle,grp_led:caps

# For kinesis ProQD
setxkbmap -model pc105 -layout us,ru\(phonetic\) -option grp:caps_toggle,grp_led:caps

xrdb -merge $HOME/.Xdefaults

# Weird stuff!
xmodmap $HOME/.Xmodmap
xmodmap $HOME/.Xmodmap

# hide cursor
unclutter -idle 1 &

# notify for the rest
# xwrits

xset s off -dpms
xset m 5 3
xset r rate 250 50

#exec xterm
#firefox &
xterm &
exec x-agent -f $HOME/.emacs.d/remacs.log -- remacs -L $HOME/.emacs.d/modules
exec metacity
xsetroot -solid black
