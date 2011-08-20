# edit dotfiles
alias dotvim='mvim $ZSH'
alias dotcd='cd $ZSH'


# editors
alias m='mvim'

#ack madness!
alias aack="ack --all"
alias rack="ack --ruby --follow"
alias jack="ack --js"
alias pack="ack --python"
alias l="ls -lah"

# default ctags alias
alias ctags="ctags -R --exclude=.git --exclude=log *"

alias reload!='. ~/.zshrc'
