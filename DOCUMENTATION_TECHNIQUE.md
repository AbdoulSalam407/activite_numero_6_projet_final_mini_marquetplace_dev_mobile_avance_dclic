# DOCUMENTATION TECHNIQUE
## Mini Marketplace – Application Mobile Flutter

---

| Champ     | Détail                                |
|-----------|---------------------------------------|
| Auteur    | Abdoul Salam DIALLO                   |
| Formation | Développement Mobile Avancé – DCLIC   |
| Date      | Juillet 2026                          |
| Version   | 1.0.0                                 |

---

## 1. Prérequis

| Outil | Version minimale |
|---|---|
| Flutter SDK | 3.4.0 |
| Dart SDK | 3.4.0 |
| Node.js | 18.x |
| npm | 9.x |
| Android SDK | API 21+ |

---

## 2. Installation et lancement

### 2.1 Cloner le projet

```bash
git clone https://github.com/AbdoulSalam407/activite_numero_6_projet_final_mini_marquetplace_dev_mobile_avance_dclic.git
cd app-mobile
```

### 2.2 Lancer le backend (local)

```bash
cd backend
npm install
npm run dev
# Serveur accessible sur http://localhost:3001
```

### 2.3 Lancer le frontend

```bash
cd frontend
flutter pub get
flutter run
```

### 2.4 Build APK Android

```bash
flutter build apk --release
# APK généré : build/app/outputs/flutter-apk/app-release.apk
```

### 2.5 Build Web

```bash
flutter build web --web-renderer html
# Dossier généré : build/web/
```

---

## 3. Configuration de l'API

Fichier : `frontend/lib/config/api_config.dart`

```dart
class ApiConfig {
  // URL de production (Render)
  static const String? productionUrl =
      'https://activite-numero-6-projet-final-mini.onrender.com';

  // IP locale pour appareil physique (null = auto)
  static const String? customIpAddress = null;

  static const int backendPort = 3001;
}
```

| Environnement | URL utilisée |
|---|---|
| Production | `productionUrl` si défini |
| Web (local) | `http://localhost:3001` |
| Émulateur Android | `http://10.0.2.2:3001` |
| Appareil physique | IP définie dans `customIpAddress` |

---

## 4. API REST – Endpoints

Base URL : `https://activite-numero-6-projet-final-mini.onrender.com`

### 4.1 Utilisateurs

| Méthode | Endpoint | Description |
|---|---|---|
| GET | `/users?email={email}` | Recherche par email (login) |
| POST | `/users` | Créer un utilisateur |
| PUT | `/users/{id}` | Modifier un utilisateur |
| GET | `/users/{id}` | Récupérer un utilisateur |

### 4.2 Annonces

| Méthode | Endpoint | Description |
|---|---|---|
| GET | `/annonces` | Toutes les annonces actives |
| GET | `/annonces?categorie={id}` | Filtrer par catégorie |
| GET | `/annonces?titre_like={q}` | Recherche par titre |
| GET | `/annonces?vendeurId={id}` | Annonces d'un vendeur |
| GET | `/annonces/{id}` | Détail d'une annonce |
| POST | `/annonces` | Créer une annonce |
| PUT | `/annonces/{id}` | Modifier une annonce |
| DELETE | `/annonces/{id}` | Supprimer une annonce |

### 4.3 Messages

| Méthode | Endpoint | Description |
|---|---|---|
| GET | `/messages?annonceId={id}` | Messages d'une annonce |
| POST | `/messages` | Envoyer un message |
| PATCH | `/messages/{id}` | Marquer comme lu |

### 4.4 Conversations

| Méthode | Endpoint | Description |
|---|---|---|
| GET | `/conversations?userId={id}` | Conversations d'un user |
| POST | `/conversations` | Créer une conversation |
| PATCH | `/conversations/{id}` | Mettre à jour |

---

## 5. Structure des données (db.json)

### User
```json
{
  "id": "u1",
  "firstName": "Abdoul",
  "lastName": "Diallo",
  "email": "seller@example.com",
  "phone": "+221770000001",
  "role": "seller",
  "avatar": ""
}
```

### Annonce
```json
{
  "id": "a1",
  "titre": "iPhone 13 Pro Max 256GB",
  "description": "Téléphone en très bon état.",
  "prix": 420000,
  "image": "https://images.unsplash.com/...",
  "categorie": "c1",
  "localisation": "Dakar - Plateau",
  "vendeurId": "u1",
  "condition": "Très bon état",
  "status": "active",
  "createdAt": "2026-06-28T10:00:00.000Z"
}
```

### Message
```json
{
  "id": "m1",
  "annonceId": "a1",
  "fromId": "u2",
  "toId": "u1",
  "content": "Bonjour, toujours disponible ?",
  "read": false,
  "createdAt": "2026-06-30T09:00:00.000Z"
}
```

### Conversation
```json
{
  "id": "conv1",
  "userId": "u2",
  "otherUserId": "u1",
  "otherUserName": "Abdoul Diallo",
  "annonceId": "a1",
  "annonceTitle": "iPhone 13 Pro Max 256GB",
  "lastMessage": "Bonjour, toujours disponible ?",
  "unreadCount": 1,
  "updatedAt": "2026-06-30T09:00:00.000Z"
}
```

---

## 6. Comptes de démonstration

| Rôle | Email | Mot de passe |
|---|---|---|
| Vendeur | seller@example.com | (n'importe lequel) |
| Acheteur | buyer@example.com | (n'importe lequel) |

> Le backend JSON Server ne vérifie pas les mots de passe. La connexion réussit si l'email existe.

---

## 7. Catégories disponibles

| ID | Libellé |
|---|---|
| c1 | Electronique |
| c2 | Mode |
| c3 | Maison |
| c4 | Services |
| c5 | Véhicules |

---

## 8. Gestion des images

- **Mobile** : `image_picker` → sélection galerie → encodage base64
- **Web** : `dart:html FileUploadInputElement` → encodage base64
- **Stockage** : champ `image` en base64 (`data:image/jpeg;base64,...`)
- **Affichage réseau** : URLs Unsplash directes, autres URLs via proxy `images.weserv.nl`
- **Rendu web** : renderer HTML forcé via `web/flutter_bootstrap.js`

---

## 9. Commandes utiles

```bash
# Lister les appareils connectés
flutter devices

# Lancer sur un appareil spécifique
flutter run -d <deviceId>

# Hot reload
r

# Hot restart
R

# Quitter
q

# Voir les logs
flutter logs

# Analyser le code
flutter analyze

# Vérifier l'environnement
flutter doctor
```

---

*Mini Marketplace v1.0.0 – DCLIC – Juillet 2026*
