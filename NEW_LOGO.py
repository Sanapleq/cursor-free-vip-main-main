# Simple logo for Cursor Obxod

from colorama import Fore, Style

LOGO = f"""
{Fore.CYAN}
╔══════════════════════════════════════╗
║       CURSOR OBXHOD v1.0.0          ║
║    Простой обход ограничений         ║
╚══════════════════════════════════════╝
{Style.RESET_ALL}
"""

def print_logo():
    """Print logo"""
    print(LOGO)
