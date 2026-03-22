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

# Get script directory
SCRIPT_DIR = Path(__file__).parent if getattr(sys, 'frozen', False) else Path(__file__).parent
os.chdir(SCRIPT_DIR)

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
    except:
        pass
    
    print("✗ Python not found!")
    return False

def create_venv():
    """Create virtual environment"""
    print("Creating virtual environment...")
    try:
        subprocess.run([sys.executable, '-m', 'venv', 'myenv'], 
                      check=True, timeout=120)
        print("✓ Virtual environment created")
        return True
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
        if (SCRIPT_DIR / 'requirements.txt').exists():
            print("Installing packages from requirements.txt...")
            subprocess.run([str(venv_python), '-m', 'pip', 'install', '-r', 'requirements.txt'], 
                          check=True, timeout=600)
            print("✓ All dependencies installed")
            return True
        else:
            print("✗ requirements.txt not found!")
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
        result = subprocess.run([str(venv_python), '-c', 'import requests, colorama'], 
                              capture_output=True, timeout=10)
        return result.returncode == 0
    except:
        return False

def launch_application():
    """Launch the main application"""
    print("\nLaunching Cursor Free VIP...")
    time.sleep(2)
    
    venv_python = SCRIPT_DIR / 'myenv' / 'Scripts' / 'python.exe'
    main_py = SCRIPT_DIR / 'main.py'
    
    if not main_py.exists():
        print("✗ main.py not found!")
        return False
    
    try:
        subprocess.run([str(venv_python), str(main_py)], check=True)
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
    
    venv_exists = (SCRIPT_DIR / 'myenv' / 'Scripts' / 'python.exe').exists()
    
    if venv_exists:
        print("✓ Virtual environment already exists")
    else:
        if not create_venv():
            input("\nPress Enter to exit...")
            return False
    
    # Step 3: Install dependencies
    current_step += 1
    print_step(current_step, total_steps, "Installing dependencies")
    
    if check_dependencies():
        print("✓ Dependencies already installed")
    else:
        if not install_dependencies():
            print("\nInstallation failed. Try running SETUP.bat manually.")
            input("\nPress Enter to exit...")
            return False
    
    # Step 4: Launch application
    current_step += 1
    print_step(current_step, total_steps, "Launching application")
    
    if not launch_application():
        input("\nPress Enter to exit...")
        return False
    
    print_header("Installation Complete!")
    print("✓ All components installed successfully")
    print("✓ Application launched")
    print("\nNext time, you can run START.bat for faster launch")
    print("\n" + "=" * 70)
    
    return True

if __name__ == '__main__':
    try:
        success = main()
        if success:
            sys.exit(0)
        else:
            sys.exit(1)
    except KeyboardInterrupt:
        print("\n\nInstallation cancelled by user")
        sys.exit(1)
    except Exception as e:
        print(f"\n\nUnexpected error: {e}")
        input("Press Enter to exit...")
        sys.exit(1)
