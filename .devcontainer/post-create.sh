#!/usr/bin/env bash
set -euo pipefail

cd /workspace/backend

if [ ! -f artisan ]; then
  echo "初回セットアップ: Laravel 12を準備しています..."
  composer create-project laravel/laravel:^12.0 /tmp/laravel --no-interaction
  cp -a /tmp/laravel/. /workspace/backend/
fi

cd /workspace/backend

echo "Composer依存関係を確認しています..."
composer install --no-interaction --prefer-dist

if [ ! -f .env ]; then
  cp .env.example .env
fi

set_env() {
  key="$1"
  value="$2"
  if grep -q "^${key}=" .env; then
    sed -i "s|^${key}=.*|${key}=${value}|" .env
  else
    printf '%s=%s\n' "$key" "$value" >> .env
  fi
}

set_env DB_CONNECTION mysql
set_env DB_HOST db
set_env DB_PORT 3306
set_env DB_DATABASE megourmet
set_env DB_USERNAME app
set_env DB_PASSWORD app

if [ ! -f routes/api.php ]; then
  php artisan install:api --no-interaction
fi

if ! grep -q "'/health'" routes/api.php; then
  cat >> routes/api.php <<'PHP'

Route::get('/health', fn () => response()->json(['ok' => true]));
PHP
fi

php artisan key:generate --force

echo "セットアップ完了。フロントエンドは http://localhost:5173 で開きます。"

