
# path to oh-my-zsh
export ZSH=$HOME/.oh-my-zsh

# styling
ZSH_THEME=powerlevel10k/powerlevel10k
COMPLETION_WAITING_DOTS="true"

# use this to automatically start an ssh-agent
plugins=(git ssh-agent)

# init oh-my-zsh
source $ZSH/oh-my-zsh.sh
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

alias newshell='source ~/.zshrc'
