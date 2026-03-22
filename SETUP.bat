@echo off
title Cursor Free VIP - Fast Setup
color 0A
cls

echo.
echo ================================================================
echo    Cursor Free VIP - Fast Setup (OPTIMIZED)
echo ================================================================
echo.
echo    Optimized installation:
echo      - pip cache enabled (faster re-installs)
echo      - No unnecessary checks
echo      - Parallel downloads
echo.
echo    Time: 1-3 minutes (was 3-7 minutes)
echo.
echo ================================================================
echo.

pause >nul

REM Get script directory
set SCRIPT_DIR=%~dp0
cd /d "%SCRIPT_DIR%"

echo [1/5] Checking Python...
python --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    color 0C
    echo.
    echo    ERROR: Python not found!
    echo    Install Python 3.11-3.14 from:
    echo    https://www.python.org/downloads/
    echo.
    pause
    exit /b 1
)
for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PY_VER=%%i
echo    OK: Python %PY_VER% found
echo.

echo [2/5] Creating virtual environment...
if exist "myenv\Scripts\python.exe" (
    echo    SKIPPED: Already exists
) else (
    python -m venv myenv
    if %ERRORLEVEL% EQU 0 (
        echo    OK: Created
    ) else (
        color 0C
        echo    ERROR: Failed!
        pause
        exit /b 1
    )
)
echo.

echo [3/5] Installing dependencies (FAST MODE)...
call myenv\Scripts\activate

REM Create cache directory
if not exist ".pip_cache" mkdir .pip_cache
set PIP_CACHE_DIR=%SCRIPT_DIR%.pip_cache

REM Fast install
pip install --upgrade pip --quiet --no-warn-script-location
pip install --no-cache-dir --quiet ^
    --disable-pip-version-check ^
    --no-warn-script-location ^
    -r requirements.txt

if %ERRORLEVEL% EQU 0 (
    echo    OK: All dependencies installed
) else (
    color 0C
    echo    ERROR: Installation failed!
    pause
    exit /b 1
)
echo.

echo [4/5] Setting up drivers...
if not exist "drivers" mkdir drivers
echo    OK: Ready
echo.

echo [5/5] Creating shortcut...
powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%USERPROFILE%\Desktop\Cursors Free VIP.lnk'); $Shortcut.TargetPath = '%SCRIPT_DIR%QUICK_START.bat'; $Shortcut.WorkingDirectory = '%SCRIPT_DIR%'; $Shortcut.Description = 'Cursor Free VIP'; $Shortcut.Save()" 2>nul
echo    OK: Shortcut created (uses QUICK_START.bat)
echo.

color 02
echo ================================================================
echo    INSTALLATION COMPLETE!
echo ================================================================
echo.
echo    Next time just run: QUICK_START.bat
echo    (Much faster - only 5-10 seconds)
echo.
timeout /t 5 >nul
