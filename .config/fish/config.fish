## env
set PYTHONPATH "$PYTHONPATH:/usr/local/bin:$HOME/Library/Python/3.9/lib/python/site-packages:$HOME/Library/Python/3.9/bin"
set GOROOT /usr/local/opt/go/libexec
set GOPATH $HOME
set RUBYLIB $RUBYLIB:$RSPEC_RUBYLIB
set -g fish_user_paths "/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/git/bin:$GOPATH/bin:$GOROOT/bin:$PYTHONPATH" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/coreutils/libexec/gnubin:$HOME/.cargo/bin" $fish_user_paths
set BPCTL_V2_DEFAULT true

## Example aliases

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
  ssh-add $HOME/.ssh/id_rsa
end

## starship prompt
starship init fish | source
