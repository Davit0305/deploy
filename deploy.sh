#!/bin/bash

# Настройки
REPO_URL="git@gitlab.com:nomadicsoft/ru2/vodilance-p2p.git"
BRANCH="main"
APP_DIR="/var/www/html/vodilance"

# Переход в директорию приложения
cd $APP_DIR || { echo "Директория $APP_DIR не найдена!"; exit 1; }

# Получение последних изменений из репозитория
echo "Получение последних изменений из ветки $BRANCH..."
git fetch origin
git checkout $BRANCH
git pull origin $BRANCH

npm install
npm run build

# Установка зависимостей через Composer
echo "Установка зависимостей Composer..."
composer install --no-interaction --prefer-dist --optimize-autoloader

# Кэширование конфигурации и маршрутов
echo "Кэширование конфигурации..."
php artisan optimize:clear
php artisan optimize

# Миграции базы данных (если необходимо)
# echo "Выполнение миграций базы данных..."
# php artisan migrate --force

echo "Деплой завершен!"

