@echo off
title Cursor Free VIP
color 0B
cls

REM Get script directory
set SCRIPT_DIR=%~dp0
cd /d "%SCRIPT_DIR%"

REM Create log file
set LOG_FILE=%SCRIPT_DIR%start_log.txt
echo START.bat Log - %DATE% %TIME% > "%LOG_FILE%"
echo Script: %~f0 >> "%LOG_FILE%"
echo Directory: %CD% >> "%LOG_FILE%"
echo. >> "%LOG_FILE%"

echo.
echo ================================================================
echo    Cursor Free VIP - Launcher
echo ================================================================
echo.
echo    Working directory: %CD%
echo    Log file: %LOG_FILE%
echo.

echo [1/3] Checking virtual environment... | tee -a "%LOG_FILE%"

if exist "myenv\Scripts\python.exe" (
    echo    OK: Virtual environment found | tee -a "%LOG_FILE%"
) else (
    color 0C
    echo    ERROR: Virtual environment not found! | tee -a "%LOG_FILE%"
    echo.
    echo    Please run SETUP.bat first
    echo.
    pause
    exit /b 1
)
echo.

echo [2/3] Checking administrator rights... | tee -a "%LOG_FILE%"

net session >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo    WARNING: Administrator rights required! | tee -a "%LOG_FILE%"
    echo    Restarting as administrator... | tee -a "%LOG_FILE%"
    echo. | tee -a "%LOG_FILE%"
    timeout /t 2 >nul
    
    REM Restart as admin with full path
    echo    Running: powershell -Command "Start-Process '%SCRIPT_DIR%START.bat' -Verb RunAs" | tee -a "%LOG_FILE%"
    powershell -Command "Start-Process '%SCRIPT_DIR%START.bat' -Verb RunAs"
    
    echo    Restarted. This window will close in 3 seconds... | tee -a "%LOG_FILE%"
    timeout /t 3 >nul
    exit /b
)

echo    OK: Administrator rights obtained | tee -a "%LOG_FILE%"
echo.

echo [3/3] Starting program... | tee -a "%LOG_FILE%"
echo.

call myenv\Scripts\activate
set ACTIVATE_RESULT=%ERRORLEVEL%
echo    Activation result: %ACTIVATE_RESULT% | tee -a "%LOG_FILE%"

if %ACTIVATE_RESULT% NEQ 0 (
    color 0C
    echo    ERROR: Failed to activate virtual environment! | tee -a "%LOG_FILE%"
    echo.
    pause
    exit /b 1
)

echo    OK: Virtual environment activated | tee -a "%LOG_FILE%"
echo    OK: Starting main.py... | tee -a "%LOG_FILE%"
echo.
echo ================================================================
echo.

python main.py

echo.
echo ================================================================
echo    Program completed
echo ================================================================
echo.
pause
