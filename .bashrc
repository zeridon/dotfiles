# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

## Some helpfull functions
add_to_path (){
	if [[ "$PATH" =~ (^|:)"${1}"(:|$) ]] ; then
		return 0
	fi
	export PATH=${1}:$PATH
}
remove_from_path(){
	export PATH=`echo -n $PATH | awk -v RS=: -v ORS=: '$0 != "'$1'"' | sed 's/:$//'`;
}
## add homedir to path
if [ -d ${HOME}/bin ] ; then
	add_to_path ${HOME}/bin
fi

# Check for speciffic config/var settings/aliases and use them
for file in ~/.bash_aliases ~/.bash_javavars ~/.bash_awsvars ~/.bash_debvars ~/.bash_perlvars ~/.bash_govars ~/.bash_nodevars ~/.bash_herokuvars ~/.bash_disable-emojis-and-colors; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file"
done

# Rubbies management (rbenv)
if [ -f $HOME/.rbenv/bin/rbenv ] ; then
	# so we have rvm lets patch it in the path
	add_to_path $HOME/.rbenv/bin # Add RVM to PATH for scripting
	eval "$(rbenv init -)"
fi

if [ -f $HOME/.bash-git-prompt/gitprompt.sh ] ; then
	GIT_PROMPT_ONLY_IN_REPO=1
	GIT_PROMPT_SHOW_UPSTREAM=1
	GIT_PROMPT_THEME=Single_line_Dark
	if [ -f $HOME/.git-prompt-colors.sh ] ; then
		GIT_PROMPT_THEME=Custom
	fi
	source ~/.bash-git-prompt/gitprompt.sh
fi

eval "$(direnv hook bash)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# pipenv specials
if [ -d $HOME/.local/bin ] ; then
	add_to_path $HOME/.local/bin
fi

# pipenv local to project
export PIPENV_VENV_IN_PROJECT=1
