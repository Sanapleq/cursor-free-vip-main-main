@echo off
title Cursor Obxod - Quick Start
color 0A
cls

echo.
echo ================================================================
echo    Cursor Obxod - Quick Start
echo ================================================================
echo.
echo    Checking Python...
python --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo    ERROR: Python not found!
    echo.
    echo    Install Python 3.11-3.14 from:
    echo    https://www.python.org/downloads/
    echo.
    pause
    exit /b 1
)
echo    OK: Python found
echo.

echo    Creating virtual environment...
if exist "venv\Scripts\python.exe" (
    echo    OK: Already exists
) else (
    python -m venv venv
    echo    OK: Created
)
echo.

echo    Installing dependencies...
call venv\Scripts\activate
pip install -r requirements.txt --quiet --no-warn-script-location
echo    OK: Ready
echo.

echo    Starting program...
echo.
python core\main.py

pause
