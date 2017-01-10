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

alias poweroff='sudo systemctl poweroff'
alias reboot='shutdown -r now'
alias halt='sudo systemctl halt'

export VISUAL=nvim
export EDITOR="$VISUAL" 

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)" &> /dev/null
fi
