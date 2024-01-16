#!/usr/bin/zsh

# oh-my-zsh のインストール
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 設定に使うパッケージ追加
apt-get install -y zsh-syntax-highlighting zsh-autosuggestions peco

# zsh-completions のインストールと設定追加
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
if [ -f "$HOME/.zshrc" ]; then
  echo "fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src" | cat - $HOME/.zshrc > temp && mv temp $HOME/.zshrc
fi

# powerlevel10k のインストール
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Powerlevel10k の設定ダウンロード
curl -L -o ~/.p10k.zsh https://gist.githubusercontent.com/kappa4/0ff1ea6db5cbba56216bd3338a6d519b/raw/4d08f2317d4d6d14c5190f270f971dd5f5bfb5a6/.p10k.zsh

# .zshrc へ Powerlevel10kの設定を追加
if [ -f "$HOME/.zshrc" ]; then
    echo "ZSH_THEME=\"powerlevel10k/powerlevel10k\"" >> $HOME/.zshrc
    echo "source ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k/powerlevel10k.zsh-theme" >> $HOME/.zshrc
    echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" >> $HOME/.zshrc
fi

# zsh-syntax-highlighting, zsh-autosuggestions, pecoの設定追加
if [ -f "$HOME/.zshrc" ]; then
    echo "source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> $HOME/.zshrc
    echo "source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" >> $HOME/.zshrc

    cat << 'EOF' >> $HOME/.zshrc
    function peco-select-history() {
      BUFFER=$(history -n -r 1 | peco --query "$LBUFFER")
      CURSOR=$#BUFFER
      zle clear-screen
    }
    zle -N peco-select-history
    bindkey '^r' peco-select-history
EOF
fi
