#
# zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -xA --group-directories-first --color=auto'
alias ip='ip -color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias mv='mv -iv '
alias rm='rm -iv '
alias cp='cp -iv '
alias du='du -h'
alias df='df -h'
alias fcd='cd $(find -type d | fzf)'
alias open='xdg-open $(find -type f | fzf)'
alias yt='mov-cli -s yt '
 


autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[magenta]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history


# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line


# Load syntax highlighting; should be last.
source /home/olly/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# bun ckkjompletions
[ -s "/home/olly/.bun/_bun" ] && source "/home/olly/.bun/_bun"

# Created by `pipx` on 2025-03-18 19:32:36
export PATH="$PATH:/home/olly/.local/bin"
