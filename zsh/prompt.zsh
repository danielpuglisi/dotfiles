autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

git_branch() {
  echo $(/usr/bin/git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  st=$(/usr/bin/git status 2>/dev/null | tail -n 1)
  if [[ $st == "" ]]
  then
    echo ""
  else
    if [[ $st == "nothing to commit (working directory clean)" ]]
    then
      echo "%{$fg[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "%{$fg[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
 ref=$(/usr/bin/git symbolic-ref HEAD 2>/dev/null) || return
  # echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

function minutes_since_last_commit {
    now=`date +%s`
    last_commit=`git log --pretty=format:'%at' -1`
    seconds_since_last_commit=$((now-last_commit))
    minutes_since_last_commit=$((seconds_since_last_commit/60))
    echo $minutes_since_last_commit
}
rod_git_prompt() {
    local g="$(__gitdir)"
    if [ -n "$g" ]; then
        local MINUTES_SINCE_LAST_COMMIT=`minutes_since_last_commit`
        if [ "$MINUTES_SINCE_LAST_COMMIT" -gt 30 ]; then
            local COLOR=$fg[red]
        elif [ "$MINUTES_SINCE_LAST_COMMIT" -gt 10 ]; then
            local COLOR=$fg[yellow]
        else
            local COLOR=$fg[green]
        fi
        local SINCE_LAST_COMMIT="${COLOR}$(minutes_since_last_commit)m$reset_color"
        # The __git_ps1 function inserts the current git branch where %s is
        local GIT_PROMPT="($fg[green]`git_dirty`$reset_color|${SINCE_LAST_COMMIT})"
        echo ${GIT_PROMPT}
    fi
}

project_name () {
  name=$(pwd | awk -F'Development/' '{print $2}' | awk -F/ '{print $1}')
  echo $name
}

project_name_color () {
 name=$(project_name)
  echo "%{\e[0;35m%}${name}%{\e[0m%}"
}

unpushed () {
  /usr/bin/git cherry -v origin/$(git_branch) 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg_bold[magenta]%}unpushed%{$reset_color%} "
  fi
}

rvm_prompt(){
  if $(which rvm &> /dev/null)
  then
	  echo "%{$fg_bold[yellow]%}$(rvm tools identifier)%{$reset_color%}"
	else
	  echo ""
  fi
}

# This keeps the number of todos always available the right hand side of my
# command line. I filter it to only count those tagged as "+next", so it's more
# of a motivation to clear out the list.
todo(){
  if $(which todo.sh &> /dev/null)
  then
    num=$(echo $(todo.sh ls +next | wc -l))
    let todos=num-2
    if [ $todos != 0 ]
    then
      echo "$todos"
    else
      echo ""
    fi
  else
    echo ""
  fi
}

directory_name(){
  echo "%{$fg_bold[cyan]%}%1/%\/%{$reset_color%}"
}

#export PROMPT=$'\n$(rvm_prompt) in $(directory_name) $(project_name_color)$(git_dirty)$(need_push) › '
# export PROMPT=$'$(directory_name) $(grb_git_prompt)>'
export PROMPT=$'\n$(directory_name) $(rod_git_prompt)$(need_push)\n› '
set_prompt () {
  export RPROMPT="%{$fg[yellow]%}$(todo)%{$reset_color%}"
}

# export PROMPT=$'\n$(rvm_prompt) in $(directory_name) $(git_dirty)$(need_push)\n› '
# set_prompt () {
#   export RPROMPT="%{$fg[green]%}$(todo)%{$reset_color%}"
# }




precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}
