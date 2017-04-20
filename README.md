# customprompt
Customize your shell prompt in living color with current working directory, system identification and git branch support

## What this script does

By including this script at shell startup time, your prompt will be modified in the following ways:

1. A line going across the entire width of the screen will appear...
2. above a line displaying the `username@computername` by default...
3. followed by a colon and the path of the current working directory...
4. and a `$` on a new line

The script causes a break to a new line before displaying the `$` so that there is enough room on the line to enter a command.

In addition, there is a separate prompt for when you are logged in as root (or `su` to root or enter a `sudo bash` command to become root. I like to make the text and background colors for root striking enough that I know I'm acting as root and should be careful not to abuse my superuserpowers. (The username is replaced by a blatant indication that `I AM ROOT` for additional em

## Directions

1. Copy the `bin/custompromptrc.sh` file into your home directory, renaming it to `.custompromptrc` 
1. Source the file in your shell startup file (`.bashrc` or `.bash_profile`)
   + ```source ~/.custompromptrc```
1. Open a new shell window or re-login to the shell. You should see the custom shell prompt as described above.

The default colors are black text on a cyan background for the normal prompt, and red text on white background with a yellow `$` for root.

## Customization

The script can be customized of course through manual editing of the file itself, but there is an overrides file that can be used to specify alternate color combinations. By providing a file called `.custompromptsh-overrides`, you can specify both foreground and background color for normal mode and root mode, as well as the displayed username and computer name:
```
PROMPT_USER_NAME=customusername
PROMPT_COMPUTER_NAME=domain.com
PS1_TEXT=${COLOR_WHITE}
PS1_BACKGROUND=${COLOR_RED}
PS1_DOLLAR=${COLOR_YELLOW}
ROOT_PS1_TEXT=${COLOR_MAGENTA}
ROOT_PS1_BACKGROUND=${COLOR_WHITE}
ROOT_PS1_DOLLAR=${COLOR_CYAN}
```
The available colors are the `tput` colors from 0 through 7. They are predefined as shell variables within the script for convenience.
```
COLOR_BLACK=0
COLOR_RED=1
COLOR_GREEN=2
COLOR_YELLOW=3
COLOR_BLUE=4
COLOR_MAGENTA=5
COLOR_CYAN=6
COLOR_WHITE=7
```
By default, the script assumes the environment supports git and will make use of the `__git_ps1` command to include the current repository branch in the prompt, assuming the current working directory sits within a git repository. If that command cannot be found (a problem that happens in several environments owing to changes in the git distribution), you have two options.
1. Use the `custompromptrc-nogit.sh` file as the script you include in your startup file. This eliminates references to `__git_ps1`.
1. Download the raw `.git-prompt.sh` file and source it in your startup file before any reference to the `custompromptsh` script.
    * curl -o ~/.git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
    
    * source ~/.git-prompt.sh
      source ~/.custompromptshrc
