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
# PLEASE STOP DESTROYING EVERYTHING !!!
export HOMEBREW_NO_AUTO_UPDATE=1

export GOPRIVATE=github.rl.lan

# Setup jump https://github.com/gsamokovarov/jump
eval "$(jump shell zsh)"

# Add fzf completion
# https://github.com/junegunn/fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Utility functions
function execDockerContainer(){
    docker exec -it "$1" /bin/sh
}

function grepHistory(){
    history | grep $1
}

# Aliases
alias hgrep=grepHistory
alias kc=kubectl
alias dx=execDockerContainer
alias dk='docker'
alias dc='docker-compose'
alias dcd='docker-compose down'
alias dcu='docker-compose up'
alias dcb='docker-compose build'
alias dcl='docker-compose logs'
