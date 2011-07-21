# completion
autoload -U compinit
compinit


# automatically enter directories without cd
setopt auto_cd

# use vim as an editor
export EDITOR=vim

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# vi mode
bindkey -v

# expand functions in the prompt
setopt prompt_subst

export PS1='[${SSH_CONNECTION+"%n@%m:"}%~] '

# virtualenvwrapper setup
#
# this block is a lazy-loader for workon that only runs if ~/.virtualenvs
# exists.  It defines a function (__workon_with_load) that loads the real
# workon, sets up the environment, and removes the alias we made to do the
# loading on the first invocation of workon.
if [ -d $HOME/.virtualenvs ]; then
  __workon_with_load () {
    export WORKON_HOME=~/.virtualenvs
    unalias workon
    source /usr/local/bin/virtualenvwrapper.sh
    export PIP_VIRTUALENV_BASE=$WORKON_HOME
    export PIP_RESPECT_VIRTUALENV=true
    workon $1
  }
  alias workon='__workon_with_load'
fi
