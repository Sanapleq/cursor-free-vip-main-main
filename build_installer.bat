@echo off
title Build Auto Installer EXE
color 0B
cls

echo.
echo ================================================================
echo    Building Cursor Free VIP Auto Installer
echo ================================================================
echo.

REM Check if PyInstaller is installed
python -m pip show pyinstaller >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Installing PyInstaller...
    python -m pip install pyinstaller
)

echo.
echo Building EXE from auto_installer.py...
echo.

REM Build the EXE
pyinstaller --onefile ^
    --name "CursorFreeVIP_Installer" ^
    --icon=NONE ^
    --console ^
    --hidden-import=pathlib ^
    --add-data "requirements.txt;." ^
    auto_installer.py

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ================================================================
    echo    BUILD SUCCESSFUL!
    echo ================================================================
    echo.
    echo    EXE created: dist\CursorFreeVIP_Installer.exe
    echo.
    echo    You can now:
    echo    1. Run the EXE directly
    echo    2. Share it with others
    echo    3. It will auto-install everything
    echo.
    
    REM Copy requirements.txt to dist folder
    if exist "requirements.txt" (
        copy requirements.txt dist\ >nul
        echo    Copied requirements.txt to dist folder
    )
    echo.
) else (
    color 0C
    echo.
    echo ================================================================
    echo    BUILD FAILED!
    echo ================================================================
    echo.
    echo    Check the error messages above
    echo.
)

echo ================================================================
echo.
pause
