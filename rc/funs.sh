

# mkcd - command to make a directory and cd in to it
mkcd () {
    mkdir -p "$1"
    cd "$1"
}

# cdl - cd in to a directory and list everything there.
cdl () {
    cd "$1"
    ls -la
}
