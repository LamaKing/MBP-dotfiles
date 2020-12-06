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
# MISC
#------------------------------------------------------------------------------
# Set default text editor:
export EDITOR="/usr/bin/vim"
# Set LD correctly for LAMMPS
#export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/Users/andreasilva/phd/software/lammps/lammps-12Dec18/src"
# Enable bash completion for git
source /usr/share/git-core/contrib/completion/git-prompt.sh 
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
# Define base colored PS1
# It should look something like "<use> in <last dir in PWD> $"
PS1='\[$BOLD\]\[$BLUE\]\u\[$WHITE\] in \[$GREEN\]\W'

# Signal bash via ssh connection at the end of PS1
if [[ -n "${SSH_CONNECTION:-}" ]]
then
    PS1="$PS1"'\[$RESET\]\[$CYAN\] [ssh]'
fi

# If in git repo, put branch name in PS1
# Put '*' for unstaged changes and '+' for staged-not-commited changes
GIT_PS1_SHOWDIRTYSTATE=true 
export PS1="$PS1"'\[$RESET\]\[$CYAN\]$(__git_ps1 " [%s]")'

# Reset color at the end of PS1
PS1="$PS1"' \[$RESET\]$ '

#------------------------------------------------------------------------------
# PYTHON CONFIG
#------------------------------------------------------------------------------
# Execute Python start up script to set up config
export PYTHONSTARTUP="$HOME/.pythonrc"
export PYTHONPATH="$PYTHONPATH:$HOME/bin/"
#------------------------------------------------------------------------------
# ALIASES
#------------------------------------------------------------------------------
# Add option to commands
alias echo="echo -e" # Proper formatted version. 
alias vim="vim -p" # Open files in tabs
# Generic shortcuts
alias ll="ls -l"
alias la="ls -la"
alias lt="ls -lhrt" # List in reverse time order and human-readable size
alias ip3="ipython3"

#------------------------------------------------------------------------------
# DEFINE PATH
#------------------------------------------------------------------------------
# User executables and modules
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

# # Start ssh-agent
# # Check if the ssh-agent is already running
# if [[ "$(ps -u $USER | grep ssh-agent | wc -l)" -lt "2" ]]; then
#     echo "$(date +%F@%T) - SSH-AGENT: Agent will be started"
# 	# Start the ssh-agent and redirect the environment variables into a file
#     ssh-agent -s > $HOME/.ssh/ssh-agent
#     # Load the environment variables from the file
#     . ~/.ssh/ssh-agent >/dev/null
#     # Add the default key to the ssh-agent
#     ssh-add ~/.ssh/id_rsa_ir5
#     ssh-add ~/.ssh/id_rsa_marvin
#     ssh-add ~/.ssh/id_rsa_sissa
# else
#     echo "$(date +%F@%T) - SSH-AGENT: Agent already running"
#     . ~/.ssh/ssh-agent >/dev/null
# fi
