#!/bin/bash

# source this file in your .bashrc/.bash_profile to set a custom PS1
# prompt and a special PS1 prompt when logged in as root 
#
# add overrides to ~/.custompromptsh-overrides

OVERRIDES_FILE_NAME=~/.custompromptsh-overrides

COLOR_BLACK=0
COLOR_RED=1
COLOR_GREEN=2
COLOR_YELLOW=3
COLOR_BLUE=4
COLOR_MAGENTA=5
COLOR_CYAN=6
COLOR_WHITE=7

PS1_TEXT=${COLOR_BLACK}
PS1_BACKGROUND=${COLOR_CYAN}
PS1_DOLLAR=${COLOR_CYAN}
ROOT_PS1_TEXT=${COLOR_RED}
ROOT_PS1_BACKGROUND=${COLOR_WHITE}
ROOT_PS1_DOLLAR=${COLOR_YELLOW}

if [ -f $OVERRIDES_FILE_NAME -a -r $OVERRIDES_FILE_NAME ]
then
    source $OVERRIDES_FILE_NAME
fi

SET_PS1_TEXT=$(tput setaf ${PS1_TEXT})
SET_PS1_BACKGROUND=$(tput setab ${PS1_BACKGROUND})
SET_PS1_DOLLAR=$(tput setaf ${PS1_DOLLAR})
PS1_CONTENT="${PROMPT_USER_NAME:-$USER}@${PROMPT_COMPUTER_NAME:-$(hostname)} :"
SET_ROOT_PS1_TEXT=$(tput setaf ${ROOT_PS1_TEXT})
SET_ROOT_PS1_BACKGROUND=$(tput setab ${ROOT_PS1_BACKGROUND})
SET_ROOT_PS1_DOLLAR=$(tput setaf ${ROOT_PS1_DOLLAR})
ROOT_PS1_CONTENT="**i aM r00T** : \w/"

PREFIX="$(tput smul)$(for a in $(seq 1 $(tput cols));do echo -n ' ';done)$(tput rmul)"
export USER_PS1='\[$(tput smul)$(for a in $(seq 1 $(tput cols));do echo -n " ";done)$(tput rmul)\n${SET_PS1_BACKGROUND}${SET_PS1_TEXT}\]${PS1_CONTENT} \w/$(__git_ps1 " (BRANCH: %s)") $(tput sgr0)\n\[$(tput bold)${SET_PS1_DOLLAR}\]\$\[$(tput sgr0)\] '
export ROOT_PS1="\[$(tput smul)$(for a in $(seq 1 $(tput cols));do echo -n ' ';done)$(tput rmul)\n${SET_ROOT_PS1_BACKGROUND}${SET_ROOT_PS1_TEXT}$(tput bold)\]${ROOT_PS1_CONTENT} $(tput sgr0)\n\[$(tput bold)${SET_ROOT_PS1_DOLLAR}\]#\[$(tput sgr0)\] "
export PROMPT_COMMAND="
  if [ \$UID -eq 0 ]
  then
    PS1=\$ROOT_PS1
  else
    PS1=\$USER_PS1
  fi
"
