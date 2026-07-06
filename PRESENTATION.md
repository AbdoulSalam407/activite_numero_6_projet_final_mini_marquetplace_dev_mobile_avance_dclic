# PRÉSENTATION DU PROJET
## Mini Marketplace – Application Mobile Flutter

---

**Auteur** : Abdoul Salam DIALLO
**Formation** : Développement Mobile Avancé – DCLIC
**Date** : Juillet 2026

---

## Slide 1 — Titre

# MINI MARKETPLACE
### Application Mobile de Petites Annonces

> Développée avec Flutter • Backend Node.js • Déployée sur Render

---

## Slide 2 — Contexte & Problématique

### Contexte
- Le commerce informel entre particuliers est très actif au Sénégal
- Les échanges se font principalement via réseaux sociaux, de façon désorganisée
- Absence d'une plateforme mobile dédiée, simple et accessible

### Problématique
> Comment centraliser la publication et la consultation d'annonces entre particuliers sur mobile, avec une messagerie intégrée ?

---

## Slide 3 — Objectifs du projet

✅ Permettre l'inscription et la connexion avec persistance de session

✅ Afficher, filtrer et rechercher des annonces

✅ Permettre aux vendeurs de publier et gérer leurs annonces

✅ Intégrer une messagerie directe acheteur ↔ vendeur

✅ Déployer l'application sur Android et Web

✅ Héberger le backend sur un service cloud (Render)

---

## Slide 4 — Fonctionnalités principales

| Module | Fonctionnalité |
|---|---|
| 🔐 Auth | Inscription, connexion, session persistante |
| 📋 Annonces | Liste, filtrage, recherche, détail |
| ➕ Publication | Créer / modifier / supprimer une annonce |
| 🖼️ Image | Upload depuis galerie (mobile + web) |
| 💬 Messagerie | Contacter vendeur, conversations, chat |
| 👤 Profil | Informations, mes annonces, déconnexion |

---

## Slide 5 — Architecture technique

```
┌─────────────────────────────────┐
│        Flutter Frontend         │
│   Screens → Providers → Services│
└──────────────┬──────────────────┘
               │ HTTP REST / JSON
┌──────────────▼──────────────────┐
│   Backend JSON Server (Render)  │
│  /annonces /users /messages     │
└─────────────────────────────────┘
```

**Pattern MVVM** avec Provider (ChangeNotifier)

- **Model** : `Annonce`, `User`, `Message`, `Conversation`
- **ViewModel** : `AuthProvider`, `AnnonceProvider`, `MessageProvider`
- **View** : 12 écrans Flutter

---

## Slide 6 — Technologies utilisées

| Frontend | Backend |
|---|---|
| Flutter 3.4+ | Node.js |
| Dart | JSON Server 0.17 |
| Provider 6.1 | Render.com |
| HTTP 1.2 | |
| SharedPreferences | |
| CachedNetworkImage | |
| ImagePicker 1.2 | |
| Material Design 3 | |

---

## Slide 7 — Parcours utilisateur

```
Démarrage
    │
    ├─► [Non connecté] Onboarding → Login / Inscription
    │
    └─► [Connecté] Accueil
              │
              ├─► Filtrer par catégorie
              ├─► Rechercher une annonce
              ├─► Voir le détail → Contacter vendeur
              │                         └─► Chat
              ├─► Catégories → Produits → Détail
              ├─► Messages → Conversations → Chat
              └─► Profil → Mes annonces / Déconnexion
```

---

## Slide 8 — Démonstration

### Écrans clés

1. **Splash Screen** — animation fade + logo
2. **Onboarding** — présentation en 3 pages
3. **Accueil** — grille d'annonces avec filtres
4. **Détail annonce** — image, prix, bouton contacter
5. **Créer une annonce** — formulaire + upload image
6. **Messagerie** — conversations + chat

### Comptes de test
| Rôle | Email |
|---|---|
| Vendeur | seller@example.com |
| Acheteur | buyer@example.com |

---

## Slide 9 — Résultats des tests

| Catégorie | Tests | Réussite |
|---|---|---|
| Authentification | 13 | 100% |
| Annonces | 18 | 100% |
| Messagerie | 9 | 100% |
| Navigation | 6 | 100% |
| Profil | 4 | 100% |
| Réseau | 4 | 75% |
| **Total** | **54** | **98%** |

> 1 anomalie connue : timeout si Render met > 60s à démarrer (plan gratuit)

---

## Slide 10 — Déploiement

### Backend
- Hébergé sur **Render.com** (plan gratuit)
- URL : `https://activite-numero-6-projet-final-mini.onrender.com`
- Démarrage automatique à chaque push sur GitHub

### Frontend
- Compatible **Android** (APK) et **Web** (navigateur)
- Renderer HTML forcé pour compatibilité CORS
- Configuration API centralisée dans `api_config.dart`

---

## Slide 11 — Difficultés rencontrées

| Problème | Solution apportée |
|---|---|
| CORS sur Flutter Web avec images externes | Proxy `images.weserv.nl` + renderer HTML |
| `dart:html` incompatible Android | Abstraction multi-plateforme (`image_picker_web.dart` / `image_picker_mobile.dart`) |
| Timeout backend Render (cold start) | Timeout HTTP porté à 60 secondes |
| `AppBar.subtitle` inexistant | Remplacement par `Column` dans `title` |
| `const ShellScreen()` vs `GlobalKey` | `shellKey` pour navigation programmatique |

---

## Slide 12 — Perspectives d'amélioration

- 🔐 Authentification sécurisée avec JWT + hachage bcrypt
- 🗄️ Base de données persistante (PostgreSQL / MongoDB)
- 🖼️ Upload images vers Cloudinary ou Firebase Storage
- 🔔 Notifications push (Firebase Cloud Messaging)
- ⭐ Système de notation des vendeurs
- ❤️ Gestion des favoris
- 📄 Pagination des annonces

---

## Slide 13 — Conclusion

> Mini Marketplace est une application mobile complète, déployée et fonctionnelle sur Android et Web.

Elle démontre la maîtrise de :
- **Flutter** multiplateforme
- **Architecture MVVM** avec Provider
- **Intégration API REST** (CRUD complet)
- **Gestion d'état réactif**
- **Déploiement cloud** (Render)

---

**Merci pour votre attention**

*Questions ?*

---

*Mini Marketplace v1.0.0 – DCLIC – Juillet 2026*
