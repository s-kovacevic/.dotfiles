source ~/.secrets

export PATH="~/.npm-global/bin:$PATH"
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/scripts:$PATH"
export PATH="$HOME/go/bin:$PATH"

# MacOS Specific
export PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:$PATH"
export PATH="/Library/Frameworks/Python.framework/Versions/3.9/bin:$PATH"
export PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:$PATH"
export XBAR_PLUGIN_DIR="/Users/savo/Library/Application Support/xbar/plugins"
export RLBAR_GITHUB_TOKEN=$rlGithubToken
export RLBAR_GITHUB_USERNAME=$rlGithubUser

# PLEASE STOP BREAKING EVERYTHING !!!
export HOMEBREW_NO_AUTO_UPDATE=1

export GOPRIVATE=github.rl.lan

# Setup jump https://github.com/gsamokovarov/jump
eval "$(jump shell zsh)"

# Add fzf completion
# https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Utility functions
function dockerExecContainer() {
  docker exec -it $(docker ps | tail -n +2 | awk '{print $1 " " $2}' | fzf | awk '{print $1}') ${1:-"/bin/sh"}
}

function grepHistory() {
  history | grep $1
}

function kubectlSetContext() {
  context=$(kubectl config get-contexts -o name | fzf)
  kubectl config use-context $context
}

function kubectlPickNamespace() {
  kubectl get namespace --output=jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}' | fzf --prompt "Namespace> "
}

function kubectlDescribeResources() {
  namespace=$(kubectlPickNamespace)
  resource=$(kubectl get ${1:-pods} --namespace=$namespace -o name | fzf)
  kubectl describe $resource --namespace=$namespace
}

function kubectlExec() {
  namespace=$(kubectlPickNamespace)
  pod=$(kubectl get pods -o name -n $namespace | fzf --prompt "Pod> ")
  container=$(kubectl get $pod -n $namespace --output=jsonpath='{range .spec.containers[*]}{.name}{"\n"}{end}')
  numContainers=$(echo "$container" | wc -l | awk '{print $1}')
  if [[ $numContainers -gt "1" ]]; then
    container=$(echo "$container" | fzf --prompt "Container> ") 
  fi
  kubectl exec --stdin --tty $pod -n $namespace -c $container -- ${1:-"/bin/sh"}
}

function kubectlLogs() {
  namespace=$(kubectlPickNamespace)
  pod=$(kubectl get pods -o name -n $namespace | fzf --prompt "Pod> ")
  container=$(kubectl get $pod -n $namespace --output=jsonpath='{range .spec.containers[*]}{.name}{"\n"}{end}')
  numContainers=$(echo "$container" | wc -l | awk '{print $1}')
  if [[ $numContainers -gt "1" ]]; then
    container=$(echo "$container" | fzf --prompt "Container> ") 
  fi
  kubectl logs -f $pod -n $namespace -c $container
}

# Aliases
alias hgrep=grepHistory
alias kc=kubectl
alias kclogs=kubectLogs
alias kcx=kubectlExec
alias kcdescribe=kubectlDescribeResources
alias kcctx=kubectlSetContext
alias dx=execDockerContainer
alias dk='docker'
alias dc='docker-compose'
alias dcd='docker-compose down'
alias dcu='docker-compose up'
alias dcb='docker-compose build'
alias dcl='docker-compose logs'
