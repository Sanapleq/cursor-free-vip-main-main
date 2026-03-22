@echo off
title Cursor Free VIP
color 0B
cls

echo.
echo ================================================================
echo    Cursor Free VIP - Запуск
echo ================================================================
echo.

REM Check Python
echo [1/3] Checking Python...
python --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    color 0C
    echo    ERROR: Python not found!
    echo.
    echo    Install Python 3.11-3.14:
    echo    https://www.python.org/downloads/
    echo.
    echo    Check "Add Python to PATH"
    echo.
    pause
    exit /b 1
)
echo    OK
echo.

REM Create venv if needed
echo [2/3] Checking environment...
if exist "myenv\Scripts\python.exe" (
    echo    OK: Environment exists
) else (
    echo    Creating environment...
    python -m venv myenv
    echo    OK: Created
)
echo.

REM Install dependencies if needed
echo [3/3] Checking dependencies...
call myenv\Scripts\activate
python -c "import requests, colorama" >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo    OK: Dependencies installed
) else (
    echo    Installing dependencies...
    pip install -r requirements.txt --quiet --no-warn-script-location
    echo    OK: Installed
)
echo.

REM Close Cursor
echo    Closing Cursor...
taskkill /F /IM cursor.exe >nul 2>&1
taskkill /F /IM "cursor helper.exe" >nul 2>&1
echo    OK
echo.

echo ================================================================
echo    Starting...
echo ================================================================
echo.

python main.py

pause
