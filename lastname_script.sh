#!/bin/bash

# Перевірка наявності аргументу
if [ $# -ne 1 ]; then
    echo "Usage: $0 <path_to_log_file>"
    exit 1
fi

LOG_FILE="$1"

# Перевірка існування файлу та прав на читання
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File '$LOG_FILE' does not exist."
    exit 1
fi

if [ ! -r "$LOG_FILE" ]; then
    echo "Error: No read permission for file '$LOG_FILE'."
    exit 1
fi

# Підрахунок рядків з "Failed" або "Error" (case-insensitive)
ERROR_COUNT=$(grep -ic -E 'Failed|Error' "$LOG_FILE")

echo "Number of lines containing 'Failed' or 'Error': $ERROR_COUNT"

# Список останніх 10 унікальних IP-адрес
echo ""
echo "Last 10 unique IP addresses:"
grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}' "$LOG_FILE" | tail -n 10 | sort -u | uniq

# Попередження при високій кількості помилок
if [ "$ERROR_COUNT" -gt 20 ]; then
    echo ""
    echo "Warning: High error rate detected"
fi
