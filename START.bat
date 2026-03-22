@echo off
chcp 65001 >nul 2>&1
title Cursor Free VIP - Запуск

color 0B
cls

echo.
echo ================================================================
echo    🚀 Cursor Free VIP - Запуск
echo ================================================================
echo.

:: Проверка виртуального окружения
echo [1/3] Проверка виртуального окружения...

if not exist "myenv\Scripts\python.exe" (
    color 0C
    echo.
    echo    ❌ Виртуальное окружение не найдено!
    echo.
    echo    Сначала запустите: SETUP.bat
    echo.
    echo    Или установите вручную:
    echo    1. python -m venv myenv
    echo    2. call myenv\Scripts\activate
    echo    3. pip install -r requirements.txt
    echo.
    pause
    exit /b 1
)

echo    ✅ Виртуальное окружение найдено
echo.

:: Проверка прав администратора
echo [2/3] Проверка прав администратора...

net session >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo    ⚠️  Требуются права администратора!
    echo.
    echo    Перезапуск от имени администратора...
    echo.
    timeout /t 2 >nul
    
    :: Перезапуск от администратора
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo    ✅ Права администратора получены
echo.

:: Активация и запуск
echo [3/3] Запуск программы...
echo.

call myenv\Scripts\activate

if %ERRORLEVEL% NEQ 0 (
    color 0C
    echo    ❌ Ошибка активации виртуального окружения!
    echo.
    pause
    exit /b 1
)

echo    ✅ Виртуальное окружение активировано
echo    ✅ Запуск main.py...
echo.
echo ================================================================
echo.

:: Запуск программы
python main.py

:: Если программа завершилась
echo.
echo ================================================================
echo    Программа завершила работу
echo ================================================================
echo.
pause
