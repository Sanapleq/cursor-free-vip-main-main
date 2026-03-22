@echo off
title Cursor Free VIP - Debug Launcher
color 0A
cls

set SCRIPT_DIR=%~dp0
cd /d "%SCRIPT_DIR%"

echo.
echo ================================================================
echo    DEBUG MODE - Cursor Free VIP Launcher
echo ================================================================
echo.
echo    Script location: %~f0
echo    Working directory: %CD%
echo.

REM Step 1: Check myenv
echo [STEP 1] Checking myenv...
if exist "myenv\Scripts\python.exe" (
    echo    OK: myenv found at %CD%\myenv\
) else (
    echo    ERROR: myenv NOT found!
    echo    Looking in: %CD%\myenv\Scripts\python.exe
    dir myenv\Scripts\*.exe 2>nul
    pause
    exit /b 1
)
echo.

REM Step 2: Check admin
echo [STEP 2] Checking admin rights...
net session >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo    NEED ADMIN! Restarting...
    timeout /t 3 >nul
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)
echo    OK: Admin rights confirmed
echo.

REM Step 3: Activate
echo [STEP 3] Activating virtual environment...
call myenv\Scripts\activate
echo    Activation result: ERRORLEVEL=%ERRORLEVEL%
echo.

REM Step 4: Run
echo [STEP 4] Running main.py...
echo    Python location: where python
where python 2>nul | findstr /i "myenv"
echo.
echo    Starting in 3 seconds...
timeout /t 3 >nul

python main.py

echo.
echo ================================================================
echo    COMPLETED
echo ================================================================
pause
