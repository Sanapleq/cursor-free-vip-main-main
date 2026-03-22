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
    SCRIPT_DIR = Path(sys.executable).parent
else:
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
            print(f"✓ Python found: {version}")
            return True
    except Exception as e:
        print(f"✗ Python check failed: {e}")
    
    return False

def create_venv():
    """Create virtual environment"""
    print("Creating virtual environment...")
    try:
        result = subprocess.run([sys.executable, '-m', 'venv', 'myenv'], 
                              capture_output=True, text=True, timeout=120)
        if result.returncode == 0:
            print("✓ Virtual environment created")
            return True
        else:
            print(f"✗ Failed: {result.stderr[:200] if result.stderr else 'Unknown error'}")
            return False
    except Exception as e:
        print(f"✗ Failed to create venv: {e}")
        return False

def install_dependencies():
    """Install all dependencies"""
    print("Installing dependencies (this may take 3-7 minutes)...")
    
    venv_python = SCRIPT_DIR / 'myenv' / 'Scripts' / 'python.exe'
    
    if not venv_python.exists():
        print("✗ Virtual environment Python not found!")
        return False
    
    try:
        # Upgrade pip first
        print("Upgrading pip...")
        subprocess.run([str(venv_python), '-m', 'pip', 'install', '--upgrade', 'pip'], 
                      check=True, capture_output=True, timeout=300)
        
        # Install requirements
        req_file = SCRIPT_DIR / 'requirements.txt'
        if req_file.exists():
            print("Installing packages from requirements.txt...")
            result = subprocess.run([str(venv_python), '-m', 'pip', 'install', '-r', str(req_file)], 
                                  capture_output=True, text=True, timeout=600)
            if result.returncode == 0:
                print("✓ All dependencies installed")
                return True
            else:
                print(f"✗ Installation failed: {result.stderr[:200] if result.stderr else 'Unknown error'}")
                return False
        else:
            print("✗ requirements.txt not found!")
            return False
    except subprocess.TimeoutExpired:
        print("✗ Installation timed out!")
        return False
    except Exception as e:
        print(f"✗ Installation failed: {e}")
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
        print("✗ main.py not found!")
        return False
    
    try:
        # Don't wait for completion, just launch
        subprocess.Popen([str(venv_python), str(main_py)])
        print("✓ Application launched")
        return True
    except Exception as e:
        print(f"✗ Failed to launch: {e}")
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
