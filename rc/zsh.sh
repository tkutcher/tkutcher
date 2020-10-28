
# path to oh-my-zsh
export ZSH=$HOME/.oh-my-zsh

# styling
ZSH_THEME=powerlevel10k/powerlevel10k
COMPLETION_WAITING_DOTS="true"

# use this to automatically start an ssh-agent (for 4 hours)
plugins=(git ssh-agent)
zstyle :omz:plugins:ssh-agent lifetime 4h

# init oh-my-zsh
source $ZSH/oh-my-zsh.sh
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

alias newshell='source ~/.zshrc'
