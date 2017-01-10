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

countfunction() {
	detex $1 | wc -w
}
alias wordcount=countfunction
alias rm='rm -I'

alias poweroff='sudo systemctl poweroff'
alias restart='sudo systemctl restart'
alias halt='sudo systemctl halt'

eval $( dircolors -b $HOME/.ls_col)

export VISUAL=vim
export EDITOR="$VISUAL" 
