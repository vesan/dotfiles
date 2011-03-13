# DESCRIPTION: Put your git branch and a unicode skull and crossbones in your prompt.
# EXAMPLE: http://www.scrnshots.com/users/topfunky/screenshots/89842
# AUTHOR: Geoffrey Grosenbach http://peepcode.com

# From git distribution, slightly modified to work with zsh
# source ~/bin/dotfiles/git-completion.zsh

__git_ps1 ()
{
	local g="$(git rev-parse --git-dir 2>/dev/null)"
	if [ -n "$g" ]; then
		local r
		local b
		if [ -d "$g/rebase-apply" ]
		then
			if test -f "$g/rebase-apply/rebasing"
			then
				r="|REBASE"
			elif test -f "$g/rebase-apply/applying"
			then
				r="|AM"
			else
				r="|AM/REBASE"
			fi
			b="$(git symbolic-ref HEAD 2>/dev/null)"
		elif [ -f "$g/rebase-merge/interactive" ]
		then
			r="|REBASE-i"
			b="$(cat "$g/rebase-merge/head-name")"
		elif [ -d "$g/rebase-merge" ]
		then
			r="|REBASE-m"
			b="$(cat "$g/rebase-merge/head-name")"
		elif [ -f "$g/MERGE_HEAD" ]
		then
			r="|MERGING"
			b="$(git symbolic-ref HEAD 2>/dev/null)"
		else
			if [ -f "$g/BISECT_LOG" ]
			then
				r="|BISECTING"
			fi
			if ! b="$(git symbolic-ref HEAD 2>/dev/null)"
			then
				if ! b="$(git describe --exact-match HEAD 2>/dev/null)"
				then
					b="$(cut -c1-7 "$g/HEAD")..."
				fi
			fi
		fi

		if [ -n "$1" ]; then
			printf "$1" "${b##refs/heads/}$r"
		else
			printf " (%s)" "${b##refs/heads/}$r"
		fi
	fi
}

# Get the name of the branch we are on
git_prompt_info() {
  branch_prompt=$(__git_ps1)
  if [ -n "$branch_prompt" ]; then
    status_icon=$(git_status)
    echo $branch_prompt $status_icon
  fi
}

# Show character if changes are pending
git_status() {
  if current_git_status=$(git status | grep 'added to commit' 2> /dev/null); then
    echo "⚡"
  fi
}
autoload -U colors
colors
setopt prompt_subst
PROMPT='
%~%{$fg_bold[red]%}$(git_prompt_info)
→ %{$reset_color%}'

RPROMPT="$(print '%{\e[1;30m%}%B[%{\e[1;34m%}%*%{\e[1;30m%}]%b%{\e[0m%}')"

# http://stackoverflow.com/questions/1642881/how-to-enable-git-file-tab-completion-with-zsh-compinit
autoload -U compinit
compinit

# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# By default up/down are bound to previous-history
# and next-history respectively. The following does the
# same but gives the extra functionality where if you
# type any text (or more accurately, if there is any text
# between the start of the line and the cursor),
# the subset of the history starting with that text
# is searched (like 4dos for e.g.).
# Note to get rid of a line just Ctrl-C
#bindkey '^[[A' history-search-backward
#bindkey '^[[B' history-search-forward
#bindkey '\e[A' history-search-backward
#bindkey '\e[B' history-search-forward
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

# Shared history
# setopt APPEND_HISTORY
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.history
export HISTCONTROL=erasedups

export VISUAL=mvim
# returns focus back to Terminal after save
export GIT_EDITOR='mvim -f -c"au VimLeave * !open -a Terminal"'
export GEM_OPEN_EDITOR=mvim
export GEM_EDITOR='mvim'
export EDITOR='mvim'

export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/opt/local/bin:/opt/local/sbin:/Applications/Shoes.app/Contents/MacOS:/Users/vesan/bin:/opt/local/lib/postgresql84/bin:/Users/vesan/code/SDKs/flex_sdk_3.5.0.12683/bin:/usr/local/share/npm/bin:$PATH"
export NODE_PATH="/usr/local/lib/node:$NODE_PATH"

export TERM=xterm-color
export CLICOLOR=true
export LSCOLORS=bxfxcxdxbxegedabagacad
alias ls='ls -G'
alias -g '...'='../..'
alias -g '....'='../../..'
alias -g '.....'='../../../..'
alias -g 'grep'='grep -n --colour'
alias git=hub

# alias ss='script/server'

ss () {
  if [ -f ./script/rails ]; then 
    rails server $argv
  else
    ./script/server $argv
  fi
}

# alias sc='script/console'
sc () {
  if [ -f ./script/rails ]; then 
    rails console $argv
  else
    ./script/console $argv
  fi
}

amacs () {
  # Create the files as needed -- not as good as raw emacs, but acceptable
  for f in "$@"
  do
	  test -e $f || touch $f
  done
  open -a /Applications/Aquamacs\ Emacs.app "$@"
}

em () {
  # Create the files as needed -- not as good as raw emacs, but acceptable
  for f in "$@"
  do
	  test -e $f || touch $f
  done
  open -a /Applications/Emacs.app "$@"
}



alias a='autotest -rails'
alias migrate='rake db:migrate && rake db:test:prepare'

alias huh="git diff HEAD | mate"
alias start-postgres="sudo su postgres -c '/opt/local/lib/postgresql84/bin/postgres -D /opt/local/var/db/postgresql84/defaultdb &'"

# Opens a new tab with the cwd
function tab {
  osascript -e "
    tell application \"System Events\" to tell process \"Terminal\" to keystroke \"t\" using command down
    tell application \"Terminal\" to do script \"cd $PWD\" in selected tab of the front window
  " > /dev/null 2>&1
}
 
function as_terminal_cmd {
  osascript -e "tell application \"Terminal\" to do script \"$1\" in selected tab of the front window" 
}
 
function terminal_title {
  if [[ $# -eq 1 && -n "$@" ]];
  then
    printf "\e]0;${@}\a";
  fi
}
 
# cd into a rails dir, start mvim and rails console
function r {
  # cd $1
  as_terminal_cmd "terminal_title Server"
  as_terminal_cmd "ss"
  tab
  as_terminal_cmd "terminal_title Console"
  as_terminal_cmd "sc"
  tab
  as_terminal_cmd "terminal_title Autospec"
  as_terminal_cmd "autospec"
  tab
  as_terminal_cmd "terminal_title Hacking"
  as_terminal_cmd "$EDITOR ."
}

manpdf() {
  man -t $@ | open -f -a /Applications/Preview.app/
}

# added by git installer http://code.google.com/p/git-osx-installer/
export PATH=/usr/local/git/bin:$PATH
export MANPATH=/usr/local/git/man:$MANPATH

alias grep='GREP_COLOR="1;37;41" LANG=C grep --color=auto'

alias 'rake?'="rake -T | grep $1"

function calculator() {
	bc -ql <<< "$@"|perl -pe 's/(\.[^0]+)0+$|\.0+$/$1/'
}
alias '?=calculator'

# working delete key
bindkey "^[[3~" delete-char

# completions
source $HOME/.zsh/_gem.zsh
source $HOME/.zsh/_rake_completion.zsh

function heftiest {
  for file in $(find app/$1/**/*.rb -type f); do wc -l $file ; done  | sort -r | head
}

export SOYWIKI_VIM=mvim
