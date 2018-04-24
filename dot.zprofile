ulimit -c unlimited
umask 022

PATH=/usr/local/openresty/bin:/usr/local/openresty/nginx/sbin:${PATH}
PATH="/usr/local/cuda/bin:${PATH}"
PATH="${HOME}/.cask/bin:${PATH}"
PATH="${HOME}/.cargo/bin:${PATH}"
PATH="${HOME}/dev/ocaml/bin:${PATH}"
PATH="${HOME}/bin:${PATH}"
PATH="${PATH}:${HOME}/.local/nim/bin"
PATH="${PATH}:${HOME}/.nimble/bin"
PATH="${PATH}:${HOME}/.local/bin"

# home/work specific settings
CUSTOMRC=${HOME}/.zsh/customrc
if [ -f ${CUSTOMRC} ]; then
   source ${CUSTOMRC}
fi

PATH=${PATH}:/usr/lib/ccache
export PATH

export PATH=${PATH}:/usr/lib/ccache
export CCACHE_COMPRESS=1

export ORGANIZATION="Zajcev Evgeny"
export HISTFILE=~/.history
export HISTSIZE=11000
export SAVEHIST=100000

export EDITOR="emacsclient -nw"
export VISUAL=$EDITOR
export PAGER="less -r"
export LESS=iM

export WORDCHARS="*?_-.[]~=&;!#$%^(){}<>"
export CLICOLOR=t
export LSCOLORS="exfxcxdxbxegedabagacad"
export LS_COLORS="di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

export PACKAGESITE=ftp://ftp.freebsd.org/pub/FreeBSD/ports/i386/packages-6.2-release/Latest/

alias root="sudo"
alias ssh="ssh -Y"
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   alias ls="ls --color=auto"
   alias grep="grep --color=auto -d skip"
elif [[ "$unamestr" == 'Darwin' ]]; then
   alias ls="ls -G"
   alias grep="grep --color=auto"
fi

alias l="ls -alt"
alias dudir="du -h -d 0"
alias emc=$EDITOR

# freebsd stuff
alias mount_flash="root mount_msdosfs /dev/da0s1 /mnt/flash"

alias gitst="git status -uno"
alias gitmm="git fetch && git merge --no-ff origin/master"

# for go
if [[ "$unamestr" == 'Linux' ]]; then
   export PATH="${PATH}:/usr/lib/go-1.10/bin"
fi

# Setup GNUstep
# . /usr/local/GNUstep/System/Library/Makefiles/GNUstep.sh

sproxy () {
	export http_proxy=http://127.0.0.1:3128
	export ftp_proxy=$http_proxy
}

psearch () {
    make -C /usr/ports quicksearch name=$1
}

usexwem () {
	export USEXWEM=t
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
fpath=($fpath /home/${HOME}/.zsh/functions)
autoload -U compinit
compinit

compdef _command root
#compdef _gnu_generic blue7 green6

# M-h assistance
autoload -U run-help
autoload run-help-sudo
autoload run-help-git
autoload run-help-ip
bindkey "h" run-help
bindkey "H" run-help

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
alias -s pdf=evince
alias -s txt=less
alias -s djvu=djview
alias -s el=emacsclient -nw
alias -s chm=chmsee

setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

setopt AUTO_CD
setopt CORRECT
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt INC_APPEND_HISTORY

# refresh history since last incremental append
# NOTE: use it to add history lines from other shells
alias rehist="fc -RI"

export PS1="%(?..[%{[1;31m%}%B%?%b%{[1;0m%}])%(1j.[J%j].)[%n@%m:%U%16<...<%~%<<%u]$ "
if [ x$TERM = xxterm-color -o x$TERM = xxterm-256color ]; then
	precmd () { print -Pn "\e]0;%n@%m:%l [%~]\a" }
	preexec () { print -Pn "\e]0;%n@%m:%l [$1]\a" }
elif [ x$TERM = xscreen -o x$TERM = xscreen-bce -o x$TERM = xscreen-256color ]; then
	precmd () { print -Pn "\e]0;%n@%m:%l [%~]\a"; print -Pn "\ek%~\e\\" }
	preexec () { print -Pn "\e]0;%n@%m:%l [$1]\a"; print -Pn "\ek$1\e\\" }
fi
