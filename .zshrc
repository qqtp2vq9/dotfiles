#
# Executes commands at the start of an interactive session.
#
# 履歴ファイルの保存先
export HISTFILE=${HOME}/.zsh_history

# メモリに保存される履歴の件数
export HISTSIZE=4000

# 履歴ファイルに保存される履歴の件数
export SAVEHIST=300000

setopt hist_ignore_all_dups  # 重複するコマンド行は古い方を削除
setopt hist_ignore_dups      # 直前と同じコマンドラインはヒストリに追加しない
setopt share_history         # コマンド履歴ファイルを共有する
setopt append_history        # 履歴を追加 (毎回 .zsh_history を作るのではなく)
setopt inc_append_history    # 履歴をインクリメンタルに追加
setopt hist_no_store         # historyコマンドは履歴に登録しない
setopt hist_reduce_blanks    # 余分な空白は詰めて記録

# 失敗は記録しない
__record_command() {
  typeset -g _LASTCMD=${1%%$'\n'}
  return 1
}
zshaddhistory_functions+=(__record_command)

__update_history() {
  local last_status="$?"

  local HISTFILE=~/.zsh_history
  fc -W
  if [[ ${last_status} -ne 0 ]]; then
    ed -s ${HISTFILE} <<EOF >/dev/null
d
w
q
EOF
  fi
}
precmd_functions+=(__update_history)

# 開始と終了を記録
setopt EXTENDED_HISTORY

export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# anyframe
# http://qiita.com/mollifier/items/81b18c012d7841ab33c3
zplug "mollifier/anyframe"
bindkey '^xa' anyframe-widget-select-widget
bindkey '^x^a' anyframe-widget-select-widget

zplug "b4b4r07/enhancd", use:init.sh
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"

zplug "zsh-users/zsh-completions"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi
zplug load

## peco
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

## fzf
function select-history() {
  BUFFER=$(history -n -r 1 | fzf --no-sort +m --query "$LBUFFER" --prompt="History > ")
  CURSOR=$#BUFFER
}
zle -N select-history
bindkey '^r' select-history

export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME

export RUBYLIB=$RUBYLIB:$RSPEC_RUBYLIB
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/git/bin:$PATH:$GOROOT/bin:$GOPATH/bin"
export PATH=$PATH:$RSPEC_PATH
export PATH="/Library/Frameworks/Mono.framework/Versions/current/bin:$PATH"
export PATH="$HOME/work/pulsar/apache-pulsar-2.1.1-incubating/bin:$PATH"

# Example aliases
alias gfp='git fetch --prune'
alias v='nvim'
alias sv='sudo nvim'
alias l='exa -lha'

export PATH="/usr/local/opt/icu4c/sbin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/e2fsprogs/bin:$PATH"
export PATH="/usr/local/opt/e2fsprogs/sbin:$PATH"
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/Cellar/yarn/1.21.1/bin:/usr/local/Cellar/yarn/1.21.1/libexec/bin:$PATH"
export MONO_GAC_PREFIX="/usr/local"

export LANG=ja_JP.UTF-8

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/opt/php@7.1/bin:$HOME/bin:$PATH"

# highlight
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

# homebrew
alias brew="PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin brew"

# Set Spaceship ZSH as a prompt
eval "$(starship init zsh)"

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
 
show_buffer_stack() {
  POSTDISPLAY="
stack: $LBUFFER"
  zle push-line-or-edit
}
zle -N show_buffer_stack

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

## pet
function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

## nodenv
export PATH="$HOME/.nodenv/bin:$HOME/.nodenv/shims:$PATH"
eval "$(nodenv init -)"

## jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

export PS1="$NEWLINE${COLOR_USER_CURRENT_STATE}$WORKING_DIRECTORY$NEWLINE${COLOR_STATEMENT}$PROMPT_SYMBOL${COLOR_RESET} $ "
export PATH="/usr/local/opt/cython/bin:$PATH"

export ORACLE_HOME=$HOME/tools/sqlplus/instantclient_19_8
export PATH=${ORACLE_HOME}:${PATH}
export PATH=/opt/cisco/anyconnect/bin:$PATH
export BPCTL_V2_DEFAULT=true

eval "$(zoxide init zsh)"
export PYTHONPATH="$PYTHONPATH:/usr/local/bin:$HOME/Library/Python/3.9/lib/python/site-packages:$HOME/Library/Python/3.9/bin"
export PKG_CONFIG_PATH="/usr/local/opt/qt/lib/pkgconfig"

# パス重複排除
typeset -U path PATH
path=(
    # allow directories only (-/)
    # reject world-writable directories (^W)
    $path(N-/^W)
)

export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock
if [ ! -S ~/.ssh/ssh_auth_sock ]; then
  eval `ssh-agent`
  ln -sf "$SSH_AUTH_SOCK" $HOME/.ssh/ssh_auth_sock
  ssh-add $HOME/.ssh/id_rsa

  # completions
  if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
    spk-cli completion zsh > ${fpath[1]}/_spk-cli

    autoload -Uz compinit
    compinit
  fi
fi

