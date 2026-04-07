# dotfiles

macOS 向けの開発環境設定ファイル一式。

## 含まれるもの

| ファイル / ディレクトリ | 内容 |
| --- | --- |
| `_zshrc/` | Zsh 設定（PATH, エイリアス, プロンプト, プラグイン, 履歴など） |
| `.config/nvim/` | Neovim 設定（LSP, プラグイン管理は vim-plug） |
| `.config/sheldon/` | Zsh プラグインマネージャ sheldon の設定 |
| `.config/ghostty/` | Ghostty ターミナルの設定 |
| `.config/karabiner/` | Karabiner-Elements のキーマッピング |
| `.tmux.conf` | tmux 設定（prefix=C-q, vim キーバインド, コピーモード） |
| `.vimrc` | Vim 設定（Neovim の設定に委譲） |
| `.tigrc` | tig のカスタムキーバインド |
| `.clang-format` | C/C++ フォーマッタ設定（Google スタイルベース） |
| `.gitignore_global` | グローバル gitignore |
| `Brewfile` | Homebrew で管理するパッケージ・アプリ一覧 |
| `AGENTS.md` | AI コーディングエージェント向けの共通ルール |
| `deploy.sh` | セットアップスクリプト |

## セットアップ

```bash
cd && git clone https://github.com/adshidtadka/dotfiles.git && ./dotfiles/deploy.sh
```

`deploy.sh` は以下を実行する:

1. ドットファイルをホームディレクトリにシンボリックリンク
2. `.config/` 配下の設定を `~/.config/` にリンク
3. テーマカラーの選択（デフォルト: green）
4. `_zshrc/deploy.sh` で `.zshrc` を生成
5. `AGENTS.md` を Claude / Codex / Cursor 用の設定ファイルとしてリンク
6. Git のグローバル設定（エディタ, excludesfile, color など）

## Homebrew パッケージの同期

```bash
brew bundle --file=~/dotfiles/Brewfile
```

現在の環境から Brewfile を更新する場合:

```bash
brew bundle dump --file=~/dotfiles/Brewfile --force
```

## Zsh の構成

`_zshrc/` 配下のスクリプトが番号順に `.zshrc` へ読み込まれる:

| ファイル | 内容 |
| --- | --- |
| `01_paths.sh` | PATH やランタイム環境の設定 |
| `02_aliases.sh` | Git / Docker / kubectl 等のエイリアス、peco 連携 |
| `03_prompt.sh` | プロンプト表示（ユーザー名, IP, Git ブランチ, 時刻） |
| `04_settings.sh` | sheldon, 履歴設定 |

## 主なキーバインド

### Zsh

| キー | 機能 |
| --- | --- |
| `Ctrl-W Ctrl-W` | zoxide + peco でディレクトリ移動 |
| `Ctrl-W Ctrl-H` | peco で履歴検索 |
| `Ctrl-W Ctrl-G` | ghq + peco でリポジトリ移動 |
| `Ctrl-W Ctrl-B` | peco でブランチ選択 |
| `Ctrl-W Ctrl-A` | peco で AWS プロファイル選択 |

### tmux (prefix: `C-q`)

| キー | 機能 |
| --- | --- |
| `h/j/k/l` | ペイン移動 |
| `H/J/K/L` | ペインリサイズ |
| `\|` / `-` | 縦分割 / 横分割 |
| `e` / `E` | ペイン同期 ON / OFF |
| `=` | ペイン幅均等化 |
