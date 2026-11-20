# メグルメ 開発環境

Vue 3 + JavaScriptのフロントエンド、Laravel JSON API、MySQLを使う開発環境です。**GitHub Desktopでクローンし、VS Codeで「Reopen in Container」を選ぶと環境を自動準備して開きます。ターミナルでの初期設定は基本的に不要です。**

## 最初に一度だけ入れるもの

- [GitHub Desktop](https://desktop.github.com/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Visual Studio Code](https://code.visualstudio.com/)
- VS Code拡張機能 **Dev Containers**（Microsoft / `ms-vscode-remote.remote-containers`）

Docker Desktopを起動しておきます。

## クローンから起動まで

1. GitHub Desktopにサインインします。
2. **File → Clone repository...** を選び、URLに次を入力してCloneします。

   ```text
   https://github.com/maruchandev/megurume.git
   ```

3. GitHub Desktopの **Open in Visual Studio Code** を押します。
4. VS Codeに「Reopen in Container」と表示されたら選びます。表示されない場合は、`F1`または`Ctrl+Shift+P`を押して **Dev Containers: Reopen in Container** を選びます。
5. 初回はコンテナ作成、Laravelの準備、npm依存関係の取得に数分かかります。ブラウザーで`http://localhost:5173`を開きます。ブラウザーは自動起動しない設定です。

通常はここまでです。以後はGitHub Desktopからリポジトリを開き、VS Codeの案内に従ってコンテナで開きます。コンテナ停止時はVS Codeを閉じるか、コマンドパレットから **Dev Containers: Reopen Folder Locally** を選びます。

## 開くURL

- フロントエンド：<http://localhost:5173>
- Laravel API：<http://localhost:8000>
- MySQL：コンテナ内では`db:3306`、ホストからは`localhost:3306`

トップ画面の「API接続を確認」でAPIの疎通を確認できます。

## 普段の作業

- Vue画面を編集するとViteが自動反映します。
- Laravel APIのコードは`backend`フォルダーにあります。
- DBデータはDockerボリュームに保存され、通常の停止では消えません。
- GitHub Desktopで変更を確認し、Commit、Pushします。

VS Code内のターミナルを使う場合も、すでにコンテナ内です。`backend`のartisanや`frontend`のnpmをホスト側へインストールする必要はありません。

## DBデータを消して初期化する

通常は不要です。DBを完全にリセットする場合のみ、VS Codeのターミナルで次を実行します。

```bash
docker compose down -v
```

この操作は保存済みの開発DBデータを削除します。次にコンテナを開いた時にMySQLボリュームが再作成されます。

## 開発環境の構成

- `.devcontainer/devcontainer.json`：VS Codeが使うコンテナ、拡張機能、自動セットアップ
- `compose.yaml`：PHP/Laravel、Vue/Vite、MySQLサービス
- `.devcontainer/post-create.sh`：初回のLaravel準備、APIルート準備、アプリキー生成
- `frontend/`：Vue 3 + JavaScript + Vite
- `backend/`：Laravel 12 JSON API

初回セットアップではLaravel 12とSanctum API基盤を用意します。認証方式や業務APIの仕様は別途確定してください。`.env`、`vendor`、`node_modules`はGitに登録しません。

## うまく起動しない場合

- Docker Desktopが起動しているか確認します。
- `.devcontainer`または`compose.yaml`を変更した後は、コマンドパレットの **Dev Containers: Rebuild Container** を選びます。
- `5173`、`8000`、`3306`番ポートを他アプリが使用中なら、ポート設定を変更します。
- 初回セットアップが途中で止まったときは、VS Codeの **表示 → 出力** を開き、出力先で **Dev Containers** を選んでエラーを確認します。
