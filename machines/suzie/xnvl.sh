#!/bin/bash


# set up basic variables for where things are located
DEVTOOLS_VENV_DIR="${HOME}/tk/lib/devtools/venv"

# activate the virtual environment we want to update dependencies for
source "${DEVTOOLS_VENV_DIR}/bin/activate"

# invoke nvl inside that virtual environment and forward args
nvl "$@"
