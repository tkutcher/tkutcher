
## PATH variables

# bash bin
PATH=$HOME/bin:/usr/local/bin:$PATH

# default to brew's python 3.10 link
PATH=/opt/homebrew/opt/python@3.10/libexec/bin:$PATH

# export the path
export PATH=$PATH


## Core rc setup

# where the tkutcher repository is cloned ("installed") to.p
export TK_LIB_DIR="${HOME}/tk/lib/tkutcher"

# sourcing files relevant for this machine
source "${TK_LIB_DIR}/rc/aliases.sh"
source "${TK_LIB_DIR}/rc/env.sh"
source "${TK_LIB_DIR}/rc/funs.sh"
source "${TK_LIB_DIR}/machines/harbaugh/zsh-setup.zsh"

