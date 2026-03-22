@echo off
chcp 65001 >nul
title Cursor Free VIP - GitHub Upload All-in-One

:MENU
cls
echo ================================================================
echo           🚀 Cursor Free VIP - Выгрузка на GitHub
echo ================================================================
echo.
echo    Выберите действие:
echo.
echo    1. 🧹 Очистить и подготовить проект
echo    2. 📤 Отправить на GitHub
echo    3. ✅ Всё сразу (Очистка + Отправка)
echo    4. ℹ️  Информация о проекте
echo    5. 🚪 Выход
echo.
echo ================================================================
set /p CHOICE="Ваш выбор (1-5): "

if "%CHOICE%"=="1" goto CLEAN
if "%CHOICE%"=="2" goto UPLOAD
if "%CHOICE%"=="3" goto ALL_IN_ONE
if "%CHOICE%"=="4" goto INFO
if "%CHOICE%"=="5" goto EXIT

echo ❌ Неверный выбор!
timeout /t 2 >nul
goto MENU

:CLEAN
cls
echo ================================================================
echo    🧹 Очистка проекта
echo ================================================================
echo.

:: Очистка
echo Очистка временных файлов...
if exist "__pycache__" rmdir /s /q "__pycache__"
if exist ".pytest_cache" rmdir /s /q ".pytest_cache"
if exist ".mypy_cache" rmdir /s /q ".mypy_cache"
del /q /s test_*.py >nul 2>&1
del /q /s *.log >nul 2>&1
del /q /s *.tmp >nul 2>&1
del /q /s *.bak >nul 2>&1
del /q test_output.txt >nul 2>&1
del /q test_permissions.py >nul 2>&1
del /q test_file_access.py >nul 2>&1

if exist "build" rmdir /s /q "build"
if exist "dist" rmdir /s /q "dist"

echo ✅ Очистка завершена!
echo.

:: Git
echo Инициализация Git...
if not exist ".git" (
    git init
    echo ✅ Git инициализирован
) else (
    echo ℹ️  Git уже инициализирован
)

echo.
echo Добавление файлов...
git add .
echo ✅ Файлы добавлены

echo.
echo Статус:
git status --short

echo.
echo ================================================================
echo ✅ Подготовка завершена!
echo ================================================================
echo.
echo Хотите продолжить с отправкой на GitHub?
set /p CONTINUE="(y/n): "
if /i "%CONTINUE%"=="y" goto UPLOAD
goto MENU

:UPLOAD
cls
echo ================================================================
echo    📤 Отправка на GitHub
echo ================================================================
echo.

:: Проверка Git
where git >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Git не найден! Установите Git с https://git-scm.com/
    pause
    goto MENU
)

echo ✅ Git найден
echo.

:: Запрос имени пользователя
set /p GITHUB_USERNAME="Введите ваш логин GitHub: "
if "%GITHUB_USERNAME%"=="" (
    echo ❌ Имя пользователя не введено!
    timeout /t 2 >nul
    goto MENU
)

echo.
echo ================================================================
echo    Создайте репозиторий на GitHub
echo ================================================================
echo.
echo 1. Откройте: https://github.com/new
echo 2. Имя репозитория: cursor-free-vip-main
echo 3. Тип: Public или Private
echo 4. ⚠️  НЕ инициализировать!
echo 5. Нажмите "Create repository"
echo.
pause

:: Добавление remote
echo.
echo Добавление удаленного репозитория...
git remote get-url origin >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    git remote set-url origin https://github.com/%GITHUB_USERNAME%/cursor-free-vip-main.git
) else (
    git remote add origin https://github.com/%GITHUB_USERNAME%/cursor-free-vip-main.git
)
echo ✅ Remote добавлен

:: Отправка
echo.
echo Отправка кода...
git branch -M main >nul 2>nul
git push -u origin main
if %ERRORLEVEL% EQU 0 (
    echo ✅ Код отправлен!
) else (
    echo ❌ Ошибка отправки!
    pause
    goto MENU
)

:: Теги
echo.
echo Отправка тегов...
git push origin --tags
if %ERRORLEVEL% EQU 0 (
    echo ✅ Теги отправлены!
) else (
    echo ⚠️  Ошибка отправки тегов
)

:: Финал
echo.
echo ================================================================
echo    🎉 ГОТОВО!
echo ================================================================
echo.
echo 📍 Репозиторий:
echo    https://github.com/%GITHUB_USERNAME%/cursor-free-vip-main
echo.

set /p OPEN="Открыть в браузере? (y/n): "
if /i "%OPEN%"=="y" (
    start https://github.com/%GITHUB_USERNAME%/cursor-free-vip-main
)

echo.
pause
goto MENU

:ALL_IN_ONE
cls
echo ================================================================
echo    ✅ ВСЁ СРАЗУ: Очистка + Отправка
echo ================================================================
echo.

:: Очистка
echo [1/6] Очистка временных файлов...
if exist "__pycache__" rmdir /s /q "__pycache__"
if exist ".pytest_cache" rmdir /s /q ".pytest_cache"
del /q /s test_*.py >nul 2>&1
del /q /s *.log >nul 2>&1
del /q /s *.bak >nul 2>&1
if exist "build" rmdir /s /q "build"
if exist "dist" rmdir /s /q "dist"
echo      ✅

:: Git
echo [2/6] Инициализация Git...
if not exist ".git" git init >nul 2>&1
echo      ✅

echo [3/6] Добавление файлов...
git add . >nul 2>&1
echo      ✅

:: Запрос данных
echo.
echo ================================================================
echo    Настройка GitHub
echo ================================================================
echo.
set /p GITHUB_USERNAME="Ваш логин GitHub: "
if "%GITHUB_USERNAME%"=="" (
    echo ❌ Требуется логин!
    timeout /t 2 >nul
    goto MENU
)

echo.
echo [4/6] Создание репозитория...
echo      1. Откройте: https://github.com/new
echo      2. Имя: cursor-free-vip-main
echo      3. НЕ инициализировать!
echo      4. Создайте репозиторий
echo.
pause

echo [5/6] Настройка remote...
git remote get-url origin >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    git remote set-url origin https://github.com/%GITHUB_USERNAME%/cursor-free-vip-main.git
) else (
    git remote add origin https://github.com/%GITHUB_USERNAME%/cursor-free-vip-main.git
)
echo      ✅

echo [6/6] Отправка на GitHub...
git branch -M main >nul 2>nul
git push -u origin main
if %ERRORLEVEL% EQU 0 (
    echo      ✅ Код отправлен!
    git push origin --tags >nul 2>&1
    echo      ✅ Теги отправлены!
) else (
    echo      ❌ Ошибка!
)

:: Финал
echo.
echo ================================================================
echo    🎉 ВСЁ ГОТОВО!
echo ================================================================
echo.
echo 📍 URL: https://github.com/%GITHUB_USERNAME%/cursor-free-vip-main
echo.

set /p OPEN="Открыть репозиторий? (y/n): "
if /i "%OPEN%"=="y" (
    start https://github.com/%GITHUB_USERNAME%/cursor-free-vip-main
)

echo.
echo ✅ Все операции завершены!
echo.
pause
goto MENU

:INFO
cls
echo ================================================================
echo    📊 Информация о проекте
echo ================================================================
echo.
echo Версия: v1.11.06
echo Дата: 2026-03-22
echo.
echo Исправления:
echo   ✅ UTF-8 BOM encoding (cursor_acc_info.py)
echo   ✅ File permissions (reset_machine_manual.py)
echo   ✅ Circular imports (config.py, main.py)
echo   ✅ Python 3.14 compatibility (requirements.txt)
echo.
echo Статус Git:
git status --short
echo.
echo Ветка:
git branch
echo.
echo Теги:
git tag -l
echo.
pause
goto MENU

:EXIT
cls
echo.
echo ================================================================
echo    Спасибо за использование Cursor Free VIP!
echo ================================================================
echo.
timeout /t 2 >nul
exit /b 0
