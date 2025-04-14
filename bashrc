# ~/.bashrc
# Made by Sam Rohrbach
# Licensed under the GPL v3 license

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='\u@\h \W \$ ' # prompt

### normal linux ###
# C-u to clear input to left
# C-k to clear input to right
# C-l to clear screen
# C-d to exit
bind -x '"\e[1;3D": "cd $OLDPWD"' # M-left goes back to previous directory

# doom emacs
export PATH=”$HOME/.config/emacs/bin:$PATH”
alias doom='~/.config/emacs/bin/doom'

# i <3 nerd fonts :)
alias l='lsd -A --color=auto'
alias ls='lsd -A --color=auto'
alias dir='lsd -A --color=auto'

alias rmr='rm -r' # do not misuse, especially with /
alias rmrf='rm -rf' # do not misuse, especially with /
alias cpr='cp -r' 
alias cprf='cp -rf' 
alias touchdir='mkdir' # touch, but not with files
alias md='mkdir' # less chars == better

alias grep='grep --color=auto'
alias gerp='grep --color=auto'

alias please='sudo' # canada moment
# me not being good at typing
alias sud='sudo'
alias sudi='sudo'
alias sido='sudo'
alias suod='sudo'
alias sduo='sudo'
alias soud='sudo'
alias sudp='sudo'
alias sudio='sudo'
alias suido='sudo'

# for when C-l is just too much
alias cls='clear'
alias csl='clear'
alias celar='clear'

alias mount='sudo mount' # bruh why do i keep forgetting the sudo
alias umount='sudo umount' # not a word
alias unmount='sudo umount' # is a word

alias cd..='cd ..'
alias ..='cd ..'

alias kys='shutdown now' # i know
alias die='shutdown now' # see previous line
 
alias rtfm='man' # read it

alias EXIT='exit' # cAPSLOCK MOMENT
# still bad at typing
alias exiy='exit'
alias exir='exit'
alias exirt='exit'
# vim
alias :q='exit'
alias :Q='exit'

# i am speed
alias clone='gh repo clone'
alias commit='git add *; git commit'
alias push='git push'
alias pull='git pull'

### arch-specififc ###
alias showoff='clear;echo;neofetch' # oh yeah i use arch
# we have apt at home
alias autoremove='yay -R $(yay -Qdtq); flatpak remove --unused; yay -Scc' # apt at home
alias btw='figlet I use Arch BTW'
# go quick, do typos
alias udpate='update'
alias updtae='update'
alias updaet='update'

### misc ###
alias yt='ytfzf'
alias youtube='ytfzf'

alias lock='swaylock'
alias lokc='swaylock'

alias py='python'

alias unixkcd='xkcd'

alias clac='calc'

alias uwu='clear;uwufetch'

alias matrix='cmatrix -C red'

alias cat-img='kitty +kitten icat'

alias dei='echo "...is good! Run command \"die\" instead. "' # put elongated muskrat on starship anda activate fts

# other things
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
