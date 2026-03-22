@echo off
title Cursor Free VIP
color 0B
cls

REM Get script directory
set SCRIPT_DIR=%~dp0
cd /d "%SCRIPT_DIR%"

echo.
echo ================================================================
echo    Cursor Free VIP - Launcher
echo ================================================================
echo.
echo    Working directory: %CD%
echo.

REM Check virtual environment
echo [1/4] Checking virtual environment...

if exist "myenv\Scripts\python.exe" (
    echo    OK: Virtual environment found
) else (
    color 0C
    echo.
    echo    ERROR: Virtual environment not found!
    echo.
    echo    You need to run SETUP.bat first!
    echo.
    echo    What happened:
    echo    - You downloaded this project from GitHub
    echo    - Virtual environment (myenv/) was not included in download
    echo    - You need to install dependencies first
    echo.
    echo    Solution:
    echo    1. Run: SETUP.bat
    echo    2. Wait 3-7 minutes for installation
    echo    3. Then run: START.bat
    echo.
    echo    Or download and run: README_FIRST.bat
    echo.
    pause
    exit /b 1
)
echo.

REM Check if dependencies are installed
echo [2/4] Checking dependencies...

call myenv\Scripts\activate
python -c "import requests" >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    color 0C
    echo.
    echo    ERROR: Dependencies not installed!
    echo.
    echo    The virtual environment exists but packages are missing.
    echo.
    echo    Solution:
    echo    1. Run: SETUP.bat
    echo    2. Wait for installation to complete
    echo    3. Then run: START.bat
    echo.
    pause
    exit /b 1
)
echo    OK: Dependencies found
echo.

REM Check admin rights
echo [3/4] Checking administrator rights...

net session >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo    WARNING: Administrator rights required!
    echo.
    echo    Restarting as administrator...
    echo.
    timeout /t 2 >nul
    
    REM Restart as admin
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    echo    Restarted. This window will close.
    timeout /t 2 >nul
    exit /b
)

echo    OK: Administrator rights obtained
echo.

REM Activate and run
echo [4/4] Starting program...
echo.

call myenv\Scripts\activate

if %ERRORLEVEL% NEQ 0 (
    color 0C
    echo    ERROR: Failed to activate virtual environment!
    echo.
    pause
    exit /b 1
)

echo    OK: Virtual environment activated
echo    OK: Starting main.py...
echo.
echo ================================================================
echo.

REM Run program
python main.py

REM If program completed
echo.
echo ================================================================
echo    Program completed
echo ================================================================
echo.
pause
