# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=4000
HISTFILESIZE=8000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

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
#force_color_prompt=yes

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
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='/bin/ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='/bin/grep --color=auto'
    alias fgrep='/bin/fgrep --color=auto'
    alias egrep='/bin/egrep --color=auto'
fi

# some more ls aliases
alias ll='/bin/ls -alF'
alias la='/bin/ls -A'
alias l='/bin/ls -CF'

function finds() {
  name="*.$1"
  shift
  echo "$name"
  find -name "$name" $*
}

GRAY='\033[1;30m'

newlineafterprompt()
{
# Show a clock at beginning of prompt
    PROMPT_COMMAND="echo -n -e '$GRAY'\[\$(date +%H:%M:%S)\]"
    PS1='${debian_chroot:+($debian_chroot)}\[\033[02;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ '
}

promptnormal()
{
    PS1='${debian_chroot:+($debian_chroot)}\[\033[02;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
}   

promptnormal

MAXLEN_FOR_NORMALPROMPT=20
currentdirstrlength=${#PWD}
#  echo "Prompt length: ${currentdirstrlength}"
if [[ "$currentdirstrlength" -gt "$MAXLEN_FOR_NORMALPROMPT" ]]
  then
       newlineafterprompt
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi



# add texlive binaries to command path
export PATH=/usr/local/texlive/2014/bin/x86_64-linux:${PATH}

export MANPATH=/usr/local/texlive/2014/doc/man:${MANPATH}
export INFOPATH=/usr/local/texlive/2011/doc/info:${INFOPATH}


# add local cabal binaries to command path
export PATH=~/.cabal/bin:${PATH}

export EDITOR=/usr/bin/vim

# A shortcut function that simplifies usage of xclip.
# - Accepts input from either stdin (pipe), or params.
# ------------------------------------------------
cb() {
  local _scs_col="\e[0;32m"; local _wrn_col='\e[1;31m'; local _trn_col='\e[0;33m'
  # Check that xclip is installed.
  if ! type xclip > /dev/null 2>&1; then
    echo -e "$_wrn_col""You must have the 'xclip' program installed.\e[0m"
  # Check user is not root (root doesn't have access to user xorg server)
  elif [[ "$USER" == "root" ]]; then
    echo -e "$_wrn_col""Must be regular user (not root) to copy a file to the clipboard.\e[0m"
  else
    # If no tty, data should be available on stdin
    if ! [[ "$( tty )" == /dev/* ]]; then
      input="$(< /dev/stdin)"
    # Else, fetch input from params
    else
      input="$*"
    fi
    if [ -z "$input" ]; then  # If no input, print usage message.
      echo "Copies a string to the clipboard."
      echo "Usage: cb <string>"
      echo "       echo <string> | cb"
    else
      # Copy input to clipboard
      echo -n "$input" | xclip -selection c
      # Truncate text for status
      if [ ${#input} -gt 80 ]; then input="$(echo $input | cut -c1-80)$_trn_col...\e[0m"; fi
      # Print status.
      echo -e "$_scs_col""Copied to clipboard:\e[0m \"$input\""
    fi
  fi
}


bury() { mkdir -p $(dirname "$2") && cp "$1" "$2"; }

# Aliases / functions leveraging the cb() function
# ------------------------------------------------
# Copy contents of a file
function cbf() { cat "$1" | cb; }  
# Copy current working directory
alias cbwd="pwd | cb"  
# Copy most recent command in bash history
alias cbhs="cat $HISTFILE | tail -n 1 | cb"  


anywait(){

    for pid in "$@"; do
        while kill -0 "$pid"; do
            sleep 0.5
        done
    done
}
waitall() {
    pids=$(pidof "$@")
    echo "Wait for $@ ($pids)..."
    anywait $(pidof "$@")
}
fresh() {
    waitall "$1"
    $@
}


export PATH=~/bin/visit2_9_0.linux-x86_64/bin:$PATH



# some handy haskell-scripting tools
function hmap { ghc -e "interact ($*)";  }
function hmapl { hmap  "unlines.($*).lines" ; }
function hmapw { hmapl "map (unwords.($*).words)" ; }



# Enable circular scrolling, as GPointingDeviceSettings seems unable to make that persistent.
# Really doesn't belong here, but oh well...
synclient CircularScrolling=1




LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=30;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';
export LS_COLORS
export VIDEO_FORMAT=PAL

PERL_MB_OPT="--install_base \"/home/sagemuej/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/sagemuej/perl5"; export PERL_MM_OPT;



export BEEP=/usr/share/sounds/ubuntu/stereo/dialog-information.ogg
alias beep='paplay "$BEEP" --volume=32768'

# Simple way to set audio volume from the CLI
alias pavol='pactl set-sink-volume @DEFAULT_SINK@'


alias gist='git status'

# http://stackoverflow.com/a/43124892/745903
function rmgit() {
    # Recursively apply write permissions to files in the .git folder
    chmod -R +w "${1}/.git"
    # Remove the clone
    rm -r "${1}"
}

alias jnb='jupyter notebook --browser="echo"'


ttytitle() {
  echo -en "\033]0;$@\a"
}

# Remove "Untitled" terminal-tab name
ttytitle "$TTYTITLE "



# add path-local binaries to command path
export PATH=~/bin:${PATH}
export PATH=./bin:${PATH}

# Make a transient temporary-directory repository with auto-committing
# of work in progress.
# https://github.com/leftaroundabout/temporary-checkout
function mkccd() {
    workdir=$(pwd)
    localpersistance=$(sed "s|/\\([^/]*\\)/\\([^/]*\\)|/\\1/\\2/local|;s|\$|/${1}.git|" <<< ${workdir})
    githubusername="leftaroundabout"
    if [ -d ${localpersistance} ]
    then echo "Using" ${localpersistance}
    else git init --bare ${localpersistance}
    fi
    echo "
{
  \"basename\": \"${1}\",
  \"pseudodir\": \"${workdir}\",
  \"origin\": \"${localpersistance}\",
  \"online-remotes\": {
    \"github\": \"git@github.com:${githubusername}/${1}.git\"
  }
}" > ".${1}.repo-q.json"
    ln -s "/tmp/ccd/${1}" ${1}
}

function my-github-fork() {
  git remote add leftaroundabout git@github.com:leftaroundabout/$(basename $(pwd))
}
