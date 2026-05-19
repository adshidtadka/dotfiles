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

### Neovim

#### ノーマルモード（移動・編集）

| キー | 機能 |
| --- | --- |
| `Ctrl-h` | 行頭（`^`）へ移動 |
| `Ctrl-l` | 行末（`$`）へ移動 |
| `j` / `k` | 表示行単位で上下移動（折り返し対応） |
| `gj` / `gk` | 論理行単位で上下移動 |

#### ファイルパス

| キー | 機能 |
| --- | --- |
| `Space cp` | 相対パスをクリップボードにコピー |
| `Space cP` | 絶対パスをクリップボードにコピー |

#### タブ（prefix: `\t`）

| キー | 機能 |
| --- | --- |
| `\t1` ~ `\t9` | n 番目のタブへジャンプ |
| `\tc` | 新しいタブを右端に作成 |
| `\tx` | タブを閉じる |
| `\tl` / `\th` | 次 / 前のタブへ移動 |
| `\tml` / `\tmh` | タブを右 / 左に移動 |

#### ファイルツリー・検索（fzf / fern）

| キー | 機能 |
| --- | --- |
| `Ctrl-y t` | Fern（ファイルツリー）をドロワーで開く |
| `Ctrl-k f` | fzf でファイル検索（`rg --files`） |
| `Ctrl-k rg` | fzf + ripgrep でグレップ検索 |
| `Ctrl-k rd` | fzf + ripgrep で大文字小文字無視グレップ |

#### Git（vim-gin）

| キー | 機能 |
| --- | --- |
| `Ctrl-k gs` | `GinStatus` |
| `Ctrl-k gd` | `GinDiff` |
| `Ctrl-k gl` | `GinLog` |
| `Ctrl-k gb` | `GinBranch` |
| `Ctrl-g` | `GinBrowse`（ノーマル / ビジュアル） |

#### LSP

| キー | 機能 |
| --- | --- |
| `gd` | 定義へジャンプ |
| `gr` | 参照一覧 |
| `K` | ホバードキュメント |
| `\rn` | リネーム |
| `\ca` | コードアクション |
| `\e` | 診断メッセージをフロートで表示 |
| `\q` | 診断一覧を loclist に表示 |

#### AI（CodeCompanion）

| キー | 機能 |
| --- | --- |
| `Ctrl-a` | CodeCompanion アクション一覧（ノーマル / ビジュアル） |
| `\cc` | CodeCompanion チャットのトグル |
| `ga`（ビジュアル） | 選択範囲をチャットに追加 |

#### コマンドライン

| キー | 機能 |
| --- | --- |
| `Ctrl-p` / `Ctrl-n` | 履歴の前 / 次 |
| `Ctrl-f` / `Ctrl-b` | 右 / 左へ移動 |
| `Ctrl-a` / `Ctrl-e` | 行頭 / 行末 |
| `Ctrl-d` | 1文字削除 |

### tmux (prefix: `C-q`)

#### ペイン操作

| キー | 機能 |
| --- | --- |
| `h` / `j` / `k` / `l` | ペイン移動（vim 式） |
| `H` / `J` / `K` / `L` | ペインリサイズ（リピート可） |
| `\|` | 縦分割（カレントディレクトリ引き継ぎ） |
| `-` | 横分割（カレントディレクトリ引き継ぎ） |
| `%` / `"` | 縦分割 / 横分割（デフォルトキー、同じくディレクトリ引き継ぎ） |
| `=` | ペイン幅を均等化 |
| `e` | ペイン同期 ON（ステータスバーが赤くなる） |
| `E` | ペイン同期 OFF |

#### ウィンドウ

| キー | 機能 |
| --- | --- |
| `c` | 新しいウィンドウ（カレントディレクトリ引き継ぎ） |

#### コピーモード（vi キーバインド）

| キー | 機能 |
| --- | --- |
| `v` | 選択開始 |
| `V` | 行選択 |
| `Ctrl-v` | 矩形選択 |
| `y` | ヤンク（`pbcopy` へコピー） |
| `Y` | 行ヤンク |
| `y i w` | ワード単位でヤンク |
| `y i W` | WORD 単位でヤンク |
| `y i "` | `"..."` 内をヤンク |
| `y y` | 行ヤンク（Vim 互換） |
| `i w` | ワード選択（ヤンクせず） |
| `i W` | WORD 選択（ヤンクせず） |
| `i "` | `"..."` 内を選択（ヤンクせず） |
| `Ctrl-h` / `Ctrl-l` | 行頭 / 行末へ移動 |
