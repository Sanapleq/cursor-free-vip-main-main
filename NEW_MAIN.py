# Cursor Obxod - Main Application
# Simplified and cleaned version

import os
import sys
import platform
from colorama import Fore, Style, init

# Initialize
init(autoreset=True)

# Import local modules
from core.logo import print_logo
from core.quit_cursor import quit_cursor

# Constants
VERSION = "1.0.0"
TITLE = "Cursor Obxod"

def print_menu():
    """Print main menu"""
    print(f"\n{Fore.CYAN}{'='*60}{Style.RESET_ALL}")
    print(f"{Fore.YELLOW}  {TITLE} v{VERSION}{Style.RESET_ALL}")
    print(f"{Fore.CYAN}{'='*60}{Style.RESET_ALL}")
    print()
    print(f"  {Fore.GREEN}1{Style.RESET_ALL}. Сброс Machine ID")
    print(f"  {Fore.GREEN}2{Style.RESET_ALL}. Регистрация (Google)")
    print(f"  {Fore.GREEN}3{Style.RESET_ALL}. Регистрация (GitHub)")
    print(f"  {Fore.GREEN}4{Style.RESET_ALL}. Закрыть Cursor")
    print(f"  {Fore.GREEN}5{Style.RESET_ALL}. Отключить обновления")
    print(f"  {Fore.GREEN}6{Style.RESET_ALL}. Полный сброс")
    print(f"  {Fore.GREEN}0{Style.RESET_ALL}. Выход")
    print()
    print(f"{Fore.CYAN}{'='*60}{Style.RESET_ALL}")

def main():
    """Main function"""
    print_logo()
    
    # Close Cursor on start
    print(f"\n{Fore.CYAN}Checking Cursor...{Style.RESET_ALL}")
    quit_cursor()
    
    # Main loop
    while True:
        print_menu()
        
        try:
            choice = input(f"\n{Fore.YELLOW}Выберите пункт (0-6): {Style.RESET_ALL}")
            
            if choice == "0":
                print(f"\n{Fore.GREEN}Выход...{Style.RESET_ALL}")
                break
            elif choice == "1":
                print(f"\n{Fore.CYAN}Сброс Machine ID...{Style.RESET_ALL}")
                # TODO: Implement reset_machine_id()
                print(f"{Fore.YELLOW}Функция в разработке{Style.RESET_ALL}")
            elif choice == "2":
                print(f"\n{Fore.CYAN}Регистрация через Google...{Style.RESET_ALL}")
                # TODO: Implement google_oauth()
                print(f"{Fore.YELLOW}Функция в разработке{Style.RESET_ALL}")
            elif choice == "3":
                print(f"\n{Fore.CYAN}Регистрация через GitHub...{Style.RESET_ALL}")
                # TODO: Implement github_oauth()
                print(f"{Fore.YELLOW}Функция в разработке{Style.RESET_ALL}")
            elif choice == "4":
                print(f"\n{Fore.CYAN}Закрытие Cursor...{Style.RESET_ALL}")
                quit_cursor()
            elif choice == "5":
                print(f"\n{Fore.CYAN}Отключение обновлений...{Style.RESET_ALL}")
                # TODO: Implement disable_updates()
                print(f"{Fore.YELLOW}Функция в разработке{Style.RESET_ALL}")
            elif choice == "6":
                print(f"\n{Fore.CYAN}Полный сброс...{Style.RESET_ALL}")
                # TODO: Implement full_reset()
                print(f"{Fore.YELLOW}Функция в разработке{Style.RESET_ALL}")
            else:
                print(f"{Fore.RED}Неверный выбор!{Style.RESET_ALL}")
                
        except KeyboardInterrupt:
            print(f"\n\n{Fore.YELLOW}Прервано пользователем{Style.RESET_ALL}")
            break
        except Exception as e:
            print(f"{Fore.RED}Ошибка: {e}{Style.RESET_ALL}")

if __name__ == "__main__":
    main()
