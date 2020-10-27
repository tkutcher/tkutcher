
# stuff specific to this machine (more or less)
PATH=$HOME/bin:/usr/local/bin:$PATH  # bash bin
PATH=$PATH:$HOME/sdks/flutter/bin # flutter sdk
PATH=/usr/local/opt/python/libexec/bin:$PATH  # python symlinks from brew

export PATH=$PATH

export GD='~/gd'
alias gdrive='cd "$GD"'

# configuring where this repository is checked out and sourcing specific files.
TKUTCHER_RC_DIR=${HOME}/gd/devel/tkutcher/tkutcher/rc
source "$TKUTCHER_RC_DIR"/aliases.sh
source "$TKUTCHER_RC_DIR"/env.sh
source "$TKUTCHER_RC_DIR"/funs.sh
source "$TKUTCHER_RC_DIR"/zsh.sh
