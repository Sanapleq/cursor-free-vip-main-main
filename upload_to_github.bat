@echo off
chcp 65001 >nul
title GitHub Upload - Cursor Free VIP

echo ================================================================
echo    🚀 Автоматическая выгрузка Cursor Free VIP на GitHub
echo ================================================================
echo.

:: Проверка наличия git
where git >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Git не найден! Установите Git с https://git-scm.com/
    pause
    exit /b 1
)

echo ✅ Git найден
echo.

:: Шаг 1: Запрос имени пользователя GitHub
echo ================================================================
echo Шаг 1: Настройка репозитория
echo ================================================================
echo.
set /p GITHUB_USERNAME="Введите ваш логин GitHub (например, psipher): "
if "%GITHUB_USERNAME%"=="" (
    echo ❌ Имя пользователя не введено!
    pause
    exit /b 1
)

echo.
echo ✅ Логин: %GITHUB_USERNAME%
echo.

:: Шаг 2: Создание репозитория (инструкция)
echo ================================================================
echo Шаг 2: Создайте репозиторий на GitHub
echo ================================================================
echo.
echo 1. Откройте ссылку в браузере:
echo    https://github.com/new
echo.
echo 2. Введите имя репозитория: cursor-free-vip-main
echo.
echo 3. Выберите тип: Public или Private
echo.
echo 4. ⚠️  НЕ инициализируйте репозиторий (оставьте пустым!)
echo.
echo 5. Нажмите "Create repository"
echo.
pause

:: Шаг 3: Добавление удаленного репозитория
echo ================================================================
echo Шаг 3: Добавление удаленного репозитория
echo ================================================================
echo.

:: Проверяем, есть ли уже remote
git remote get-url origin >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo ⚠️  Remote 'origin' уже существует. Обновить?
    set /p UPDATE_REMOTE="(y/n): "
    if /i "%UPDATE_REMOTE%"=="y" (
        git remote set-url origin https://github.com/%GITHUB_USERNAME%/cursor-free-vip-main.git
        echo ✅ Remote обновлен
    ) else (
        echo ⏭️  Пропущено
    )
) else (
    git remote add origin https://github.com/%GITHUB_USERNAME%/cursor-free-vip-main.git
    if %ERRORLEVEL% EQU 0 (
        echo ✅ Remote 'origin' добавлен
    ) else (
        echo ⚠️  Возможно, remote уже существует
    )
)
echo.

:: Шаг 4: Отправка кода
echo ================================================================
echo Шаг 4: Отправка кода на GitHub
echo ================================================================
echo.

echo 📦 Отправка основной ветки...
git branch -M main >nul 2>nul
git push -u origin main
if %ERRORLEVEL% EQU 0 (
    echo ✅ Код успешно отправлен!
) else (
    echo.
    echo ⚠️  Ошибка при отправке. Возможные причины:
    echo    - Репозиторий не создан на GitHub
    echo    - Неверное имя пользователя
    echo    - Проблемы с интернетом
    echo.
    echo    Попробуйте выполнить команды вручную:
    echo    git remote add origin https://github.com/%GITHUB_USERNAME%/cursor-free-vip-main.git
    echo    git push -u origin main
    echo.
)
echo.

:: Шаг 5: Отправка тегов
echo ================================================================
echo Шаг 5: Отправка тегов версий
echo ================================================================
echo.
echo 🏷️  Отправка тега v1.11.06...
git push origin --tags
if %ERRORLEVEL% EQU 0 (
    echo ✅ Теги отправлены!
) else (
    echo ⚠️  Ошибка при отправке тегов
)
echo.

:: Шаг 6: Финальная информация
echo ================================================================
echo 🎉 ГОТОВО!
echo ================================================================
echo.
echo 📍 Ваш репозиторий:
echo    https://github.com/%GITHUB_USERNAME%/cursor-free-vip-main
echo.
echo 📝 Следующие шаги:
echo    1. Откройте репозиторий в браузере
echo    2. Перейдите в раздел "Releases"
echo    3. Нажмите "Create a new release"
echo    4. Выберите тег: v1.11.06
echo    5. Заполните описание и опубликуйте
echo.
echo 📄 Документация:
echo    - GITHUB_READY.md - Полная инструкция
echo    - INSTALL.md - Инструкция по установке
echo    - FIXES.md - Список исправлений
echo.

:: Предложение открыть репозиторий
echo ================================================================
echo Открыть репозиторий в браузере?
echo ================================================================
set /p OPEN_BROWSER="(y/n): "
if /i "%OPEN_BROWSER%"=="y" (
    start https://github.com/%GITHUB_USERNAME%/cursor-free-vip-main
    echo 🌐 Открыто в браузере!
)
echo.

echo ================================================================
echo ✅ Все операции завершены!
echo ================================================================
echo.
pause
