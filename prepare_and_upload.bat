@echo off
chcp 65001 >nul
title Prepare Project for GitHub

echo ================================================================
echo    🧹 Очистка проекта перед выгрузкой на GitHub
echo ================================================================
echo.

echo 1️⃣  Очистка временных файлов Python...
if exist "__pycache__" (
    rmdir /s /q "__pycache__"
    echo     ✅ __pycache__ удален
) else (
    echo     ℹ️  __pycache__ не найден
)

if exist ".pytest_cache" (
    rmdir /s /q ".pytest_cache"
    echo     ✅ .pytest_cache удален
) else (
    echo     ℹ️  .pytest_cache не найден
)

if exist ".mypy_cache" (
    rmdir /s /q ".mypy_cache"
    echo     ✅ .mypy_cache удален
) else (
    echo     ℹ️  .mypy_cache не найден
)

echo.
echo 2️⃣  Удаление тестовых файлов...
del /q /s test_*.py >nul 2>&1
del /q /s *.log >nul 2>&1
del /q /s *.tmp >nul 2>&1
del /q /s *.bak >nul 2>&1
del /q test_output.txt >nul 2>&1
del /q test_permissions.py >nul 2>&1
del /q test_file_access.py >nul 2>&1
echo     ✅ Временные файлы удалены

echo.
echo 3️⃣  Очистка build артефактов...
if exist "build" (
    rmdir /s /q "build"
    echo     ✅ build/ удален
) else (
    echo     ℹ️  build/ не найден
)

if exist "dist" (
    rmdir /s /q "dist"
    echo     ✅ dist/ удален
) else (
    echo     ℹ️  dist/ не найден
)

echo.
echo 4️⃣  Проверка .gitignore...
if exist ".gitignore" (
    echo     ✅ .gitignore существует
) else (
    echo     ⚠️  .gitignore не найден!
)

echo.
echo 5️⃣  Инициализация Git...
if not exist ".git" (
    git init
    echo     ✅ Git репозиторий инициализирован
) else (
    echo     ℹ️  Git уже инициализирован
)

echo.
echo 6️⃣  Добавление всех файлов...
git add .
echo     ✅ Файлы добавлены

echo.
echo 7️⃣  Проверка статуса...
git status --short
echo.

echo ================================================================
echo ✅ Очистка завершена!
echo ================================================================
echo.
echo Следующий шаг: Запустите upload_to_github.bat
echo.
pause
