#!/bin/bash

# set up basic variables for where things are located
DEVTOOLS_VENV_DIR="${HOME}/tk/lib/devtools/venv"
REQUIREMENTS_PATH="${HOME}/tk/lib/tkutcher/machines/harbaugh/devtools.requirements.txt"

# source our file with the environment variables for GitLab private 
# repo authentication - this gives us the ASL_GITLAB_TECH_INDEX_URL var
if [[ -f "${HOME}/tk/env/asl-gitlab.env" ]]; then
  source "${HOME}/tk/env/asl-gitlab.env"
else
  echo "No env file?"
  exit 1
fi

if [[ -z "$ASL_TECH_GITLAB_INDEX_URL" ]]; then
  echo "No ASL_TECH_GITLAB_INDEX_URL variable?"
  exit 1
fi


# activate the virtual environment we want to update dependencies for
source "${DEVTOOLS_VENV_DIR}/bin/activate"

# update pip
pip install --upgrade pip

# update dependencies from requirements.txt file
pip install \
  --upgrade \
  -r "$REQUIREMENTS_PATH" \
  --index-url "$ASL_TECH_GITLAB_INDEX_URL"

echo "------------------"
echo "done"
