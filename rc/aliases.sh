
# shortcuts
alias ll='ls -l'
alias la='ls -lA'
alias cla='clear && la'
alias cls='clear'
alias c='clear'
alias dir='ls -lAh'

# typos
alias clea='clear'
alias claer='clear'
alias cler='clear'
alias ckear='clear'
alias clera='clear'
alias cear='clear'
alias gti='git'

# git aliases
alias gaa='git add --all'
alias gpush='git push'
alias gp='git push'
alias gpushall='git remote | xargs -L1 git push --all'
alias gpa='git remote | xargs -L1 git push --all'
alias gpull='git pull'
alias gcmsg='git commit -m'
alias gcsmg='gcmsg'  # handle typo
alias gplog='git log --pretty=oneline'
alias gs='git status'
alias gaas='git add --all && git status'
alias gcp='git cherry-pick'
alias gco='git checkout'
alias unstage='git rm --cached'
alias gitblah='git add --all && git commit -m "blah" && git push'

# nav aliases
alias up='cd ..'
alias back='cd -'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

# python aliases
alias pr='pipenv run'
alias prp='pipenv run python'
alias nvenv='python -m venv venv'
alias py='python'
alias pup='pip install --upgrade pip'
alias purp='pip install -Ur requirements.txt'
alias purpr='pip install -Ur'
alias pipfind='pip freeze | grep'
alias freshpip='pip freeze | grep -v "^-e" | xargs pip uninstall -y'
alias basepip='freshpip && pup && pip install pipenv'
