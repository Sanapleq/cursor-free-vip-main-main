"""
Cursor Free VIP - Auto Installer and Launcher
Compiles to standalone .exe that:
1. Checks/installs Python if needed
2. Creates virtual environment
3. Installs all dependencies
4. Launches the main application
"""

import os
import sys
import subprocess
import time
from pathlib import Path

# Get script directory (works for both frozen and unfrozen)
if getattr(sys, 'frozen', False):
    # For frozen app, use the directory where the .exe is located
    SCRIPT_DIR = Path(sys.executable).parent
    # Also change to that directory
    os.chdir(SCRIPT_DIR)
else:
    # For unfrozen app, use the script's directory
    SCRIPT_DIR = Path(__file__).parent

def print_header(text):
    """Print formatted header"""
    print("\n" + "=" * 70)
    print(f"  {text}")
    print("=" * 70 + "\n")

def print_step(step, total, text):
    """Print step indicator"""
    print(f"\n[{step}/{total}] {text}")
    print("-" * 50)

def check_python():
    """Check if Python is installed"""
    try:
        result = subprocess.run(['python', '--version'], 
                              capture_output=True, text=True, timeout=5)
        if result.returncode == 0:
            version = result.stdout.strip()
            print(f"[OK] Python found: {version}")
            return True
    except Exception as e:
        print(f"[ERROR] Python check failed: {e}")
    
    return False

def create_venv():
    """Create virtual environment"""
    print("Creating virtual environment (this may take 1-2 minutes)...")
    
    # Always use subprocess for frozen EXE to avoid _MEI temp folder issues
    if getattr(sys, 'frozen', False):
        print("Running as EXE - using subprocess method...")
        try:
            result = subprocess.run(
                [sys.executable, '-m', 'venv', 'myenv'],
                capture_output=True,
                text=True,
                timeout=300,  # 5 minutes
                encoding='utf-8',
                errors='replace'
            )
            
            if result.returncode == 0:
                print("[OK] Virtual environment created")
                return True
            else:
                err_msg = result.stderr[:300] if result.stderr else 'Unknown error'
                print(f"[ERROR] Failed: {err_msg}")
                return False
        except subprocess.TimeoutExpired:
            print("[ERROR] Timeout - took more than 5 minutes")
            return False
        except Exception as e:
            print(f"[ERROR] Exception: {e}")
            return False
    else:
        # For unfrozen (development), use direct venv module
        print("Running in development mode - using venv module...")
        try:
            import venv
            venv_path = SCRIPT_DIR / 'myenv'
            
            builder = venv.EnvBuilder(with_pip=True, clear=False)
            builder.create(str(venv_path))
            
            if (venv_path / 'Scripts' / 'python.exe').exists():
                print("[OK] Virtual environment created")
                return True
            else:
                print("[ERROR] python.exe not found after venv creation")
                return False
        except Exception as e:
            print(f"[ERROR] venv module failed: {e}")
            return False

def install_dependencies():
    """Install all dependencies"""
    print("Installing dependencies (this may take 3-7 minutes)...")
    
    venv_python = SCRIPT_DIR / 'myenv' / 'Scripts' / 'python.exe'
    
    if not venv_python.exists():
        print("[ERROR] Virtual environment Python not found!")
        return False
    
    try:
        # Upgrade pip first
        print("Upgrading pip...")
        subprocess.run([str(venv_python), '-m', 'pip', 'install', '--upgrade', 'pip'], 
                      check=True, capture_output=True, timeout=300,
                      encoding='utf-8', errors='replace')
        
        # Install requirements
        req_file = SCRIPT_DIR / 'requirements.txt'
        if req_file.exists():
            print("Installing packages from requirements.txt...")
            result = subprocess.run([str(venv_python), '-m', 'pip', 'install', '-r', str(req_file)], 
                                  capture_output=True, text=True, timeout=600,
                                  encoding='utf-8', errors='replace')
            if result.returncode == 0:
                print("[OK] All dependencies installed")
                return True
            else:
                err_msg = result.stderr[:200] if result.stderr else 'Unknown error'
                print(f"[ERROR] Installation failed: {err_msg}")
                return False
        else:
            print("[ERROR] requirements.txt not found!")
            return False
    except subprocess.TimeoutExpired:
        print("[ERROR] Installation timed out!")
        return False
    except Exception as e:
        print(f"[ERROR] Installation failed: {e}")
        return False

def check_dependencies():
    """Check if dependencies are already installed"""
    venv_python = SCRIPT_DIR / 'myenv' / 'Scripts' / 'python.exe'
    
    if not venv_python.exists():
        return False
    
    try:
        result = subprocess.run([str(venv_python), '-c', 'import requests, colorama, psutil'], 
                              capture_output=True, timeout=10)
        return result.returncode == 0
    except:
        return False

def launch_application():
    """Launch the main application"""
    print("\nLaunching Cursor Free VIP...")
    time.sleep(1)
    
    venv_python = SCRIPT_DIR / 'myenv' / 'Scripts' / 'python.exe'
    main_py = SCRIPT_DIR / 'main.py'
    
    if not main_py.exists():
        print("[ERROR] main.py not found!")
        return False
    
    try:
        # Don't wait for completion, just launch
        subprocess.Popen([str(venv_python), str(main_py)])
        print("[OK] Application launched")
        return True
    except Exception as e:
        print(f"[ERROR] Failed to launch: {e}")
        return False

def main():
    """Main installation and launch process"""
    print_header("Cursor Free VIP - Auto Installer")
    
    total_steps = 4
    current_step = 0
    
    # Step 1: Check Python
    current_step += 1
    print_step(current_step, total_steps, "Checking Python installation")
    
    if not check_python():
        print("\n" + "!" * 70)
        print("ERROR: Python is not installed!")
        print("!" * 70)
        print("\nPlease install Python 3.11-3.14 from:")
        print("https://www.python.org/downloads/")
        print("\nIMPORTANT: Check 'Add Python to PATH' during installation")
        print("\nAfter installing Python, run this installer again.")
        print("\n" + "!" * 70)
        input("\nPress Enter to exit...")
        return False
    
    # Step 2: Check/Create virtual environment
    current_step += 1
    print_step(current_step, total_steps, "Setting up virtual environment")
    
    venv_path = SCRIPT_DIR / 'myenv' / 'Scripts' / 'python.exe'
    venv_exists = venv_path.exists()
    
    if venv_exists:
        print("✓ Virtual environment already exists")
    else:
        print("Creating new virtual environment...")
        if not create_venv():
            print("\nFailed to create virtual environment.")
            input("\nPress Enter to exit...")
            return False
    
    # Step 3: Install dependencies
    current_step += 1
    print_step(current_step, total_steps, "Installing dependencies")
    
    deps_ok = check_dependencies()
    if deps_ok:
        print("✓ Dependencies already installed")
    else:
        print("Installing missing dependencies...")
        if not install_dependencies():
            print("\nInstallation failed. Try running SETUP.bat manually.")
            input("\nPress Enter to exit...")
            return False
    
    # Step 4: Launch application
    current_step += 1
    print_step(current_step, total_steps, "Launching application")
    
    launch_application()
    
    print_header("Installation Complete!")
    print("✓ All components installed successfully")
    print("✓ Application launched in separate window")
    print("\nNext time, you can run START.bat for faster launch")
    print("\n" + "=" * 70)
    print("\nThis window will close in 5 seconds...")
    time.sleep(5)
    
    return True

if __name__ == '__main__':
    try:
        success = main()
        sys.exit(0 if success else 1)
    except KeyboardInterrupt:
        print("\n\nInstallation cancelled by user")
        sys.exit(1)
    except Exception as e:
        print(f"\n\nUnexpected error: {e}")
        import traceback
        traceback.print_exc()
        input("Press Enter to exit...")
        sys.exit(1)
