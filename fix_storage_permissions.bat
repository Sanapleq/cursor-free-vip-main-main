@echo off
echo ==================================================
echo Решение проблемы с правами доступа к storage.json
echo ==================================================
echo.

echo 1. Закрываем все процессы Cursor...
taskkill /F /IM cursor.exe 2>nul
taskkill /F /IM "cursor helper.exe" 2>nul
echo    Готово!
echo.

echo 2. Снимаем атрибут "Только для чтения"...
attrib -R "%APPDATA%\Cursor\User\globalStorage\storage.json"
echo    Готово!
echo.

echo 3. Проверяем файл...
if exist "%APPDATA%\Cursor\User\globalStorage\storage.json" (
    echo    Файл найден!
    attrib "%APPDATA%\Cursor\User\globalStorage\storage.json"
) else (
    echo    Файл не найден! Запустите Cursor хотя бы раз.
)
echo.

echo ==================================================
echo Теперь запустите main.py:
echo   cd "h:\cursor-free-vip-main-main"
echo   .\myenv\Scripts\python.exe main.py
echo ==================================================
echo.
pause
