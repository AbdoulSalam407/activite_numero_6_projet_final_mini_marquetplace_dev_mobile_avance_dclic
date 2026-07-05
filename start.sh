#!/bin/bash
# Script de démarrage du Mini Marketplace

echo "🚀 Mini Marketplace - Démarrage"
echo "================================"

# Déterminer le répertoire courant
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo ""
echo "1️⃣  Démarrage du backend..."
echo ""

cd "$SCRIPT_DIR/backend"

# Vérifier si node_modules existe
if [ ! -d "node_modules" ]; then
    echo "📦 Installation des dépendances backend..."
    npm install
    echo ""
fi

echo "✅ Backend démarré sur http://localhost:3001"
echo ""
echo "2️⃣  Onglet terminal Flutter"
echo ""
echo "Ouvrez un nouvel onglet/terminal et exécutez:"
echo ""
echo "    cd $SCRIPT_DIR/frontend"
echo "    flutter pub get"
echo "    flutter run"
echo ""
echo "📱 Pour tester, utilisez:"
echo "    Email: seller@example.com ou buyer@example.com"
echo ""

npm start
