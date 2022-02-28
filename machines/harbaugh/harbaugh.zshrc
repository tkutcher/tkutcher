
# PATH variables
PATH=$HOME/bin:/usr/local/bin:$PATH  # bash bin
PATH=/opt/homebrew/opt/python@3.10/libexec/bin:$PATH  # default to brew's python 3.10 link
export PATH=$PATH

# Configuring where this repository is installed and sourcing specific files.
TKUTCHER_RC_DIR=/usr/local/lib/tkutcher/rc
source "$TKUTCHER_RC_DIR"/aliases.sh
source "$TKUTCHER_RC_DIR"/env.sh
source "$TKUTCHER_RC_DIR"/funs.sh
source "$TKUTCHER_RC_DIR"/zsh.sh
