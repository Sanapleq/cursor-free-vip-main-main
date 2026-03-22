@echo off
title Fix venv Creation Issue
color 0B
cls

echo.
echo ================================================================
echo    FIX: Virtual Environment Creation Failed
echo ================================================================
echo.
echo    If SETUP.bat stops at step 2 (Creating virtual environment),
echo    this script will help fix the issue.
echo.
echo ================================================================
echo.

echo Current directory: %CD%
echo.

echo Checking Python...
python --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Python not found!
    echo Please install Python from https://www.python.org/downloads/
    pause
    exit /b 1
)

for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PY_VER=%%i
echo OK: Python %PY_VER% found
echo.

echo Checking disk space...
echo Required: at least 500MB free
echo.

echo Removing old myenv folder (if exists)...
if exist "myenv" (
    echo Found old myenv folder
    echo Deleting...
    rmdir /s /q myenv 2>nul
    if %ERRORLEVEL% EQU 0 (
        echo OK: Old myenv removed
    ) else (
        echo ERROR: Cannot remove myenv folder
        echo Please close any programs using this folder
        echo Then run this script again
        pause
        exit /b 1
    )
) else (
    echo No old myenv folder found
)
echo.

echo Creating new virtual environment...
echo Command: python -m venv myenv
echo.

python -m venv myenv
set RESULT=%ERRORLEVEL%

if %RESULT% EQU 0 (
    echo.
    echo SUCCESS: Virtual environment created!
    echo.
    echo Verifying...
    if exist "myenv\Scripts\python.exe" (
        echo OK: myenv\Scripts\python.exe found
    ) else (
        echo WARNING: python.exe not found in myenv\Scripts\
        dir myenv 2>nul
    )
    echo.
    echo Testing activation...
    call myenv\Scripts\activate
    if %ERRORLEVEL% EQU 0 (
        echo OK: Activation works
    ) else (
        echo WARNING: Activation failed with error %ERRORLEVEL%
    )
    echo.
    echo ================================================================
    echo    FIX SUCCESSFUL!
    echo ================================================================
    echo.
    echo You can now run START.bat
) else (
    color 0C
    echo.
    echo ERROR: Failed to create virtual environment!
    echo Error code: %RESULT%
    echo.
    echo Possible causes:
    echo   1. Not enough disk space
    echo   2. Antivirus blocking venv creation
    echo   3. Python installation corrupted
    echo   4. Insufficient permissions
    echo.
    echo Solutions:
    echo   1. Check free disk space (need 500MB+)
    echo   2. Temporarily disable antivirus
    echo   3. Reinstall Python
    echo   4. Run as Administrator
    echo.
    
    echo Trying with --clear flag...
    python -m venv --clear myenv 2>nul
    if %ERRORLEVEL% EQU 0 (
        echo SUCCESS: Created with --clear flag
    ) else (
        echo ERROR: --clear flag also failed
        echo.
        echo Manual fix required:
        echo 1. Open PowerShell as Administrator
        echo 2. cd to this folder
        echo 3. python -m venv myenv
        echo 4. If that fails, reinstall Python
    )
)

echo.
pause
