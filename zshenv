if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source ~/.rvm/scripts/rvm ; fi

if [ -f $HOME/.rvm/bin ]; then
  PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
fi

export TERM='xterm-256color'
