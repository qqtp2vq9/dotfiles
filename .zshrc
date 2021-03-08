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

export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME

export RUBYLIB=$RUBYLIB:$RSPEC_RUBYLIB
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/git/bin:$PATH:$GOROOT/bin:$GOPATH/bin"
export PATH=$PATH:$RSPEC_PATH
export PATH="/Library/Frameworks/Mono.framework/Versions/current/bin:$PATH"
export PATH="$HOME/work/pulsar/apache-pulsar-2.1.1-incubating/bin:$PATH"

# Example aliases
alias g='git'
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

## pet
function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

# env

## nodenv
export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock
export PATH="$HOME/.nodenv/bin:$HOME/.nodenv/shims:$HOME/.nodenv/versions/12.8.0/bin:$PATH"
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

## rust tools
eval "$(zoxide init zsh)"
eval "$(mcfly init zsh)"

export PYTHONPATH="$PYTHONPATH:/usr/local/bin:$HOME/Library/Python/3.9/lib/python/site-packages:$HOME/Library/Python/3.9/bin"
export PKG_CONFIG_PATH="/usr/local/opt/qt/lib/pkgconfig"

# パス重複排除
typeset -U path PATH
path=(
    # allow directories only (-/)
    # reject world-writable directories (^W)
    $path(N-/^W)
)

