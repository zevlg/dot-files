#!/bin/sh
#
# xinitrc file for XFce 3 startxfce script
export XCURSOR_THEME=Adwaita
export XCURSOR_SIZE=128

# Some distro needs to allow even localhost to use the display
# Uncomment this if you experience "Can't open display" when running 
# programs from xfce. BEWARE this is considered as a vulnerability !
#
# xhost +$HOSTNAME
#
#export LANG=ru_RU.UTF-8

xsetroot -solid black -cursor_name watch

# Unselect the following line to get a BIG mouse cursor in Xfce :
# xset +fp "/usr/local/share/xfce/cursors"

# Set up additionnal fonts that ship with Xfce (Change id38121117)
xset fp+ "/usr/local/share/xfce/fonts"

# Start-up stuff from ~/Desktop/Autostart directory, if it exists
# (as it seems to be the new standard)
if [ -d "$HOME/Desktop/Autostart" ]; then
  for i in `ls -1 ${HOME}/Desktop/Autostart/ 2>/dev/null`; do
    if [ -x $HOME/Desktop/Autostart/$i ]; then
      $HOME/Desktop/Autostart/$i &
    fi
  done
fi

# Uncomment this if you have xmodmap loading additional keycodes.
# set the XKEYS variable to the correct file

# XKEYS=/etc/X11/xinit/.Xmodmap
# if [ -f $XKEYS ]; then
#   xmodmap $XKEYS
# fi  

# Uncomment this if you run gkrellm. See http://www.gkrellm.net for 
# more info. It will launch gkrellm if it's not already running
# if [ -z $(grep gkrellm ${HOME}/.xfce/xfwm-session) ]; then
# 	exec `which gkrellm` &
# fi

# Launch xscreensaver (if available)
XBINDIR=/usr/local/bin
if [ -x $XBINDIR/xscreensaver ]; then
	xscreensaver -no-splash &
fi

#setxkbmap -model pc105 -layout us,ru -variant dvorak, -option grp:caps_toggle

xrdb -merge ~/.Xdefaults
xmodmap ~/.Xmodmap

# hide cursor
unclutter -idle 1 &

xset s off -dpms
xset m 5 3
xset r rate 250 45

#exec xterm
exec xwem-agent -f $HOME/.emacs.d/emacs.log emacs
exec xfwm
xsetroot -solid black
