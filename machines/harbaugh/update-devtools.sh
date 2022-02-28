#!/bin/bash


# set up basic variables for where things are located
DEVTOOLS_VENV_DIR="/usr/local/lib/devtools/venv"
REQUIREMENTS_PATH="/usr/local/lib/tkutcher/machines/harbaugh/devtools.requirements.txt"

# source our file with the environment variables for GitLab private 
# repo authentication - this gives us the ASL_GITLAB_TECH_INDEX_URL var
source "/usr/local/etc/env/anvilorsolutions-gitlab.env"

# activate the virtual environment we want to update dependencies for
source "${DEVTOOLS_VENV_DIR}/bin/activate"

# update pip
pip install --upgrade pip

# update dependencies from requirements.txt file
pip install \
  -r "${REQUIREMENTS_PATH}" \
  --index-url "${ASL_GITLAB_TECH_INDEX_URL}"


echo "------------------"
echo "done!"

