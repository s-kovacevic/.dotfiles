export ZSH="$HOME/.oh-my-zsh"

if [[ -z "$TMUX" ]]; then
    ZSH_THEME="robbyrussell"
else
    ZSH_THEME="simplesuvash"
fi

plugins=(zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

source ~/.profile

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
