```fish
if status is-interactive
    # Commands to run in interactive sessions can go here
    eval (/opt/homebrew/bin/brew shellenv)
end

# ghq + peco
function ghq_peco_repo
  set selected_repository (ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_repository" ]
    cd $selected_repository
    echo " $selected_repository "
    commandline -f repaint
  end
end

# fish key bindings
function fish_user_key_bindings
  bind \cg ghq_peco_repo
end

status --is-interactive; and /opt/homebrew/bin/rbenv init - fish | source
set -x DENO_INSTALL "/Users/k.takahashi/.deno"
direnv hook fish | source

set -gx HOMEBREW_GITHUB_API_TOKEN ghp_*************************
set -x OP_BIOMETRIC_UNLOCK_ENABLED true
```
