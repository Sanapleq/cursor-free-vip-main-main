@echo off
title IMPORTANT - Read This First!
color 0C
cls

echo.
echo ================================================================
echo    STOP! PLEASE READ THIS FIRST!
echo ================================================================
echo.
echo    You downloaded Cursor Free VIP from GitHub.
echo.
echo    BEFORE running the program, you MUST install dependencies!
echo.
echo    ================================================================
echo.
echo    STEP 1: Run SETUP.bat
echo    ----------------------------------------
echo    Double-click: SETUP.bat
echo.
echo    This will:
echo      - Create virtual environment (myenv/)
echo      - Install 29 required packages
echo      - Set up drivers folder
echo      - Create desktop shortcut
echo.
echo    Time: 3-7 minutes
echo.
echo    ================================================================
echo.
echo    STEP 2: Run START.bat
echo    ----------------------------------------
echo    After SETUP.bat completes successfully,
echo    double-click: START.bat
echo.
echo    This will:
echo      - Activate virtual environment
echo      - Request administrator rights
echo      - Launch the program
echo.
echo    Time: 5-10 seconds
echo.
echo    ================================================================
echo.
echo    CURRENT STATUS:
echo    ----------------------------------------
if exist "myenv\Scripts\python.exe" (
        echo    [OK] Virtual environment found
    ) else (
        echo    [ERROR] Virtual environment NOT found!
        echo    You must run SETUP.bat first!
    )
echo.
if exist "requirements.txt" (
        echo    [OK] requirements.txt found
    ) else (
        echo    [ERROR] requirements.txt NOT found!
    )
echo.
echo    ================================================================
echo.
echo    Do you want to run SETUP.bat now?
echo.
set /p RUN_SETUP="Type Y and press Enter to run SETUP.bat: "
if /i "%RUN_SETUP%"=="Y" (
    echo.
    echo    Starting SETUP.bat...
    timeout /t 2 >nul
    call SETUP.bat
) else (
    echo.
    echo    Please run SETUP.bat manually when ready!
    timeout /t 5 >nul
)
