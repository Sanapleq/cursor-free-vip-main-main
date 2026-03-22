@echo off
chcp 65001 >nul 2>&1
title Cursor Free VIP - Установка

color 0A
cls

echo.
echo ================================================================
echo    🚀 Cursor Free VIP - Установка и настройка
echo ================================================================
echo.

:: Проверка Python
echo [1/5] Проверка Python...
python --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    color 0C
    echo.
    echo    ❌ Python не найден!
    echo.
    echo    Установите Python 3.11-3.14:
    echo    https://www.python.org/downloads/
    echo.
    echo    ⚠️  При установке отметьте: "Add Python to PATH"
    echo.
    pause
    exit /b 1
)

for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
echo    ✅ Python %PYTHON_VERSION% найден
echo.

:: Создание виртуального окружения
echo [2/5] Создание виртуального окружения...
echo.

if exist "myenv\Scripts\python.exe" (
    echo    ℹ️  Виртуальное окружение уже существует
    echo    ✅ Пропущено
) else (
    echo    Создание myenv...
    python -m venv myenv
    if %ERRORLEVEL% EQU 0 (
        echo    ✅ Виртуальное окружение создано
    ) else (
        color 0C
        echo    ❌ Ошибка создания!
        pause
        exit /b 1
    )
)
echo.

:: Активация и установка зависимостей
echo [3/5] Установка зависимостей...
echo.

call myenv\Scripts\activate

if exist "requirements.txt" (
    echo    Установка пакетов (это может занять 2-5 минут)...
    echo.
    pip install -r requirements.txt --quiet
    if %ERRORLEVEL% EQU 0 (
        echo    ✅ Зависимости установлены
    ) else (
        color 0C
        echo    ❌ Ошибка установки!
        echo.
        echo    Попробуйте вручную:
        echo    call myenv\Scripts\activate
        echo    pip install -r requirements.txt
        echo.
        pause
        exit /b 1
    )
) else (
    color 0C
    echo    ❌ requirements.txt не найден!
    pause
    exit /b 1
)
echo.

:: Создание папки drivers
echo [4/5] Настройка драйверов...
echo.

if not exist "drivers" (
    mkdir drivers
    echo    ✅ Папка drivers создана
) else (
    echo    ℹ️  Папка drivers уже существует
)

if exist "drivers\chromedriver.exe" (
    echo    ✅ ChromeDriver найден
) else (
    echo    ⚠️  ChromeDriver будет загружен автоматически при первом запуске
)
echo.

:: Финал
echo [5/5] Завершение...
echo.

:: Создание ярлыка
echo    Создание ярлыка на рабочем столе...
powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%USERPROFILE%\Desktop\Cursors Free VIP.lnk'); $Shortcut.TargetPath = '%CD%\START.bat'; $Shortcut.WorkingDirectory = '%CD%'; $Shortcut.IconLocation = '%SystemRoot%\System32\cmd.exe'; $Shortcut.Description = 'Cursor Free VIP'; $Shortcut.Save()" 2>nul
if %ERRORLEVEL% EQU 0 (
    echo    ✅ Ярлык создан
) else (
    echo    ℹ️  Ярлык не создан (не критично)
)
echo.

color 02
echo ================================================================
echo    🎉 УСТАНОВКА ЗАВЕРШЕНА!
echo ================================================================
echo.
echo    ✅ Все зависимости установлены
echo    ✅ Виртуальное окружение готово
echo    ✅ Ярлык создан на рабочем столе
echo.
echo    📁 Для запуска программы:
echo       Дважды кликните на: START.bat
echo.
echo    ⚠️  Программа требует прав администратора!
echo.
echo ================================================================
echo.

set /p RUN_NOW="🚀 Запустить программу сейчас? (y/n): "
if /i "%RUN_NOW%"=="y" (
    echo.
    echo    Запуск...
    timeout /t 2 >nul
    START.bat
) else (
    echo.
    echo    Готово! Запустите START.bat когда будете готовы.
)

echo.
timeout /t 5 >nul
