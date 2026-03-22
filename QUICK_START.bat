@echo off
title Cursor Free VIP - Quick Start
color 0B
cls

echo.
echo ================================================================
echo    Cursor Free VIP - Quick Start (OPTIMIZED)
echo ================================================================
echo.
echo    This will:
echo      1. Check Python
echo      2. Create virtual environment (if needed)
echo      3. Install dependencies (OPTIMIZED - faster!)
echo      4. Launch the program
echo.
echo    Time: First run 1-3 min (was 3-7 min), next runs 5-10 sec
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
    echo    Creating... (please wait 30-60 sec)
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

REM Step 3: Check/Install dependencies (OPTIMIZED)
echo [3/4] Checking dependencies...
call myenv\Scripts\activate

REM Quick check - if main imports work, skip installation
python -c "import requests, colorama, psutil" >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo    OK: Already installed
    goto :LAUNCH
)

echo    Installing optimized... (please wait 1-3 min)
echo.

REM Enable pip cache
set PIP_CACHE_DIR=%SCRIPT_DIR%.pip_cache
if not exist ".pip_cache" mkdir .pip_cache

REM Fast installation with optimizations
pip install --no-cache-dir --quiet ^
    --disable-pip-version-check ^
    --no-warn-script-location ^
    -r requirements.txt

if %ERRORLEVEL% EQU 0 (
    echo    OK: Installed
) else (
    color 0C
    echo    ERROR: Installation failed!
    echo    Trying fallback method...
    pip install -r requirements.txt
    if %ERRORLEVEL% NEQ 0 (
        pause
        exit /b 1
    )
)

:LAUNCH
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
