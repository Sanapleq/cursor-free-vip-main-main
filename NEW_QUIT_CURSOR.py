# Quit Cursor - Simple version

import subprocess
import time
from colorama import Fore, Style

def quit_cursor():
    """Close all Cursor processes"""
    print(f"  Closing Cursor processes...")
    
    processes = ["cursor.exe", "cursor helper.exe"]
    
    for proc in processes:
        try:
            subprocess.run(f'taskkill /IM {proc} /F', 
                         shell=True, 
                         capture_output=True, 
                         timeout=5)
            print(f"  ✓ Closed {proc}")
        except:
            print(f"  - {proc} not running")
    
    time.sleep(1)
    print(f"  {Fore.GREEN}Done!{Style.RESET_ALL}")
