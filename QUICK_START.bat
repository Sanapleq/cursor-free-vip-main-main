@echo off
title Cursor Free VIP - Quick Start
color 0B
cls

echo.
echo ================================================================
echo    Cursor Free VIP - Quick Start
echo ================================================================
echo.
echo    This will:
echo      1. Check Python
echo      2. Create virtual environment (if needed)
echo      3. Install dependencies (if needed)
echo      4. Launch the program
echo.
echo    Time: First run 3-7 min, next runs 5-10 sec
echo.
echo ================================================================
echo.

REM Get script directory
set SCRIPT_DIR=%~dp0
cd /d "%SCRIPT_DIR%"

REM Step 1: Check Python
echo [1/4] Checking Python...
python --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    color 0C
    echo.
    echo    ERROR: Python not found!
    echo.
    echo    Install Python 3.11-3.14 from:
    echo    https://www.python.org/downloads/
    echo.
    echo    IMPORTANT: Check "Add Python to PATH"
    echo.
    pause
    exit /b 1
)
echo    OK: Python found
echo.

REM Step 2: Check/Create venv
echo [2/4] Checking virtual environment...
if exist "myenv\Scripts\python.exe" (
    echo    OK: Already exists
) else (
    echo    Creating... (please wait 1-2 min)
    python -m venv myenv
    if %ERRORLEVEL% EQU 0 (
        echo    OK: Created
    ) else (
        color 0C
        echo    ERROR: Failed to create!
        pause
        exit /b 1
    )
)
echo.

REM Step 3: Check/Install dependencies
echo [3/4] Checking dependencies...
call myenv\Scripts\activate
python -c "import requests" >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo    OK: Already installed
) else (
    echo    Installing... (please wait 3-7 min)
    pip install -r requirements.txt --quiet
    if %ERRORLEVEL% EQU 0 (
        echo    OK: Installed
    ) else (
        color 0C
        echo    ERROR: Installation failed!
        pause
        exit /b 1
    )
)
echo.

REM Step 4: Launch
echo [4/4] Launching program...
echo.
echo ================================================================
echo.

python main.py

echo.
echo ================================================================
echo    Done
echo ================================================================
pause
