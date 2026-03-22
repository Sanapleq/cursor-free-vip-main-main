@echo off
chcp 65001 >nul
title Cursor Free VIP - Запуск

:: Проверка виртуального окружения
if not exist "myenv\Scripts\python.exe" (
    echo ================================================================
    echo    ❌ Виртуальное окружение не найдено!
    echo ================================================================
    echo.
    echo    Необходимо установить зависимости:
    echo.
    echo    1. Откройте PowerShell или Command Prompt
    echo    2. Запустите: python -m venv myenv
    echo    3. Запустите: .\myenv\Scripts\activate
    echo    4. Запустите: pip install -r requirements.txt
    echo.
    echo    ИЛИ запустите файл: setup.bat
    echo.
    pause
    exit /b 1
)

:: Проверка прав администратора
net session >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ================================================================
    echo    ⚠️  Требуются права администратора!
    echo ================================================================
    echo.
    echo    Перезапуск от имени администратора...
    echo.
    
    :: Перезапуск от администратора
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: Запуск программы
echo ================================================================
echo    🚀 Запуск Cursor Free VIP...
echo ================================================================
echo.

call myenv\Scripts\activate
python main.py

:: Если программа завершилась
echo.
echo ================================================================
echo    Программа завершила работу
echo ================================================================
echo.
pause
