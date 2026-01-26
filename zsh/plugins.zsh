# FZF Config
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set ignore
export FZF_DEFAULT_COMMAND='ag --hidden --ignore /tmp/ --ignore /.bundle/ --ignore /.git/ -g ""'
