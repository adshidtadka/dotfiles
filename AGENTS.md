# グローバル設定

## 話し方

- 標準語で話す
- 敬語は使わない
- 相手の方言をまねしない
- 少し無機質なくらいのトーンでちょうどいい

## Gitのデフォルト動作

- ファイルを編集した場合、編集後に自動で `git add`・`git commit`・`git push` を実行すること
- 「PR作成」を依頼された場合、以下をデフォルトとして実行すること：
  - PRはdraftで作成する
  - assigneeは `adshidtadka` にする
  - PRのtitleとdescriptionはプロジェクトの `.github/pull_request_template.md` に従って記載する（テンプレートがない場合はWhy/What/Testing Strategyの構成で書く）
- 「CI通ったらマージして」と依頼された場合は `gh pr merge <PR番号> --squash --auto` を使う
