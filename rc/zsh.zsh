
# path to oh-my-zsh
export ZSH=$HOME/.oh-my-zsh

# styling
ZSH_THEME=powerlevel10k/powerlevel10k
COMPLETION_WAITING_DOTS="true"


# init oh-my-zsh
source $ZSH/oh-my-zsh.sh
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ -f "${TKUTCHER_RC_DIR}/p10k.zsh" ]] && source "${TKUTCHER_RC_DIR}/p10k.zsh"

# use this to automatically start an ssh-agent (for 4 hours)
plugins=(git ssh-agent)
zstyle :omz:plugins:ssh-agent lifetime 4h

alias newshell='source ~/.zshrc'
