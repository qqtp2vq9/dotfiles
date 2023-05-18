set SDKMAN_DIR "$HOME/.sdkman"
if test -s "$HOME/.sdkman/bin/sdkman-init.sh"
  bass source "$HOME/.sdkman/bin/sdkman-init.sh"
end

#### Java
set -gx JAVA_HOME "$SDKMAN_DIR/candidates/java/current/"

### Example aliases
alias g='git'
alias gfp='git fetch --prune'
alias v='nvim'
alias sv='sudo nvim'
alias l='lsd -la'

## コマンド代替え
alias ls='lsd'
alias cat='bat'
alias vim='nvim'
alias pip='pip3'

## ssh-add
set -x SSH_AGENT_FILE $HOME/.ssh/ssh-agent
if test -f $SSH_AGENT_FILE
   source $SSH_AGENT_FILE
end

### 先にコマンドを実行して $status をif文で評価
ssh-add -l > /dev/null ^&1
if test $status -ne 0
  #### ssh-agent に -c オプションを追加 (csh-style)
  ssh-agent -c > $SSH_AGENT_FILE
  source $SSH_AGENT_FILE
  sshadd
end

### fzf.fish
fzf_configure_bindings --directory=\cf

### ghq.fish
set -gx GHQ_SELECTOR peco

### path
set -gx PATH "/opt/homebrew/sbin:/opt/homebrew/bin:$JAVA_HOME/bin:$HOME/.cargo/bin:$HOME/.volta/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:/Library/Apple/usr/bin" PATH

# volta
set -gx VOLTA_HOME "$HOME/.volta"

### homebrew
if test -d (brew --prefix)"/share/fish/completions"
  set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/completions
end

if test -d (brew --prefix)"/share/fish/vendor_completions.d"
  set -gx fish_complete_path $fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
end

## starship prompt
starship init fish | sourcett
