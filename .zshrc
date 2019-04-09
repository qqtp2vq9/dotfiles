#
# Executes commands at the start of an interactive session.
#
# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history

# メモリに保存される履歴の件数
export HISTSIZE=1000

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=100000

# 重複を記録しない
setopt hist_ignore_dups

# 開始と終了を記録
setopt EXTENDED_HISTORY

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# anyframe
# http://qiita.com/mollifier/items/81b18c012d7841ab33c3
zplug "mollifier/anyframe"

# enhancd
# https://github.com/b4b4r07/enhancd
zplug "b4b4r07/enhancd", use:"init.sh"

# spaceship-prompt
# https://github.com/denysdovhan/spaceship-prompt
zplug denysdovhan/spaceship-prompt, use:spaceship.zsh, from:github, as:theme 

# zsh-syntax-highlighting
# https://github.com/zsh-users/zsh-syntax-highlighting
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug load

peco-src() {
    local selected
    selected="$(ghq list --full-path | peco --query="$LBUFFER")"
    if [ -n "$selected" ]; then
        BUFFER="builtin cd $selected"
        zle accept-line
    fi
    # zle reset-prompt
}
zle -N peco-src
bindkey '^]' peco-src

function peco-branch () {
    local branch=$(git branch -a | peco | tr -d ' ' | tr -d '*')
    if [ -n "$branch" ]; then
      if [ -n "$LBUFFER" ]; then
        local new_left="${LBUFFER%\ } $branch"
      else
        local new_left="$branch"
      fi
      BUFFER=${new_left}${RBUFFER}
      CURSOR=${#new_left}
    fi
}
zle -N peco-branch
bindkey '^xb' peco-branch # C-x b でブランチ選択
bindkey '^x^b' peco-branch # C-x C-b でブランチ選択

export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME

export RUBYLIB=$RUBYLIB:$RSPEC_RUBYLIB
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/git/bin:$PATH:$GOROOT/bin:$GOPATH/bin"
export PATH=$PATH:$RSPEC_PATH
export PATH="/Library/Frameworks/Mono.framework/Versions/current/bin:$PATH"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
alias gfp='git fetch --prune'
alias sv='sudo nvim'
alias emacs='emacs -nw'

# cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# anyframe bindkey
bindkey '^xc' anyframe-widget-cdr
bindkey '^x^c' anyframe-widget-cdr

bindkey '^xr' anyframe-widget-execute-history
bindkey '^x^r' anyframe-widget-execute-history

bindkey '^xp' anyframe-widget-put-history
bindkey '^x^p' anyframe-widget-put-history

bindkey '^xg' anyframe-widget-cd-ghq-repository
bindkey '^x^g' anyframe-widget-cd-ghq-repository

bindkey '^xk' anyframe-widget-kill
bindkey '^x^k' anyframe-widget-kill

bindkey '^xi' anyframe-widget-insert-git-branch
bindkey '^x^i' anyframe-widget-insert-git-branch

bindkey '^xf' anyframe-widget-insert-filename
bindkey '^x^f' anyframe-widget-insert-filename

function agvim () {
  vim $(ag $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}

export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export PATH="/usr/local/opt/e2fsprogs/bin:$PATH"
export PATH="/usr/local/opt/e2fsprogs/sbin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH=$HOME/.nodebrew/current/bin:$PATH

export PYTHONPATH="$PYTHONPATH:~/.pyenv/versions/3.6.5/bin/python3.6"
export LANG=ja_JP.UTF-8

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/opt/php@7.1/bin:$PATH"

# s.sh
# https://github.com/ssh0/s.sh
export BROWSER=/Applications/Firefox.app
PATH=$HOME/.zsh/plugins/s.sh:$PATH
fpath=($HOME/.zsh/plugins/s.sh $fpath)

tmux list-sessions
