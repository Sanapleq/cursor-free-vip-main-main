@echo off
title Cursor Free VIP Setup
color 0A
cls

echo.
echo ================================================================
echo    Cursor Free VIP - Installation
echo ================================================================
echo.

REM Check Python
echo [1/5] Checking Python...
python --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    color 0C
    echo.
    echo    ERROR: Python not found!
    echo.
    echo    Install Python 3.11-3.14 from:
    echo    https://www.python.org/downloads/
    echo.
    echo    IMPORTANT: Check "Add Python to PATH" during installation
    echo.
    pause
    exit /b 1
)

echo    OK: Python found
echo.

REM Create virtual environment
echo [2/5] Creating virtual environment...
echo.

if exist "myenv\Scripts\python.exe" (
    echo    INFO: Virtual environment already exists
    echo    OK: Skipped
) else (
    echo    Creating myenv...
    python -m venv myenv
    if %ERRORLEVEL% EQU 0 (
        echo    OK: Virtual environment created
    ) else (
        color 0C
        echo    ERROR: Failed to create!
        pause
        exit /b 1
    )
)
echo.

REM Activate and install dependencies
echo [3/5] Installing dependencies...
echo.

call myenv\Scripts\activate

if exist "requirements.txt" (
    echo    Installing packages (this may take 2-5 minutes)...
    echo.
    pip install -r requirements.txt --quiet
    if %ERRORLEVEL% EQU 0 (
        echo    OK: Dependencies installed
    ) else (
        color 0C
        echo    ERROR: Installation failed!
        echo.
        echo    Try manually:
        echo    call myenv\Scripts\activate
        echo    pip install -r requirements.txt
        echo.
        pause
        exit /b 1
    )
) else (
    color 0C
    echo    ERROR: requirements.txt not found!
    pause
    exit /b 1
)
echo.

REM Create drivers folder
echo [4/5] Setting up drivers...
echo.

if not exist "drivers" (
    mkdir drivers
    echo    OK: drivers folder created
) else (
    echo    INFO: drivers folder already exists
)

if exist "drivers\chromedriver.exe" (
    echo    OK: ChromeDriver found
) else (
    echo    INFO: ChromeDriver will be downloaded on first run
)
echo.

REM Final
echo [5/5] Completing...
echo.

echo    Creating desktop shortcut...
powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%USERPROFILE%\Desktop\Cursors Free VIP.lnk'); $Shortcut.TargetPath = '%CD%\START.bat'; $Shortcut.WorkingDirectory = '%CD%'; $Shortcut.Description = 'Cursor Free VIP'; $Shortcut.Save()" 2>nul
if %ERRORLEVEL% EQU 0 (
    echo    OK: Shortcut created
) else (
    echo    INFO: Shortcut not created (not critical)
)
echo.

color 02
echo ================================================================
echo    INSTALLATION COMPLETE!
echo ================================================================
echo.
echo    OK: All dependencies installed
echo    OK: Virtual environment ready
echo    OK: Desktop shortcut created
echo.
echo    To run the program:
echo       Double-click: START.bat
echo.
echo    NOTE: Program requires Administrator privileges!
echo.
echo ================================================================
echo.

set /p RUN_NOW="Run program now? (y/n): "
if /i "%RUN_NOW%"=="y" (
    echo.
    echo    Starting...
    timeout /t 2 >nul
    START.bat
) else (
    echo.
    echo    Ready! Run START.bat when you are ready.
)

echo.
timeout /t 5 >nul
