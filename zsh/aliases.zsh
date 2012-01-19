# edit this file
alias ealias='vim $ZSH/zsh/aliases.zsh'
alias hubot='ssh hubot@192.168.19.210'

# edit dotfiles
alias dotvim='mvim $ZSH'
alias dotcd='cd $ZSH'

# edit vim stuff
alias evimrc='vim $ZSH/vim/vimrc.symlink'
alias egvimrc='vim $ZSH/vim/gvimrc.symlink'

# editors
alias m='mvim'
alias vi='vim'

#ack madness!
alias aack="ack --all"
alias rack="ack --ruby --follow"
alias jack="ack --js"
alias pack="ack --python"
alias l="ls -lah"

# default ctags alias
alias ctags="ctags -R --exclude=.git --exclude=log *"

alias reload!='. ~/.zshrc'

# Current Projects
alias pomcd="cd /Volumes/Development/programmonline/progon-web/src/main/webapp" 
alias porcd="cd /Volumes/Development/programmonline-rails"
