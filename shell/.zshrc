export ZSH="$HOME/.oh-my-zsh"

if [[ -z "$TMUX" ]]; then
    ZSH_THEME="robbyrussell"
else
    ZSH_THEME="simplesuvash"
fi

plugins=(zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

source ~/.profile
