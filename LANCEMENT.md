# Mini Marketplace - Guide de Lancement

Ce guide explique comment lancer l'application Mini Marketplace avec le backend et frontend connectés.

## Architecture

- **Backend**: JSON Server (Node.js) - Port 3001
- **Frontend**: Flutter - Android/iOS
- **Base de données**: `backend/db.json`

## Prérequis

### Backend

- Node.js 18+ et npm

### Frontend

- Flutter SDK (3.4.0+)
- Android SDK ou iOS SDK configurés
- Un émulateur Android ou un appareil physique

## Démarrage du Backend

### 1. Installer les dépendances

```bash
cd backend
npm install
```

### 2. Lancer le serveur JSON

```bash
npm start
```

ou

```bash
npm run dev
```

**Résultat attendu:**

```
  \{^_^}/ hi!

  Loading db.json
  Done

  Resources
  http://localhost:3001/users
  http://localhost:3001/annonces
  http://localhost:3001/messages
  http://localhost:3001/conversations
  http://localhost:3001/categories
  http://localhost:3001/localisations

  Watching...
```

Le backend sera disponible sur: **http://localhost:3001**

### Routes API Disponibles

- `GET /users` - Liste des utilisateurs
- `GET /annonces` - Toutes les annonces
- `GET /messages` - Messages
- `GET /conversations` - Conversations
- `GET /categories` - Catégories
- `POST /annonces` - Créer une annonce
- `PUT /annonces/:id` - Modifier une annonce
- `DELETE /annonces/:id` - Supprimer une annonce

## Démarrage du Frontend

### 1. Installer les dépendances Flutter

```bash
cd frontend
flutter pub get
```

### 2. Configuration de l'API

L'application est préconfigurée pour se connecter au backend:

- **Android Emulator**: `http://10.0.2.2:3001`
- **Appareil physique**: `http://192.168.x.x:3001` (remplacer par l'IP de votre PC)

Pour modifier l'URL du backend, éditez:
[lib/services/api_service.dart](frontend/lib/services/api_service.dart)

### 3. Lancer l'application

#### Sur émulateur Android:

```bash
flutter run
```

#### Sur un appareil physique Android:

```bash
flutter run -d <device_id>
```

Lisez les appareils disponibles:

```bash
flutter devices
```

#### Sur iOS:

```bash
flutter run -d <device_id>
```

## Données de Test

### Utilisateurs (Login)

**Vendeur:**

- Email: `seller@example.com`
- Mot de passe: (non vérifié en démo)

**Acheteur:**

- Email: `buyer@example.com`
- Mot de passe: (non vérifié en démo)

### Annonces Disponibles

1. **iPhone 13 Pro Max 256GB** - 420,000 CFA (Vendeur: u1)
2. **Canapé moderne 5 places** - 180,000 CFA (Vendeur: u1)
3. **Ordinateur portable HP** - 310,000 CFA (Vendeur: u2)
4. **Service livraison rapide** - 5,000 CFA (Vendeur: u1)

## Architecture de l'Application

```
frontend/
├── lib/
│   ├── main.dart                    # Point d'entrée avec MultiProvider
│   ├── models/
│   │   ├── annonce.dart            # Modèle des annonces
│   │   ├── message.dart            # Modèle des messages
│   │   └── user.dart               # Modèle des utilisateurs
│   ├── services/
│   │   ├── api_service.dart        # Service API (HTTP requests)
│   │   ├── auth_service.dart       # Authentification
│   │   ├── annonce_service.dart    # Gestion des annonces
│   │   └── message_service.dart    # Gestion des messages
│   ├── providers/
│   │   ├── auth_provider.dart      # Provider pour l'auth
│   │   ├── annonce_provider.dart   # Provider pour les annonces
│   │   └── message_provider.dart   # Provider pour les messages
│   ├── screens/
│   │   ├── splash_screen.dart      # Écran de démarrage
│   │   ├── login_screen.dart       # Connexion
│   │   ├── register_screen.dart    # Inscription
│   │   ├── home_screen.dart        # Accueil
│   │   ├── categories_screen.dart  # Catégories
│   │   ├── profile_screen.dart     # Profil utilisateur
│   │   ├── shell_screen.dart       # Navigation principale
│   │   └── ...
│   └── widgets/
│       ├── app_colors.dart         # Couleurs de l'app
│       ├── annonce_card.dart       # Widget annonce
│       └── primary_button.dart     # Bouton principal

backend/
├── db.json                          # Base de données JSON
├── routes.json                      # Configuration des routes
├── package.json                     # Dépendances Node
└── README.md                        # Doc backend
```

## État de Management

L'application utilise **Provider** pour la gestion d'état:

- `AuthProvider` - Gère la connexion/inscription
- `AnnonceProvider` - Gère les annonces
- `MessageProvider` - Gère les conversations/messages

## Dépannage

### Erreur de connexion au backend

**Problème**: "Failed to connect to backend"

**Solution**:

1. Vérifiez que le backend json-server est lancé sur le port 3001
2. Pour Android Emulator: utilisez `http://10.0.2.2:3001`
3. Pour appareil physique: remplacez `10.0.2.2` par l'IP locale de votre PC
4. Vérifiez que le firewall n'affiche pas le port 3001

### Annonces non chargées

**Problème**: "Pas d'annonces affichées"

**Solution**:

1. Vérifiez que le backend est lancé
2. Consultez la console pour les erreurs d'API
3. Vérifiez le contenu de `backend/db.json`

### Erreur d'authentification

**Problème**: "Email ou mot de passe incorrect"

**Solution**:

- Utilisez l'email exact: `seller@example.com` ou `buyer@example.com`
- Le mot de passe n'est pas validé en mode démo

## Hot Reload & Hot Restart

```bash
# Rechargement à chaud (maintient l'état)
r

# Redémarrage à chaud (réinitialise l'état)
R

# Quitter
q
```

## Prochaines Étapes

1. ✅ Backend connecté et functional
2. ✅ Frontend prêt à être lancé
3. TODO: Ajouter plus de fonctionnalités
4. TODO: Ajouter la photo de profil
5. TODO: Implémenter les notifications
6. TODO: Ajouter les paiements

## Support

Pour toute question sur:

- **Backend (JSON Server)**: Consultez [json-server](https://github.com/typicode/json-server)
- **Flutter**: Consultez [flutter.dev](https://flutter.dev)
- **Provider**: Consultez [pub.dev/packages/provider](https://pub.dev/packages/provider)
