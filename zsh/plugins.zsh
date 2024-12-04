# rbenv
eval "$(rbenv init -)"

# FZF Config
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set ignore
export FZF_DEFAULT_COMMAND='ag --hidden --ignore /tmp/ --ignore /.bundle/ --ignore /.git/ -g ""'

# Base 16 colors
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && source "$BASE16_SHELL/profile_helper.sh"

# Nodenv
eval "$(nodenv init -)"

# Pyenv
eval "$(pyenv init -)"
