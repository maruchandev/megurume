#!/usr/bin/env bash
set -euo pipefail

cd /workspace/backend

if [ ! -f vendor/autoload.php ]; then
  echo "Laravelの依存関係が未準備です。Dev Containerの初回セットアップを確認してください。"
  exit 1
fi

pid_file=/tmp/megurume-api.pid
if [ -f "$pid_file" ] && kill -0 "$(cat "$pid_file")" 2>/dev/null; then
  exit 0
fi

nohup php artisan serve --host=0.0.0.0 --port=8000 >/tmp/megurume-api.log 2>&1 &
echo $! > "$pid_file"
