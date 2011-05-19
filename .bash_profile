#-------------------------------------------------------------------
#     Navigation Aliases 
#-------------------------------------------------------------------

function newdir() { mkdir -p "$@" && eval cd "\"\$$#\""; }
function cl { cd $1; ls; }
# alias home='cd ~'
alias desk='cd ~/Desktop'
alias list='ls -aFhlG'
function .. { cd ..; ls; }
alias c='clear'

#-------------------------------------------------------------------
#     Networking Functions and Aliases
#-------------------------------------------------------------------

#grep ifconfig to get get ip address
#link: http://www.askdavetaylor.com/how_do_i_figure_out_my_ip_address_on_a_mac.html
#alias ip='ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2'

#grep to find mac address http://goo.gl/8vcc4
#alias mac="ifconfig en0 | grep -o -E '([[:xdigit:]]{1,2}:){5}[[:xdigit:]]{1,2}'"

#get dhcp server address http://automatica.com.au/?p=463
#alias dhcp="ipconfig getoption en0 router"

alias flushdns='dscacheutil -flushcache'

#http://goo.gl/HbYyb
function print_ip(){ 
	ipconfig getpacket en0 | grep "yiaddr" | sed "s/yiaddr/ip/";
}
function ip(){
	print_ip; ipconfig getpacket en0 | grep "yiaddr" | sed "s/yiaddr = //" | pbcopy;
}
function print_mac(){ 
	ipconfig getpacket en0 | grep "chaddr" | sed "s/chaddr/mac/"; 
}
function mac(){ 
	print_mac; ipconfig getpacket en0 | grep "chaddr" | sed "s/chaddr = //" | pbcopy; 
}
function dns(){ ipconfig getpacket en0 | grep "domain_name_server" | sed "s/domain_name_server/DNS/"; }
function dhcp(){ ipconfig getpacket en0 | grep "router" | sed "s/router/DHCP/"; }

function net() { ip; mac; dns; dhcp; }

# print the ip and mac address on terminal startup
print_ip; print_mac;



#-------------------------------------------------------------------
#     Other Aliases
#-------------------------------------------------------------------

alias profile="vim ~/.bash_profile"
alias sshmylink='ssh webadmin@mylink.byu.edu'
alias sshmylinkdb='ssh dbadmin@10.18.12.5'
alias www='cd /Library/WebServer/Documents'
alias msg="vim Dropbox/Shared\ Folders/RAW/.msg"
# http://bit.ly/igCErk
alias m='mvim --remote-silent'

#-------------------------------------------------------------------
#     Git Settings   http://goo.gl/FQ9sP
#-------------------------------------------------------------------
# Set git autocompletion and PS1 integration
if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
  . /usr/local/git/contrib/completion/git-completion.bash
fi
GIT_PS1_SHOWDIRTYSTATE=true

if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

# enable git unstaged indicators - set to a non-empty value
GIT_PS1_SHOWDIRTYSTATE="."
 
# enable showing of untracked files - set to a non-empty value
GIT_PS1_SHOWUNTRACKEDFILES="."
 
# enable stash checking - set to a non-empty value
GIT_PS1_SHOWSTASHSTATE="."
 
# enable showing of HEAD vs its upstream
GIT_PS1_SHOWUPSTREAM="auto"



#-------------------------------------------------------------------
#     Colors
#-------------------------------------------------------------------

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)



#-------------------------------------------------------------------
#     Command Prompt Styling
#-------------------------------------------------------------------


#PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ ' 

#Taken from: http://goo.gl/nCOf4
# export TERM="xterm-color"
PS1="\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] "



#Taken from: http://goo.gl/rHqNu
 

 
# return the prompt prefix for the second line based on whether or not you’re in a git branch
function set_prefix {
    BRANCH=`__git_ps1`
    if [[ -z $BRANCH ]]; then
        echo "${NORMAL}o"
    else
        echo "${UNDERLINE}+"
    fi
}
 
# set the prompt to show current working directory and git branch name, if it exists (similar to Paul Irish's)

# add date to the prompt
PS1='${MAGENTA}\u${WHITE} in ${GREEN}\w${WHITE}${MAGENTA}`__git_ps1 " on %s"`${WHITE}\r\n${CYAN}(`date "+%a, %b %d"`) ${WHITE}`set_prefix`${NORMAL} '

# same as above, but without the date
# PS1='${MAGENTA}\u${WHITE} in ${GREEN}\w${WHITE}${MAGENTA}`__git_ps1 " on %s"`${WHITE}\r\n${WHITE}`set_prefix`${NORMAL} '
