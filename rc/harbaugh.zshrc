## PATH variables

# Bash bin
PATH=$HOME/bin:/usr/local/bin:$PATH

# Sym-linking python to default to brew's python3 at 3.9
PATH=/opt/homebrew/opt/python@3.10/libexec/bin:$PATH

export PATH=$PATH


## Navigation specific to this computer
export CODE_DIR='~/code'
alias go2code='cd "$CODE_DIR"'


## Configuring where this repository is installed and sourcing specific files.
TKUTCHER_RC_DIR=/usr/local/tkutcher/rc
source "$TKUTCHER_RC_DIR"/aliases.sh
source "$TKUTCHER_RC_DIR"/env.sh
source "$TKUTCHER_RC_DIR"/funs.sh
source "$TKUTCHER_RC_DIR"/zsh.sh

