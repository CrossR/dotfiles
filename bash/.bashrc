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

alias chrome='sh -c "chromium > /dev/null 2>&1 &"'
alias chromein='sh -c "chromium --incognito > /dev/null 2>&1 &"'
alias mountMusic='vmhgfs-fuse -o allow_other -o auto_unmount .host:/Music /mnt/virtual/music/'

alias poweroff='sudo systemctl poweroff'
alias reboot='sudo shutdown -r now'
alias halt='sudo systemctl halt'
alias lock='i3lock -i /usr/share/backgrounds/lock.png'

eval $( dircolors -b $HOME/.scripts/ls_col)

xset -b

export VISUAL=nvim
export EDITOR="$VISUAL" 
export GOPATH=~/code/go/
export PATH=$PATH:$GOPATH/bin

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)" &> /dev/null
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
