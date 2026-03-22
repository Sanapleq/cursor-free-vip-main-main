@echo off
title Cursor Free VIP - Setup
color 0A
cls

REM Get script directory
set SCRIPT_DIR=%~dp0
cd /d "%SCRIPT_DIR%"

REM Show welcome screen
echo.
echo ================================================================
echo    Cursor Free VIP - Installation
echo ================================================================
echo.
echo    Welcome! This will install all required dependencies.
echo.
echo    What will happen:
echo      1. Check Python installation
echo      2. Create virtual environment (myenv/)
echo      3. Install 29 Python packages
echo      4. Create drivers folder
echo      5. Create desktop shortcut
echo.
echo    Estimated time: 3-7 minutes
echo.
echo    Directory: %CD%
echo.
echo ================================================================
echo.

REM Pause to let user read
echo    Press any key to continue...
pause >nul

echo.
echo [1/5] Checking Python...
python --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    color 0C
    echo.
    echo    ERROR: Python not found!
    echo.
    echo    Please install Python 3.11-3.14 from:
    echo    https://www.python.org/downloads/
    echo.
    echo    IMPORTANT: Check "Add Python to PATH" during installation
    echo.
    echo    After installing Python, run SETUP.bat again.
    echo.
    pause
    exit /b 1
)

for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PY_VER=%%i
echo    OK: Python %PY_VER% found
echo.

echo [2/5] Creating virtual environment...
echo    Location: %CD%\myenv
echo.

if exist "myenv\Scripts\python.exe" (
    echo    INFO: Virtual environment already exists
    echo    SKIPPED: Using existing myenv/
) else (
    echo    Creating myenv...
    python -m venv myenv
    if %ERRORLEVEL% EQU 0 (
        echo    OK: Virtual environment created
    ) else (
        color 0C
        echo.
        echo    ERROR: Failed to create virtual environment!
        echo.
        echo    Current directory: %CD%
        echo    Python location: where python
        where python 2>nul
        echo.
        pause
        exit /b 1
    )
)
echo.

echo [3/5] Installing dependencies...
echo    This may take 2-7 minutes depending on your internet speed.
echo.

call myenv\Scripts\activate

if %ERRORLEVEL% NEQ 0 (
    color 0C
    echo.
    echo    ERROR: Failed to activate virtual environment!
    echo.
    pause
    exit /b 1
)

if exist "requirements.txt" (
    echo    Installing packages from requirements.txt...
    echo.
    echo    Downloading and installing (please wait)...
    echo.
    
    REM Install with progress
    pip install --upgrade pip --quiet
    pip install -r requirements.txt
    
    if %ERRORLEVEL% EQU 0 (
        echo.
        echo    OK: All dependencies installed successfully!
    ) else (
        color 0C
        echo.
        echo    ERROR: Installation failed!
        echo.
        echo    Try manual installation:
        echo    1. Open PowerShell in this folder
        echo    2. Run: .\myenv\Scripts\activate
        echo    3. Run: pip install -r requirements.txt
        echo.
        pause
        exit /b 1
    )
) else (
    color 0C
    echo.
    echo    ERROR: requirements.txt not found!
    echo    Current directory: %CD%
    echo    Files: 
    dir /b *.txt
    echo.
    pause
    exit /b 1
)
echo.

echo [4/5] Setting up drivers folder...
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
    echo    INFO: ChromeDriver will be downloaded automatically on first run
)
echo.

echo [5/5] Creating desktop shortcut...
echo.

powershell -Command "$WshShell = New-Object -ComObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%USERPROFILE%\Desktop\Cursors Free VIP.lnk'); $Shortcut.TargetPath = '%SCRIPT_DIR%START.bat'; $Shortcut.WorkingDirectory = '%SCRIPT_DIR%'; $Shortcut.Description = 'Cursor Free VIP - Auto Registration'; $Shortcut.Save()" 2>nul
if %ERRORLEVEL% EQU 0 (
    echo    OK: Desktop shortcut created
) else (
    echo    INFO: Shortcut creation skipped (not critical)
)
echo.

color 02
echo ================================================================
echo    INSTALLATION COMPLETE!
echo ================================================================
echo.
echo    Status:
echo      [OK] Virtual environment created
echo      [OK] Dependencies installed
echo      [OK] Drivers folder ready
echo      [OK] Desktop shortcut created
echo.
echo    Installation directory: %CD%
echo.
echo ================================================================
echo.
echo    NEXT STEP:
echo    ----------------------------------------
echo    You can now run the program by double-clicking:
echo.
echo       START.bat
echo.
echo    Or use the desktop shortcut:
echo       "Cursors Free VIP"
echo.
echo    NOTE: The program requires Administrator privileges!
echo.
echo ================================================================
echo.

set /p RUN_NOW="Do you want to run the program now? (Y/N): "
if /i "%RUN_NOW%"=="Y" (
    echo.
    echo    Starting in 3 seconds...
    timeout /t 3 >nul
    START.bat
) else (
    echo.
    echo    You can run START.bat anytime when ready!
)

echo.
echo    Installation log saved to: %CD%\setup_log.txt
echo    Setup completed at %DATE% %TIME% > "%SCRIPT_DIR%setup_log.txt"
echo.
timeout /t 5 >nul
