#!/bin/bash

# 必要なパッケージのインストール
apt-get update && apt-get install -y vim curl git zsh 

# zshをデフォルトシェルとして設定
chsh -s $(which zsh)
