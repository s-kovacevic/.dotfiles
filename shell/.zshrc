export ZSH="$HOME/.oh-my-zsh"
if [[ -z "$TMUX" ]]; then
    ZSH_THEME="robbyrussell"
else
    ZSH_THEME="customsuvash"
fi
plugins=(git zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh

source ~/.profile
