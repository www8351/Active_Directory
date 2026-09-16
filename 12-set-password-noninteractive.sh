#!/bin/bash
# הגדרת סיסמה למשתמש בלי אינטראקציה, לשימוש בסקריפטים אוטומטיים בלבד
# Set a user's password non-interactively, for automated scripts only
set -e
if [ "$EUID" -ne 0 ]; then echo "Run as root (sudo)"; exit 1; fi

USERNAME="$1"
PASSWORD="$2"
if [ -z "$USERNAME" ] || [ -z "$PASSWORD" ]; then
  echo "Usage: sudo $0 <username> <password>"
  exit 1
fi

echo "$USERNAME:$PASSWORD" | chpasswd
echo "Password set for '$USERNAME'."
echo "Warning: a password passed as a CLI argument may appear in shell history / process list."
