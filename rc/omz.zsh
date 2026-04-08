# Sets up oh-my-zsh and the general zsh shell.


# =============================================================================
# OH-MY-ZSH — configuration must be set BEFORE sourcing
# =============================================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git python node azure)

zstyle ":omz:update" mode reminder
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"

# Configuration (re-configure with p10k configure)
if [[ -f "$TK_LIB_DIR/rc/p10k.zsh" ]]; then
  source "$TK_LIB_DIR/rc/p10k.zsh"
elif [[ -f ~/.p10k.zsh ]]; then
  echo "omz.zsh: using ~/.p10k.zsh (consider moving to \$TK_LIB_DIR/rc/p10k.zsh)" >&2
  source ~/.p10k.zsh
fi

# =============================================================================
# NOTE: p10k instant prompt must be sourced at the very top of ~/.zshrc,
# before any output. Add this block manually above the TK_RC section:
#
#   if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#     source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#   fi
# =============================================================================


# =============================================================================
# HISTORY
# After omz — omz sets its own history options and these should override them
# =============================================================================
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

source $ZSH/oh-my-zsh.sh
