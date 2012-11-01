# switch the current shell to jruby
alias j='rbenv shell jruby-1.6.8'

alias r='rbenv local'
alias b='bundle exec'

# database remigration
alias db='rake db:drop && rake db:migrate && rake db:seed'
