ulimit -c unlimited
umask 022

PATH=/usr/local/openresty/bin:/usr/local/openresty/nginx/sbin:$PATH
PATH="/usr/local/cuda/bin:${PATH}"
PATH="${HOME}/.cask/bin:${PATH}"
PATH="${HOME}/dev/ocaml/bin:${PATH}"
PATH="${HOME}/bin:${PATH}"
PATH="${PATH}:${HOME}/.local/bin"
export PATH

export ORGANIZATION="Zajcev Evgeny"
export HISTFILE=~/.history
export HISTSIZE=11000
export SAVEHIST=100000

export PATH=/usr/lib/ccache:${PATH}
export CCACHE_COMPRESS=1

export EDITOR=emacsclient
export VISUAL=emacsclient
export PAGER="less -r"
export LESS=iM

export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"
export CLICOLOR=t
export LSCOLORS="exfxcxdxbxegedabagacad"

export PACKAGESITE=ftp://ftp.freebsd.org/pub/FreeBSD/ports/i386/packages-6.2-release/Latest/

export GREP_OPTIONS="--color=auto -d skip"
alias root="sudo"
alias ssh="ssh -Y"
alias l="ls -alt"
alias dudir="du -h -d 0"

# freebsd stuff
alias mount_flash="root mount_msdosfs /dev/da0s1 /mnt/flash"
# JS-Kit
# alias stag="ssh lg@stag"

alias gitst="git status -uno"
alias gitmm="git fetch && git merge --no-ff origin/master"

# for GO lang
export GOROOT=$HOME/down/go-lang
export GOARCH=386
export GOOS=darwin

# Setup GNUstep
# . /usr/local/GNUstep/System/Library/Makefiles/GNUstep.sh

sproxy () {
	export http_proxy=http://127.0.0.1:3128
	export ftp_proxy=$http_proxy
}

Sradio () {
	echo -n "Psy(0), Respect(1), DC(2), Centr(3), Drum(4): "
	read R
	case $R in
	0)
		rurl=http://radio.simix.ru:7100
		rad="Psy Radio"
		;;
	1)
		rurl=http://radio.7w.ru:8000/recpect
		rad="Radio RECPEKT!"
		;;
	2)
		rurl=http://dc.7w.ru:8000/dc
		rad="Dancing Coyote Radio"
		;;
	3)
		rurl=http://dc.7w.ru:8000/radiocentr
		rad="Radio Centr"
		;;
	4)
		rurl=http://radio.simix.ru:7200
		rad="Drum Machine"
		;;
	esac
	print "Playing $rad, press \`q\' to quit."
	mplayer -really-quiet $rurl 2>&1 > /dev/null
}

ssh-ltsp () {
	ssh -C -L 5900:192.168.1.60:5900 -L 5901:192.168.1.61:5900 -L 5902:192.168.1.62:5900 -L 5903:192.168.1.63:5900 -L 5904:192.168.1.64:5900 -L 5905:192.168.1.65:5900 -L 5906:192.168.1.66:5900 -L 5907:192.168.1.67:5900 -L 5908:192.168.1.68:5900 -L 5909:192.168.1.69:5900 -L 5910:192.168.1.70:5900 -L 5980:192.168.1.80:5900 -L 5984:192.168.1.84:5900 -L 5981:192.168.1.81:5900 -L 5982:192.168.1.82:5900 -L 5983:192.168.1.83:5900 lg@iltsp
}

sndfix () {
	root kldunload snd_ich
	root kldload snd_ich
}

qw () {
	root ~/devel/emaqs/src/emaqs -basedir /usr/local/share/fuhquake -mdev /dev/sysmouse -dibonly -dinput m_smooth -particles 0 -heapsize 32768 -sndbits 16 -sndspeed 44100 +set s_khz 44 +set cl_confirmquit 0 +set vid_displayfrequency 75 -bpp 32 -no24bit -ruleset smackdown +cfg_load lg1.cfg $@
}

lqw () {
	root fuhquake-svga -basedir /usr/local/share/fuhquake -mdev /dev/sysmouse -dibonly -dinput m_smooth -particles 0 -heapsize 32768 -sndbits 16 -sndspeed 44100 +set s_khz 44 +set vid_displayfrequency 75 -bpp 32 -no24bit -ruleset smackdown +cfg_load lg1.cfg $@
}

cputemp () {
	sysctl hw.acpi.thermal.tz0.temperature
}

psearch () {
    make -C /usr/ports quicksearch name=$1
}

usexwem () {
	export USEXWEM=t
}

setup_xorg_config ()
{
	if [ -c /dev/ukbd0 ]; then
		export XORG_CONF="xorg.lg-kinesis.conf"
	else
		export XORG_CONF="xorg.lg.conf"
	fi
}

start_xorg ()
{
	setup_xorg_config
	xinit -- -config $XORG_CONF :1
}

XX () {
	unset XXT
	start_xorg
}

XXt() {
	export XXT=t
	start_xorg
}

tarlist () {
	tar -t -zf ${1}
}

untar () {
	tar -zxvf ${1}
}

findext () {
    find . -name "*.${1}"
}

genv () {
    env | grep -i ${1}
}

if [ $TERM = "xterm" -o $TERM = "xterm-color" ]; then
	export TERM="xterm-color"
elif [ $TERM = "cons25r" ]; then
	vidcontrol -r yellow black green black
fi

# For Fink
#. /sw/bin/init.sh

# Useful ZSH functions
autoload zmv

# ZSH completions
fpath=($fpath /home/lg/.zsh/functions)
autoload -U compinit
compinit

compdef _command root
#compdef _gnu_generic blue7 green6

#make equivalent root cmd ^h and cmd ^h
my-run-help () {
    [[ $1 = . ]] && 1=dot
    [[ $1 = : ]] && 1=colon

    words=(${=BUFFER})
    if [[ $words[1] = root || $words[1] = sudo ]]; then
        run-help $words[2]
    else
        run-help $words[1]
    fi
    zle reset-prompt
}
zle -N my-run-help
bindkey "h" my-run-help
bindkey "H" my-run-help

lg-insert-parens () {
	LBUFFER+="("
	RBUFFER=")"${RBUFFER}
}
zle -N lg-insert-parens
bindkey "(" lg-insert-parens

# invoke-rc completes executable scripts in rc.d
compdef '_files -g "*(X)" -W /usr/local/etc/rc.d/' invoke-rc

# Default completion type is filename
zstyle ':completion:*' completer _complete _ignored _files

# add colors
zstyle ':completion:*:default' list-colors 'no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;31:'

autoload -U insert-files
zle -N insert-files

# enable cmd line prediction
autoload -U predict-on
autoload -U predict-off
zle -N predict-on
zle -N predict-off
bindkey '^Xp' predict-on
bindkey '^X^P' predict-off

autoload -U insert-files
zle -N insert-files
bindkey "^Xf" insert-files
# C-Enter to execute command and hold contents
#bindkey "^" accept-and-hold

autoload -U pick-web-browser
alias -s html=pick-web-browser
zstyle ':mime:*' x-browsers firefox

# aliases
alias -s {png,gif,xpm,jpg}=gqview
alias -s {avi,mpeg,mpg,mov,m2v}=mplayer
alias -s {odt,doc,sxw,rtf}=openoffice.org-2.3.1
alias -s {ogg,mp3,wav,wma}=mpg321
alias -s ps=gv
alias -s pdf=xpdf
alias -s txt=less
alias -s djvu=djview
alias -s el=emacsclient
alias -s chm=chmsee

setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

setopt AUTO_CD
setopt CORRECT
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt INC_APPEND_HISTORY

export PS1="%(?..[%{[1;31m%}%B%?%b%{[1;0m%}])%(1j.[J%j].)[%n@%m:%U%16<...<%~%<<%u]$ "
if [ x$TERM = xxterm-color ]; then
	precmd () { print -Pn "\e]0;%n@%m:%l [%~]\a" }
	preexec () { print -Pn "\e]0;%n@%m:%l [$1]\a" }
elif [ x$TERM = xscreen -o x$TERM = xscreen-bce ]; then
	precmd () { print -Pn "\e]0;%n@%m:%l [%~]\a"; print -Pn "\ek%~\e\\" }
	preexec () { print -Pn "\e]0;%n@%m:%l [$1]\a"; print -Pn "\ek$1\e\\" }
fi

#if [ x$WINDOW = x ]; then
#        export PS1="%(?..[%B%?%b])%(1j.[J%j].)[T%D{%H:%M}][%U%~%u]$ "
#	if [ x$TERM = xxterm-color -o x$TERM = xscreen -o x$TERM = xscreen-bce ]; then
#		precmd () { print -Pn "\e]0;%n@%m:%l [%?]\a"; print -Pn "\ek%~\e\\" }
#    		preexec () { print -Pn "\e]0;%n@%m:%l [$1]\a"; print -Pn "\ek$1\e\\" }
#	fi
#else
#        export PS1="%(?..[%B%?%b])%(1j.[J%j].)[W$WINDOW][T%D{%H:%M}][%U%~%u]$ "
#	if [ x$TERM = xxterm-color -o x$TERM = xscreen -o x$TERM = xscreen-bce ]; then
#    		precmd () { print -Pn "\e]0;%n@%m:%l [W$WINDOW] [%?]\a"; print -Pn "\ek%~\e\\" }
#    		preexec () { print -Pn "\e]0;%n@%m:%l [W$WINDOW] [$1]\a"; print -Pn "\ek$1\e\\" }
#	fi
#fi

# Fomenko quotes
#if [ $TERM = "xterm-color" -o $TERM = "screen" -o $TERM = "screen-bce" ]; then
#	echo "\033[36m"
#	fortune 10% /usr/local/share/games/fortune/rus/fomenko 20% /usr/local/share/games/fortune/rus/offencive 20% /usr/local/share/games/fortune/rus/speed-info 50% /usr/local/share/games/fortune/rus/lorquotes | iconv -f koi8-r -t utf-8
#	echo "\033[0m"
#fi

# Start ssh-agent if not yet
#if [ -z `ps ax -U lg | grep -v grep | grep ssh-agent` ]; then
#    eval `ssh-agent`
##    ssh-add
#fi
# Start gpg-agent if not yet
#if [ -z `ps ax -U lg | grep -v grep | grep gpg-agent` ]; then
#    eval `gpg-agent --daemon --sh`
#fi
