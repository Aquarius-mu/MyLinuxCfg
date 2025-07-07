# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto | grep -v svn'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

alias vi='vim'
export LANG=zh_CN.UTF-8
alias grepc='find . -name "*.[ch]" -o -name "*.cpp" | xargs grep --color="auto"'
alias greph='find . -name "*.h" | xargs grep --color="auto"'
alias grepl='find . -name "*.lua" | xargs grep --color="auto"'
alias grepp='find . -name "*.proto" | xargs grep --color="auto"'
alias grepx='find . -name "*.xml" | xargs grep --color="auto"'
alias maketags='ctags -R 2>/dev/null'
alias grep='grep --color'
alias grepr='grep --exclude-dir=.svn --exclude=tags --color -RIn'
alias l='ls -alFv --color=auto'
alias ll='ls -lv --color=auto'
alias ll.='ls -lv --color=auto -d .*'
alias lh='l -h'
alias rz='rz -b'
alias sz='sz -b'
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac
