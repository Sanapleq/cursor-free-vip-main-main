@echo off
chcp 65001 >nul
title Cursor Free VIP - Установка

echo ================================================================
echo    🚀 Установка Cursor Free VIP
echo ================================================================
echo.

:: Проверка Python
python --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Python не найден!
    echo.
    echo    Установите Python 3.11-3.14 с https://www.python.org/
    echo.
    pause
    exit /b 1
)

echo ✅ Python найден
python --version
echo.

:: Создание виртуального окружения
echo ================================================================
echo    Шаг 1: Создание виртуального окружения
echo ================================================================
echo.

if exist "myenv\Scripts\python.exe" (
    echo ℹ️  Виртуальное окружение уже существует
    set /p RECREATE="Пересоздать? (y/n): "
    if /i "%RECREATE%"=="y" (
        rmdir /s /q myenv
        python -m venv myenv
        echo ✅ Виртуальное окружение пересоздано
    ) else (
        echo ⏭️  Пропущено
    )
) else (
    python -m venv myenv
    echo ✅ Виртуальное окружение создано
)
echo.

:: Активация и установка зависимостей
echo ================================================================
echo    Шаг 2: Установка зависимостей
echo ================================================================
echo.

call myenv\Scripts\activate

if exist "requirements.txt" (
    pip install -r requirements.txt
    if %ERRORLEVEL% EQU 0 (
        echo ✅ Зависимости установлены
    ) else (
        echo ❌ Ошибка установки зависимостей!
        pause
        exit /b 1
    )
) else (
    echo ❌ requirements.txt не найден!
    pause
    exit /b 1
)
echo.

:: Создание папки drivers
echo ================================================================
echo    Шаг 3: Настройка драйверов
echo ================================================================
echo.

if not exist "drivers" (
    mkdir drivers
    echo ✅ Папка drivers создана
) else (
    echo ℹ️  Папка drivers уже существует
)

:: Проверка chromedriver
if exist "drivers\chromedriver.exe" (
    echo ℹ️  ChromeDriver уже существует
) else (
    echo ⚠️  ChromeDriver не найден
    echo    Он будет автоматически загружен при первом запуске
    echo    ИЛИ скачайте с: https://chromedriver.chromium.org/
)
echo.

:: Создание ярлыка на рабочем столе (опционально)
echo ================================================================
echo    Шаг 4: Создание ярлыка (опционально)
echo ================================================================
echo.
set /p CREATE_SHORTCUT="Создать ярлык на рабочем столе? (y/n): "
if /i "%CREATE_SHORTCUT%"=="y" (
    powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%USERPROFILE%\Desktop\Cursors Free VIP.lnk'); $Shortcut.TargetPath = '%CD%\START.bat'; $Shortcut.WorkingDirectory = '%CD%'; $Shortcut.IconLocation = '%CD%\images\logo.png'; $Shortcut.Description = 'Cursor Free VIP - Автоматическая регистрация'; $Shortcut.Save()"
    echo ✅ Ярлык создан на рабочем столе
)
echo.

:: Финал
echo ================================================================
echo    🎉 УСТАНОВКА ЗАВЕРШЕНА!
echo ================================================================
echo.
echo    Теперь вы можете запустить программу:
echo.
echo    1. Дважды кликните на: START.bat
echo    2. ИЛИ через ярлык на рабочем столе
echo.
echo    ⚠️  Программа требует прав администратора!
echo.

set /p RUN_NOW="Запустить сейчас? (y/n): "
if /i "%RUN_NOW%"=="y" (
    echo.
    echo Запуск...
    START.bat
) else (
    echo.
    echo ✅ Готово! Запустите START.bat когда будете готовы.
)

echo.
pause
