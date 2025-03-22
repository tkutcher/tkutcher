
## PATH variables

# bash bin
PATH=$HOME/bin:/usr/local/bin:$PATH

# default to brew's python 3.11 link
PATH=/opt/homebrew/opt/python@3.12/libexec/bin:$PATH

# poetry, etc.
PATH=$HOME/.local/bin:$PATH

# export the path
export PATH=$PATH


## Core rc setup

# where the tkutcher repository is cloned ("installed") to
export TK_LIB_DIR="${HOME}/tk/lib/tkutcher"
export TK_GDRIVE_DIR="${HOME}/Google Drive/My Drive"
export TK_TURBOSCAN_DIR="${HOME}/Library/Mobile Documents/iCloud~com~novosoft~TurboScan/Documents"

# sourcing files relevant for this machine
source "${TK_LIB_DIR}/rc/aliases.sh"
source "${TK_LIB_DIR}/rc/env.sh"
source "${TK_LIB_DIR}/rc/funs.sh"
source "${TK_LIB_DIR}/machines/harbaugh/zsh-setup.zsh"

