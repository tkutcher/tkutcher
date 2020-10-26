
# Code-Folding Regions in Editor
- include a comment `<editor-fold desc="some-description">` to start the region
- and a comment `</editor-fold>` to end the region
- add `defaultstate="collapsed"` to the open attribute to default it to be collapsed.i


# GitLab private keys for CI
- Create the keypair using `ssh-keygen -f deploy_key -N ""`
- Add deploy\_key.pub contents (without the user) to the repo that can be installed in other CI jobs
- Set the environment variable (`$SSH_PRIVATE_KEY`) to the result of `cat deploy_key | base64`
- To add the private key to the runner the setup will need to do something like:
```sh
# If it is being run in the gitlab CI environment, add ssh info
if [[ -n ${CI} ]]; then
  eval "$(ssh-agent -s)"
  ssh-add <(echo "$SSH_PRIVATE_KEY" | base64 --decode)
  mkdir -p ~/.ssh
  chmod 700 ~/.ssh
  ssh-keyscan gitlab.com >> ~/.ssh/known_hosts
  chmod 644 ~/.ssh/known_hosts
fi
```
