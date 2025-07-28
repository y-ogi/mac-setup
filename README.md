# mac-setup

新しいMacを素早くセットアップするための自動化スクリプト集です。

## 概要

このリポジトリは以下を自動化します：
- Homebrewのインストール
- 開発ツール・アプリケーションの一括インストール
- dotfilesの配置（zsh, tmux設定）

## 必要要件

- macOS (Apple Silicon / Intel対応)
- インターネット接続
- Apple ID（Mac App Storeアプリのインストール時）

## クイックスタート

```bash
# リポジトリのクローン
git clone https://github.com/[YOUR-USERNAME]/mac-setup.git
cd mac-setup

# すべてセットアップ（推奨）
make all

# または個別実行
make            # Homebrew + Brewfile
make dotfiles   # dotfilesのリンク
```

## 詳細な使い方

### Homebrewとアプリケーション

```bash
# Brewfileに記載されたパッケージをインストール
make
```

インストールされるもの:
- **GUI アプリ**: ChatGPT, Claude, iTerm2, Docker Desktop, Zed, Obsidian など
- **CLI ツール**: Docker CLI, AWS CLI, GitHub CLI, ffmpeg, asdf など
- **Mac App Store**: Paste, Drafts, Tailscale, Slack, Final Cut Pro など

### dotfiles管理

```bash
# GNU Stowでdotfilesをリンク
make dotfiles
```

管理対象:
- `zsh` - Zシェル設定
- `tmux` - ターミナルマルチプレクサ設定

### Xcode専用

```bash
# Xcodeのみインストール
make xcode
```

## ファイル構成

```
mac-setup/
├── Makefile          # メインの自動化スクリプト
├── Brewfile          # Homebrewパッケージリスト
├── Brewfile.xcode    # Xcode専用Brewfile
├── dotfiles/         # 設定ファイル群
│   ├── zsh/         # Zsh設定
│   └── tmux/        # tmux設定
├── CLAUDE.md        # Claude Code用ドキュメント
└── README.md        # このファイル
```

## カスタマイズ

### パッケージの追加/削除

`Brewfile`を編集して必要なパッケージを調整:

```ruby
# GUI アプリの追加
cask "your-app-name"

# CLI ツールの追加
brew "your-tool-name"

# Mac App Storeアプリの追加
mas "App Name", id: 123456789
```

### dotfilesモジュールの追加

1. `dotfiles/`に新しいディレクトリを作成
2. `Makefile`の`DOTFILES_MODULES`変数に追加

```makefile
DOTFILES_MODULES ?= zsh tmux vim  # vimを追加
```

## トラブルシューティング

### Homebrewがインストールされない

```bash
# 手動でHomebrewをインストール
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Apple Silicon Macでパスが通らない

```bash
# パスを手動で設定
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Mac App Storeアプリがインストールされない

- Apple IDでサインインしているか確認
- 該当アプリが日本のストアで利用可能か確認

## ライセンス

[ライセンスを選択してください]

## 貢献

プルリクエストを歓迎します。大きな変更の場合は、まずissueを開いて変更内容を相談してください。