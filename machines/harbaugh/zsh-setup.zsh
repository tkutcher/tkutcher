# This file does the work related to initializing the zsh setup for this machine

# init oh-my-zsh
export ZSH=$HOME/.oh-my-zsh

# style/theme options
ZSH_THEME=powerlevel10k/powerlevel10k
COMPLETION_WAITING_DOTS="true"

# source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# init p10k oh-my-zsh theme
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ -f "${TK_LIB_DIR}/rc/p10k.zsh" ]] && source "${TK_LIB_DIR}/rc/p10k.zsh"


# oh-my-zsh-plugins
#   git (for completions)
#   poetry (for completions)
#   ssh-agent (starts an ssh agent automatically on new shell for less password typing)
plugins=(git poetry ssh-agent)

# configure ssh-agent lifetime to be 4 hours
zstyle :omz:plugins:ssh-agent lifetime 4h

# alias specific to this
alias newshell='source ~/.zshrc'

