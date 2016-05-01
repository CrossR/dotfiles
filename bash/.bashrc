#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias vim='nvim -p'
PS1='[\u@\h \W]\$ '
openfunction() {
	nohup zathura $1 > /dev/null 2>&1 &
}
alias openpdf=openfunction

alias rm='rm -I'

eval $( dircolors -b $HOME/.ls_col)

export VISUAL=vim
export EDITOR="$VISUAL" 
