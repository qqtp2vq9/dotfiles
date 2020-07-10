#
# Executes commands at the start of an interactive session.
#
# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history

# メモリに保存される履歴の件数
export HISTSIZE=4000

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=300000

# 重複を記録しない
setopt hist_ignore_dups

# 開始と終了を記録
setopt EXTENDED_HISTORY

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# anyframe
# http://qiita.com/mollifier/items/81b18c012d7841ab33c3
zplug "mollifier/anyframe"
bindkey '^xa' anyframe-widget-select-widget
bindkey '^x^a' anyframe-widget-select-widget

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
bindkey '^[' peco-src

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
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin::/usr/local/git/bin::$PATH:$GOROOT/bin:$GOPATH/bin"
export PATH=$PATH:$RSPEC_PATH

# Example aliases
# alias zshconfig="mate ~/.zshrc"
alias gfp='git fetch --prune'
alias vim='nvim'
alias sv='sudo nvim'

export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/e2fsprogs/bin:$PATH"
export PATH="/usr/local/opt/e2fsprogs/sbin:$PATH"
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/Cellar/yarn/1.21.1/bin:/usr/local/Cellar/yarn/1.21.1/libexec/bin:$PATH"
export MONO_GAC_PREFIX="/usr/local"

export PYTHONPATH="$PYTHONPATH:~/.pyenv/versions/3.6.5/bin/python3.6"
export LANG=ja_JP.UTF-8

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/opt/php@7.1/bin:$PATH"

# mysqlenv
source ~/.mysqlenv/etc/bashrc

# s.sh
# https://github.com/ssh0/s.sh
export BROWSER=/Applications/Firefox.app
PATH=$HOME/.zsh/plugins/s.sh:$PATH
fpath=($HOME/.zsh/plugins/s.sh $fpath)

## Rust
export PATH="$HOME/.cargo/bin:$PATH"

# homebrew
alias brew="PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin brew"

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
eval "$(rbenv init -)"

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship

function getups() {
    if [ ! -x "`which cf`" ]; then
        echo "command cf is not undefined"
        return 1
    fi
    if [ ! -x "`which jq`" ]; then
        echo "command jq is not undefined"
        return 1
    fi
    if [ $# -ne 1 ]; then
        echo "Usage: getups <app_name>"
        return 1
    fi
    LANG=C cf env $1 | awk -v RS= -v ORS='\n\n' '/System-Provided:/' | awk 'BEGIN{lines=""}NR>1{lines=lines$0}END{print lines}' | jq .VCAP_SERVICES -c -M
}
 
function setcfenv2cb() {
  UPS=`getups $1`
  if [ $? = 1 ]; then
    echo "Error at getups"
    return 1;
  fi
  (
    echo "VCAP_SERVICES=$UPS"
    LANG=C cf env $1 | awk -v RS= -v ORS='\n\n' '/User-Provided:/' | awk '/./{print $0}' | awk -F ': ' 'NR>1 {sub(": ", "="); print $0}'
  ) | pbcopy
}

export PS1="$NEWLINE${COLOR_USER_CURRENT_STATE}$WORKING_DIRECTORY$NEWLINE${COLOR_STATEMENT}$PROMPT_SYMBOL${COLOR_RESET} $ "
export PATH="/usr/local/opt/cython/bin:$PATH"

if [[ -r "$(brew --prefix)/opt/mcfly/mcfly.zsh" ]]; then
  source "$(brew --prefix)/opt/mcfly/mcfly.zsh"
fi

if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" $HOME/.ssh/ssh_auth_sock
  ssh-add $HOME/.ssh/id_rsa
fi
export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock
