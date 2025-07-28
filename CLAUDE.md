# CLAUDE.md

このプロジェクトでClaude Codeを使用する際の情報をまとめています。

## プロジェクト概要

Mac初期セットアップ用のリポジトリです。Homebrewとdotfilesの管理を自動化しています。

## 主要ファイル

- `Makefile` - セットアップタスクを自動化するメインファイル
- `Brewfile` - Homebrew でインストールするパッケージリスト
- `Brewfile.xcode` - Xcode専用のBrewfile
- `dotfiles/` - GNU Stowで管理する設定ファイル群

## よく使うコマンド

```bash
# Homebrew & Brewfile のセットアップ
make

# dotfiles のリンク展開
make dotfiles

# すべて実行（Homebrew + dotfiles）
make all

# Xcode のみインストール
make xcode
```

## テスト/検証コマンド

```bash
# Homebrew のインストール状態確認
brew list

# Stow のリンク状態確認
stow -d dotfiles -t $HOME -n -v zsh tmux

# Brewfile の依存関係チェック
brew bundle check --file=Brewfile
```

## 注意事項

- HomebrewはApple Silicon/Intel両対応
- dotfilesはGNU Stowで管理（zsh, tmux）
- Mac App StoreアプリはmasでインストールされるためApple ID認証が必要