@echo off
title Cursor Free VIP
color 0B
cls

REM Get script directory (works from any location)
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
echo [1/3] Checking virtual environment...
echo    Looking for: %SCRIPT_DIR%myenv\Scripts\python.exe

if exist "myenv\Scripts\python.exe" (
    echo    OK: Virtual environment found
) else (
    color 0C
    echo.
    echo    ERROR: Virtual environment not found!
    echo.
    echo    Expected location: %SCRIPT_DIR%myenv\
    echo.
    echo    Please run SETUP.bat first
    echo.
    echo    Or install manually:
    echo    1. cd /d "%SCRIPT_DIR%"
    echo    2. python -m venv myenv
    echo    3. call myenv\Scripts\activate
    echo    4. pip install -r requirements.txt
    echo.
    echo    Current files in directory:
    dir /b myenv\Scripts\*.exe 2>nul || echo    (no .exe files found)
    echo.
    pause
    exit /b 1
)
echo.

REM Check admin rights
echo [2/3] Checking administrator rights...

net session >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo    WARNING: Administrator rights required!
    echo.
    echo    Restarting as administrator...
    echo.
    timeout /t 2 >nul
    
    REM Restart as admin
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo    OK: Administrator rights obtained
echo.

REM Activate and run
echo [3/3] Starting program...
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
