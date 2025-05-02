#!/bin/bash

# Strict mode для безопасности
set -euo pipefail

# Конфигурация
PROJECT_DIR="/var/www/lebrowski.blog"
BRANCH="main"
LOG_FILE="/var/log/deploy.log"

# Логирование
exec > >(tee -a "$LOG_FILE") 2>&1
echo -e "\n--- Starting deployment $(date) ---"

# Проверка директории
if [ ! -d "$PROJECT_DIR" ]; then
  echo "❌ Error: Project directory $PROJECT_DIR not found!" >&2
  exit 1
fi

cd "$PROJECT_DIR" || exit

# Обновление кода
echo "🔄 Pulling latest code from $BRANCH..."
git fetch --all
git reset --hard "origin/$BRANCH"

# Установка зависимостей
echo "📦 Installing dependencies..."
npm ci --silent

# Сборка проекта
echo "🔨 Building Astro..."
npm run build

# Права на файлы (если нужно)
chown -R deployer:www-data public/

echo "✅ Deployment completed successfully!"