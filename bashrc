#------------------------------------------------------------------------------
# FROM DEBIAN STD CONFIG
#------------------------------------------------------------------------------
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
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
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

#------------------------------------------------------------------------------
# SETUP HISTORY
#------------------------------------------------------------------------------
# From Tsh
# Don't put duplicate lines in the history
# Don't save commands which start with a space
HISTCONTROL=ignoredups:erasedups:ignorespace
HISTTIMEFORMAT="%Y/%m/%d %R "
HISTSIZE=10000
HISTFILESIZE=10000

shopt -s histappend    # Append to the history file, don't overwrite it
shopt -s histreedit    # Re-edit a failed history substitution
shopt -s histverify    # Verify an history substitution before executing

#------------------------------------------------------------------------------
# DEFINE COLORS
#------------------------------------------------------------------------------
BOLD="$(tput bold)"
RESET="$(tput sgr0)"

RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
MAGENTA="$(tput setaf 5)"
CYAN="$(tput setaf 6)"
WHITE="$(tput setaf 7)"

#------------------------------------------------------------------------------
# DEFINE CUSTOM PROMPT
#------------------------------------------------------------------------------
PS1='\[$BOLD\]\[$BLUE\]\u\[$WHITE\] in \[$GREEN\]\W'
# Custom bash prompt
if [[ -n "${SSH_CONNECTION:-}" ]]
then
    PS1="$PS1"'\[$RESET\]\[$CYAN\] [ssh]'
fi
# Custom bash prompt
if type -t __git_ps1 &>/dev/null  
then  
    PS1="$PS1"'\[$RESET\]\[$CYAN\]$(__git_ps1 " [%s]")'
fi
PS1="$PS1"' \[$RESET\]$ '

#------------------------------------------------------------------------------
# PYTHON CONFIG
#------------------------------------------------------------------------------
export PYTHONSTARTUP="$HOME/.pythonrc"
export PYTHONPATH="$HOME/bin:$PYTHONPATH:/Users/andreasilva/phd/software/lammps/lammps-12Dec18/python"

#------------------------------------------------------------------------------
# MISC
#------------------------------------------------------------------------------
export EDITOR="/usr/bin/vim"
export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/Users/andreasilva/phd/software/lammps/lammps-12Dec18/src"
#eval "$(_VERDI_COMPLETE=source verdi)" # Autocomplete for verdi aiiida

#------------------------------------------------------------------------------
# ALIASES
#------------------------------------------------------------------------------
# Add option to commands
alias echo="echo -e" # Proper formatted version. REMEMBER: it's only in your shell, not script
alias vim="vim -p" # Open things in tabs
# Generic shortcuts
alias ll="ls -l"
alias la="ls -la"
alias lt="ls -lhrt"
alias vgrep="grep -v grep | grep " 
alias ip3="ipython3"

#------------------------------------------------------------------------------
# DEFINE PATH
#------------------------------------------------------------------------------
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

#------------------------------------------------------------------------------
# SOURCE OTHER CONFIG FILES
#------------------------------------------------------------------------------
# List of aliases
if [ -f "$HOME/.bash_aliases" ] ; then
    source "$HOME/.bash_aliases"
fi
# Handy functions too long to be in this file
if [ -f "$HOME/.bash_functions" ] ; then
   source "$HOME/.bash_functions"
fi
# Machine-specific config
if [ -f "$HOME/.bash_machine" ] ; then
   source "$HOME/.bash_machine"
fi
# Sensible info
if [ -f "$HOME/.bash_machine" ] ; then
   source "$HOME/.bash_secrets"
fi

# I forgo the computer unlocked while having a coffe with Paolo.
# Victor, rightfully, took advantage of the situation.
# This is a reminder of your careless behaviour! A. 13.09.19
figlet PINEAPPLE PIZZA  
