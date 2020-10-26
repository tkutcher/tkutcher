
# configuring where this repository is checked out and sourcing specific files.
TKUTCHER_RC_DIR=${HOME}/gd/devel/tkutcher/tkutcher/rc
source "$TKUTCHER_RC_DIR"/aliases.sh
source "$TKUTCHER_RC_DIR"/env.sh
source "$TKUTCHER_RC_DIR"/funs.sh
source "$TKUTCHER_RC_DIR"/zsh.sh

# specialized stuff for this machine
export PATH="$PATH:$HOME/sdks/flutter/bin"
