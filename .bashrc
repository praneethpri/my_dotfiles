#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

[[ -f ~/.welcome_screen ]] && . ~/.welcome_screen

_set_liveuser_PS1() {
    PS1='\u@\h * {\W} :- '
    if [ "$(whoami)" = "liveuser" ] ; then
        local iso_version="$(grep ^VERSION= /usr/lib/endeavouros-release 2>/dev/null | cut -d '=' -f 2)"
        if [ -n "$iso_version" ] ; then
            local prefix="eos-"
            local iso_info="$prefix$iso_version"
            PS1="\u@$iso_info * {\W} :- "
        fi
    fi
}
_set_liveuser_PS1
unset -f _set_liveuser_PS1

ShowInstallerIsoInfo() {
    local file=/usr/lib/endeavouros-release
    if [ -r $file ] ; then
        cat $file
    else
        echo "Sorry, installer ISO info is not available." >&2
    fi
}


alias ls='ls --color=auto'
alias ll='ls -lav --ignore=..'   # show long listing of all except ".."
alias l='ls -lav --ignore=.?*'   # show long listing but no hidden dotfiles except "."

[[ "$(whoami)" = "root" ]] && return

[[ -z "$FUNCNEST" ]] && export FUNCNEST=100          # limits recursive functions, see 'man bash'

## Use the up and down arrow keys for finding a command in history
## (you can write some initial letters of the command first).
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'

######
export MANPAGES='nvim +Man!'
export EDITOR='emacs -nw'

################################################################################
## Some generally useful functions.
## Consider uncommenting aliases below to start using these functions.
##
## October 2021: removed many obsolete functions. If you still need them, please look at
## https://github.com/EndeavourOS-archive/EndeavourOS-archiso/raw/master/airootfs/etc/skel/.bashrc

_open_files_for_editing() {
    # Open any given document file(s) for editing (or just viewing).
    # Note1:
    #    - Do not use for executable files!
    # Note2:
    #    - Uses 'mime' bindings, so you may need to use
    #      e.g. a file manager to make proper file bindings.

    if [ -x /usr/bin/exo-open ] ; then
        echo "exo-open $@" >&2
        setsid exo-open "$@" >& /dev/null
        return
    fi
    if [ -x /usr/bin/xdg-open ] ; then
        for file in "$@" ; do
            echo "xdg-open $file" >&2
            setsid xdg-open "$file" >& /dev/null
        done
        return
    fi

    echo "$FUNCNAME: package 'xdg-utils' or 'exo' is required." >&2
}

#------------------------------------------------------------

## Aliases for the functions above.
## Uncomment an alias if you want to use it.
##

# alias ef='_open_files_for_editing'     # 'ef' opens given file(s) for editing
# alias pacdiff=eos-pacdiff
################################################################################

##########################
######   ALIASES  ########
##########################
alias ..='cd ..'
alias ...='cd ../..'
alias ~='cd ~'
alias cls='clear'
alias r='ranger'
alias escl="xmodmap -e 'clear lock'"
alias e='emacs -nw'
alias mv='mv -v'
alias cp='cp -v'
alias menu='xfce4-terminal --show-menubar'
alias upd='sudo pacman -Syu --noconfirm'
alias ins='sudo pacman -S --noconfirm'
alias ser='pacman -Ss'
alias xcopy='xclip -selection clipboard'
alias medgeL='synclient AreaLeftEdge=150'
alias medgeR='synclient AreaRightEdge=1700'
alias gp='gpointing-device-settings'
alias gitpy='python ~/projects/python3/gitpy.py'


##########################
#####  NODE & NPM  #######
##########################
export PATH=~/.npm-global/bin:$PATH
alias vite='npm create vite@latest'
#eval "$(starship init bash)"


# Load Angular CLI autocompletion.
source <(ng completion script)


##-----------------------------------------------------
## synth-shell-greeter.sh
#if [ -f /home/praneethp/.config/synth-shell/synth-shell-greeter.sh ] && [ -n "$( echo $- | grep i )" ]; then
#	source /home/praneethp/.config/synth-shell/synth-shell-greeter.sh
#fi

##-----------------------------------------------------
## synth-shell-prompt.sh
if [ -f /home/praneethp/.config/synth-shell/synth-shell-prompt.sh ] && [ -n "$( echo $- | grep i )" ]; then
	source /home/praneethp/.config/synth-shell/synth-shell-prompt.sh
fi

##-----------------------------------------------------
## better-ls
if [ -f /home/praneethp/.config/synth-shell/better-ls.sh ] && [ -n "$( echo $- | grep i )" ]; then
	source /home/praneethp/.config/synth-shell/better-ls.sh
fi

##-----------------------------------------------------
## alias
if [ -f /home/praneethp/.config/synth-shell/alias.sh ] && [ -n "$( echo $- | grep i )" ]; then
	source /home/praneethp/.config/synth-shell/alias.sh
fi

##-----------------------------------------------------
## better-history
if [ -f /home/praneethp/.config/synth-shell/better-history.sh ] && [ -n "$( echo $- | grep i )" ]; then
	source /home/praneethp/.config/synth-shell/better-history.sh
fi

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH
eval "$(zoxide init bash)"

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[ -f /home/praneethp/projects/node/node_and_express/test_electron_app/my_app/node_modules/tabtab/.completions/electron-forge.bash ] && . /home/praneethp/projects/node/node_and_express/test_electron_app/my_app/node_modules/tabtab/.completions/electron-forge.bash
