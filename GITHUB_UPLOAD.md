# 🚀 GitHub Upload Instructions for Cursor Free VIP

## 📦 Подготовка проекта к выгрузке

### 1. Очистка проекта

```powershell
# Удалить временные файлы
Remove-Item -Recurse -Force __pycache__ -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force .pytest_cache -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force .mypy_cache -ErrorAction SilentlyContinue
Remove-Item *.log -ErrorAction SilentlyContinue
Remove-Item *.tmp -ErrorAction SilentlyContinue

# Удалить тестовые файлы
Remove-Item test_*.py -ErrorAction SilentlyContinue
Remove-Item test_output.txt -ErrorAction SilentlyContinue
```

### 2. Инициализация Git

```powershell
cd "h:\cursor-free-vip-main-main"

# Инициализировать репозиторий
git init

# Добавить все файлы
git add .

# Сделать первый коммит
git commit -m "Initial commit: Fixed Cursor Free VIP with all improvements"

# Добавить удаленный репозиторий (замените URL на свой)
git remote add origin https://github.com/YOUR_USERNAME/cursor-free-vip-main.git

# Отправить на GitHub
git branch -M main
git push -u origin main
```

### 3. Создание релиза

```powershell
# Создать тег версии
git tag -a v1.11.05 -m "Fixed version with UTF-8 BOM and permission fixes"

# Отправить тег
git push origin --tags
```

---

## 📝 Файлы для выгрузки

### ✅ Основные файлы (COMMIT):
- `main.py` - Главный файл
- `config.py` - Конфигурация (исправлена)
- `utils.py` - Утилиты
- `logo.py` - Логотип
- `version.py` - Версионирование
- `requirements.txt` - Зависимости
- `README.md` - Документация
- `.gitignore` - Игнор файлы
- `locales/` - Локализации
- `scripts/` - Скрипты установки
- `images/` - Изображения
- `email_tabs/` - Email модули
- `drivers/` - Драйверы (опционально)

### ❌ Файлы для исключения (IGNORE):
- `myenv/` - Виртуальное окружение
- `__pycache__/` - Кеш Python
- `*.pyc` - Скомпилированные файлы
- `.env` - Конфигурация пользователя
- `*.log` - Логи
- `dist/`, `build/` - Build артефакты
- `test_*.py` - Тестовые файлы

---

## 🔧 Изменения в проекте

### Исправленные проблемы:

1. **UTF-8 BOM ошибка**
   - Файлы: `cursor_acc_info.py`
   - Решение: `encoding='utf-8-sig'` вместо `utf-8`

2. **Права доступа к файлам**
   - Файлы: `reset_machine_manual.py`
   - Решение: Реальная проверка записи через `open()`

3. **Циклические импорты**
   - Файлы: `config.py`, `main.py`
   - Решение: Lazy import паттерн

4. **Совместимость Python 3.14**
   - Файл: `requirements.txt`
   - Решение: Обновлены версии пакетов

---

## 📄 Документация для GitHub

### Структура README.md:

```markdown
# Cursor Free VIP

[Описание проекта]

## ✨ Особенности
- [Список функций]

## 🚀 Быстрый старт
```powershell
# Команды для запуска
```

## 📦 Установка
[Инструкция]

## 🔧 Исправления
[Список исправленных проблем]

## 📝 Changelog
[История изменений]

## ⚠️ Важные замечания
- Требуются права администратора
- Закрыть Cursor перед использованием
- Только для образовательных целей

## 📄 License
[Лицензия]
```

---

## 🎯 Чек-лист перед публикацией

- [ ] Очистить временные файлы
- [ ] Проверить .gitignore
- [ ] Обновить README.md
- [ ] Добавить CHANGELOG.md
- [ ] Проверить все импорты
- [ ] Протестировать запуск
- [ ] Создать первый коммит
- [ ] Создать релизный тег
- [ ] Опубликовать на GitHub

---

## 📦 Команды для быстрой публикации

```powershell
# 1. Очистка
cd "h:\cursor-free-vip-main-main"
Remove-Item -Recurse -Force __pycache__, .pytest_cache -ErrorAction SilentlyContinue

# 2. Git
git init
git add .
git commit -m "Fixed version with UTF-8 BOM and permission improvements"

# 3. GitHub (замените URL)
git remote add origin https://github.com/YOUR_USERNAME/cursor-free-vip-main.git
git branch -M main
git push -u origin main

# 4. Тег
git tag -a v1.11.05 -m "Major fixes: BOM encoding, permissions, circular imports"
git push origin --tags
```

---

## ✅ Готово!

Проект готов к публикации на GitHub!

**URL репозитория:** `https://github.com/YOUR_USERNAME/cursor-free-vip-main`
