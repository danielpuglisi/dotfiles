alias zsh_benchmark='for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done'
alias zsh_debug='zsh -i -c -x exit'

# edit this file
alias ealias='vim $ZSH/zsh/aliases.zsh'

# edit dotfiles
alias edot='vim $ZSH'
alias dotcd='cd $ZSH'

# edit vim stuff
alias vim='nvim'
alias evimrc='vim $ZSH/vim/vimrc.symlink'

# editors
alias ovim='mvim -v'

# change vim background color
alias darkvim="echo 'set background=dark' > ~/.vim/plugin/background-color.vim"
alias lightvim="echo 'set background=light' > ~/.vim/plugin/background-color.vim"

#ack madness!
alias aack="ack --all"
alias rack="ack --ruby --follow"
alias jack="ack --js"
alias pack="ack --python"
alias l="ls -lah"

#grep zsh history
alias hi="history 1 | grep $*"

# default ctags alias
alias ctags="ctags -R --exclude=.git --exclude=log *"

alias reload!='. ~/.zshrc'

# Tmuxinator
alias t="tmuxinator"

# Search engine:
alias s="sr google -l $*"

# Postgres
alias pg-up='pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start'
alias pg-down='pg_ctl -D /usr/local/var/postgres stop -s -m fast'

# Ruby
alias r='rbenv local'
alias b='bundle exec'

# Tmux
alias tlist="tmux list-sessions"
alias tmux="env TERM=xterm-256color tmux"
alias tkill="tmux kill-session -t $*"
alias tnew="tmux new-session -s $*"
alias tatt="tmux attach -t $*"

# git
alias git=hub

# redis
alias redis-up='redis-server /usr/local/etc/redis.conf > /dev/null &'
alias redis-down='killall redis-server'

# Remove the hosts that I don't want to keep around- in this case, only
# keep the first host. Like a boss.
alias hosts="head -2 ~/.ssh/known_hosts | tail -1 > ~/.ssh/known_hosts"

# Pipe my public key to my clipboard. Fuck you, pay me.
alias pubkey="more ~/.ssh/id_rsa.pub| pbcopy | echo '=> Public key copied to pasteboard.'"
