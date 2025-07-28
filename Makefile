# mac-setup/Makefile
# ------------------------------------------------------------
# 使い方:
#   make            → Homebrew & Brewfile セットアップ
#   make dotfiles   → dotfiles (GNU Stow) のリンク展開
#   make all        → Homebrew + dotfiles
#   make xcode      → Xcode (Brewfile.xcode) だけ
# ------------------------------------------------------------

# --- 変数 --------------------------------------------------------------
BREWFILE        ?= Brewfile
BREWFILE_XCODE  ?= Brewfile.xcode
DOTFILES_DIR    ?= dotfiles            # dotfiles ルート
DOTFILES_MODULES?= zsh tmux            # stow するディレクトリ (スペース区切り)

# --- 既定ターゲット ----------------------------------------------------
.PHONY: setup
setup:
	@$(MAKE) _bundle BREWFILE=$(BREWFILE)

# --- dotfiles 展開 -----------------------------------------------------
.PHONY: dotfiles
ifneq (,$(wildcard $(DOTFILES_DIR)))
dotfiles: _ensure_stow
	@echo "▶︎ Linking dotfiles with stow ($(DOTFILES_MODULES))"; \
	stow -d $(DOTFILES_DIR) -t $(HOME) $(DOTFILES_MODULES)
else
dotfiles:
	@echo "⚠️  $(DOTFILES_DIR) ディレクトリが見つかりません。スキップしました。"
endif

# --- Xcode 用 ----------------------------------------------------------
.PHONY: xcode
xcode:
	@$(MAKE) _bundle BREWFILE=$(BREWFILE_XCODE)

# --- すべて ------------------------------------------------------------
.PHONY: all
all: setup dotfiles

# --- 内部ロジック: Homebrew + brew bundle -----------------------------
.PHONY: _bundle
_bundle:
	@echo "▶︎ Checking / installing Homebrew…"; \
	if ! command -v brew >/dev/null 2>&1; then \
	  echo "▶︎ Installing Homebrew …"; \
	  /bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	fi; \
	# PATH 反映 (Apple Silicon / Intel 共通) \
	if [ -x /opt/homebrew/bin/brew ]; then eval "$$(/opt/homebrew/bin/brew shellenv)"; fi; \
	if [ -x /usr/local/bin/brew ];  then eval "$$(/usr/local/bin/brew shellenv)";  fi; \
	echo "▶︎ Running brew bundle --file $(BREWFILE)"; \
	brew bundle --file "$(BREWFILE)"; \
	echo "✅ Brew bundle completed";

# --- stow インストール -------------------------------------------------
.PHONY: _ensure_stow
_ensure_stow:
	@if ! command -v stow >/dev/null 2>&1; then \
	  echo "▶︎ Installing GNU Stow (missing)"; \
	  brew install stow; \
	fi
