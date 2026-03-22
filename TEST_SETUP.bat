@echo off
title Test SETUP.bat
color 07
cls

echo.
echo ================================================================
echo    TESTING SETUP.bat
echo ================================================================
echo.
echo    This script tests if SETUP.bat can run properly.
echo.

REM Test 1: Check if we can execute commands
echo [TEST 1] Testing command execution...
echo    Current directory: %CD%
echo.

REM Test 2: Check Python
echo [TEST 2] Checking Python...
python --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo    ERROR: Python not found!
    echo.
    echo    Please install Python first.
    pause
    exit /b 1
)
echo    OK: Python found
python --version
echo.

REM Test 3: Check if we can run batch commands
echo [TEST 3] Testing batch execution...
echo    Testing pause command...
timeout /t 2 >nul
echo    OK: Commands work
echo.

REM Test 4: Try to run SETUP.bat
echo [TEST 4] Attempting to run SETUP.bat...
echo.
echo    If SETUP.bat starts now, the issue is resolved.
echo    If it closes immediately, there's still a problem.
echo.
timeout /t 3 >nul

REM Run SETUP.bat
call SETUP.bat

echo.
echo ================================================================
echo    TEST COMPLETE
echo ================================================================
echo.
pause
