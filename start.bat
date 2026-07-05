@echo off
REM Script de démarrage du Mini Marketplace (Windows)

setlocal enabledelayedexpansion

echo.
echo 🚀 Mini Marketplace - Démarrage
echo ================================
echo.

REM Déterminer le répertoire courant
set SCRIPT_DIR=%~dp0

echo 1️⃣  Démarrage du backend...
echo.

cd /d "%SCRIPT_DIR%backend"

REM Vérifier si node_modules existe
if not exist "node_modules" (
    echo 📦 Installation des dépendances backend...
    call npm install
    echo.
)

echo ✅ Backend lancé sur http://localhost:3001
echo.
echo 2️⃣  Ouvrez un nouvel terminal pour Flutter
echo.
echo Exécutez dans un nouvel terminal:
echo.
echo     cd %SCRIPT_DIR%frontend
echo     flutter pub get
echo     flutter run
echo.
echo 📱 Pour tester, utilisez:
echo     Email: seller@example.com ou buyer@example.com
echo.

call npm start

pause
