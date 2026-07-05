# 🏪 Mini Marketplace - Application Mobile

Une plateforme mobile complète de petites annonces construite avec **Flutter** et **Node.js**.

## 📋 Vue d'ensemble

**Mini Marketplace** est une application mobile de marketplace permettant aux utilisateurs de:

- ✅ Se connecter / s'inscrire
- ✅ Consulter des annonces (avec filtrage par catégorie)
- ✅ Voir les détails d'une annonce
- ✅ Publier ses propres annonces
- ✅ Échanger des messages avec d'autres utilisateurs
- ✅ Gérer son profil

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────┐
│                   FRONTEND (Flutter)                 │
│  - Écrans UI (Home, Details, Profile, etc.)         │
│  - Providers (State Management)                      │
│  - Services (API Calls)                              │
└────────────┬────────────────────────────────────────┘
             │  HTTP Requests
             ▼
┌─────────────────────────────────────────────────────┐
│   BACKEND (JSON Server - Node.js)                   │
│  - API REST (Endpoints pour users, annonces, etc.)  │
│  - Routes personnalisées (routes.json)              │
│  - Base de données (db.json)                        │
└─────────────────────────────────────────────────────┘
```

## ⚡ Démarrage Rapide

### Sur Windows

```bash
start.bat
```

### Sur macOS/Linux

```bash
bash start.sh
```

### Manuel

#### 1. Backend

```bash
cd backend
npm install
npm start
```

#### 2. Frontend (nouvel onglet/terminal)

```bash
cd frontend
flutter pub get
flutter run
```

**Résultat attendu**: L'app s'ouvre sur émulateur ou appareil physique.

## 🔐 Identifiants de Test

| Rôle     | Email              | Mot de passe     |
| -------- | ------------------ | ---------------- |
| Vendeur  | seller@example.com | (non nécessaire) |
| Acheteur | buyer@example.com  | (non nécessaire) |

## 📂 Structure du Projet

```
app-mobile/
├── backend/                              # Serveur Node.js
│   ├── db.json                          # Base de données
│   ├── routes.json                      # Routes personnalisées
│   ├── package.json                     # Dépendances
│   └── README.md                        # Doc backend
│
├── frontend/                            # Application Flutter
│   ├── lib/
│   │   ├── main.dart                    # Point d'entrée
│   │   ├── models/                      # Modèles (User, Annonce, Message)
│   │   ├── services/                    # Services API
│   │   ├── providers/                   # Providers (State)
│   │   ├── screens/                     # Écrans UI
│   │   └── widgets/                     # Widgets réutilisables
│   ├── pubspec.yaml                     # Dépendances Flutter
│   └── README.md                        # Doc frontend
│
├── LANCEMENT.md                         # Guide complet de lancement
├── start.sh                             # Script démarrage (Linux/macOS)
├── start.bat                            # Script démarrage (Windows)
└── README.md                            # Ce fichier
```

## 🎯 Fonctionnalités Principales

### Authentification

- ✅ Login avec email
- ✅ Inscription avec nom, email, téléphone
- ✅ Persistance de session (SharedPreferences)

### Annonces

- ✅ Affichage liste d'annonces
- ✅ Filtre par catégorie
- ✅ Recherche par titre
- ✅ Détails de l'annonce
- ✅ Créer/Modifier/Supprimer annonce
- ✅ Gestion du statut (active/sold)

### Messagerie

- ✅ Conversations
- ✅ Messages entre vendeur/acheteur
- ✅ Marquer comme lu

### Profil

- ✅ Affichage profil utilisateur
- ✅ Gestion de la session
- ✅ Logout

## 🛠️ Technologie

### Frontend

- **Flutter** 3.4.0+
- **Provider** 6.1.2 (State Management)
- **HTTP** 1.2.2 (API Calls)
- **Shared Preferences** 2.3.2 (Local Storage)
- **Material 3** Design

### Backend

- **Node.js**
- **JSON Server** 1.0.0-beta.3 (Mock API)
- **json-server-routes** (Routes personnalisées)

## 📡 API Endpoints

### Utilisateurs

- `GET /users` - Tous les utilisateurs
- `GET /users?email=xxx` - Rechercher par email
- `POST /users` - Créer utilisateur
- `PUT /users/:id` - Modifier utilisateur

### Annonces

- `GET /annonces` - Toutes les annonces
- `GET /annonces?categorie=c1` - Filter par catégorie
- `GET /annonces?titre_like=xxx` - Recherche
- `GET /annonces/:id` - Détails annonce
- `POST /annonces` - Créer annonce
- `PUT /annonces/:id` - Modifier annonce
- `DELETE /annonces/:id` - Supprimer annonce

### Messages

- `GET /messages` - Tous les messages
- `GET /messages?annonceId=xxx` - Messages d'une annonce
- `POST /messages` - Envoyer message
- `PATCH /messages/:id` - Marquer comme lu

### Conversations

- `GET /conversations?userId=xxx` - Conversations utilisateur

## 🔧 Configuration

### URL Backend

**Pour Android Emulator** (par défaut):

```dart
// lib/services/api_service.dart
static const String baseUrl = 'http://10.0.2.2:3001';
```

**Pour Appareil Physique** - Remplacer par l'IP locale:

```dart
static const String baseUrl = 'http://192.168.1.XX:3001';
```

Pour trouver votre IP locale:

- **Windows**: `ipconfig` → chercher "IPv4 Address"
- **macOS/Linux**: `ifconfig` → chercher "inet" (192.168.x.x)

## 🚀 Développement

### Hot Reload

```bash
r   # Rechargement (maintient l'état)
R   # Redémarrage (réinitialise l'état)
q   # Quitter
```

### Logs

```bash
flutter logs   # Voir les logs
```

### Build APK

```bash
flutter build apk
```

## 📚 Ressources

- [Flutter Documentation](https://flutter.dev)
- [Provider Package](https://pub.dev/packages/provider)
- [JSON Server](https://github.com/typicode/json-server)
- [Material 3 Design](https://m3.material.io)

## 🎓 Apprentissage

Ce projet couvre:

- ✅ Architecture MVVM avec Provider
- ✅ Appels API REST (GET, POST, PUT, DELETE, PATCH)
- ✅ Gestion d'erreurs
- ✅ Navigation (MaterialPageRoute)
- ✅ Persistance locale
- ✅ Widgets réutilisables
- ✅ Forms & Validation
- ✅ State Management
- ✅ Async/Await

## 🐛 Dépannage

### Erreur de connexion backend

```
❌ Failed to connect to backend

✅ Solution:
1. Vérifiez que npm start tourne sur port 3001
2. Pour Android Emulator: utilisez http://10.0.2.2:3001
3. Pour appareil physique: remplacez IP dans api_service.dart
4. Vérifiez le firewall
```

### Annonces non chargées

```
❌ Pas de données

✅ Solution:
1. Vérifiez console pour les erreurs
2. Testez manuellement: curl http://localhost:3001/annonces
3. Vérifiez db.json n'est pas vide
```

## 📝 Améliorations Futures

- [ ] Authentification sécurisée (JWT)
- [ ] Upload de photos
- [ ] Notifications push
- [ ] Paiements (Stripe, PayPal)
- [ ] Critères de recherche avancée
- [ ] Système de notation
- [ ] Favoris/Wishlist
- [ ] Historique

## 📞 Support

Pour toute question:

1. Consultez [LANCEMENT.md](LANCEMENT.md) pour le guide complet
2. Vérifiez les logs: `flutter logs`
3. Consultez la documentation officielle

## 📄 Licence

Ce projet est fourni à titre d'exemple éducatif.

---

**Créé avec ❤️ pour apprendre Flutter et Node.js**

Version: 1.0.0 | Mise à jour: 2026-07-05
