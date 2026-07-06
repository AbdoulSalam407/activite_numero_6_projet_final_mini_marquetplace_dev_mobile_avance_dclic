# CAHIER DES CHARGES
## Application Mobile : Mini Marketplace

---

| Champ         | Détail                                      |
|---------------|---------------------------------------------|
| **Titre**     | Mini Marketplace – Application Mobile       |
| **Auteur**    | Abdoul Salam DIALLO                         |
| **Formation** | Développement Mobile Avancé – DCLIC         |
| **Date**      | Juillet 2026                                |
| **Version**   | 1.0.0                                       |

---

## 1. Contexte

Le commerce informel et la revente d'articles de seconde main sont très répandus en Afrique de l'Ouest, notamment au Sénégal. La majorité des transactions se font de façon désorganisée via les réseaux sociaux, sans plateforme dédiée permettant de centraliser les offres, de filtrer par catégorie ou de contacter directement le vendeur.

Mini Marketplace répond à ce besoin en proposant une application mobile simple, rapide et accessible, permettant à tout utilisateur de publier ou de consulter des annonces, et d'entrer en contact avec les vendeurs en temps réel.

---

## 2. Problématique

Comment faciliter la mise en relation entre acheteurs et vendeurs de manière simple, accessible et centralisée sur mobile, sans nécessiter de compétences techniques particulières ?

---

## 3. Objectifs

### 3.1 Objectif général
Développer une application mobile de petites annonces permettant la publication, la consultation et l'échange autour de produits ou services entre particuliers.

### 3.2 Objectifs spécifiques
- Permettre à tout utilisateur de s'inscrire et se connecter
- Permettre aux vendeurs de publier, modifier et supprimer leurs annonces
- Permettre aux acheteurs de parcourir, filtrer et rechercher des annonces
- Permettre la messagerie directe entre acheteur et vendeur
- Assurer la persistance de session pour une meilleure expérience utilisateur

---

## 4. Utilisateurs cibles

| Profil     | Description                                                  |
|------------|--------------------------------------------------------------|
| **Acheteur** | Particulier cherchant à acheter des produits ou services   |
| **Vendeur**  | Particulier ou commerçant souhaitant publier des annonces  |

Un utilisateur peut être à la fois acheteur et vendeur selon son rôle choisi à l'inscription.

---

## 5. Fonctionnalités

### 5.1 Authentification
- Inscription avec prénom, nom, email, téléphone et rôle (acheteur/vendeur)
- Connexion par email
- Persistance de session via stockage local
- Déconnexion

### 5.2 Annonces
- Affichage de la liste de toutes les annonces actives
- Filtrage par catégorie (Électronique, Mode, Maison, Services, Véhicules)
- Recherche par mot-clé dans le titre
- Consultation du détail d'une annonce (titre, description, prix, localisation, condition, image)
- Création d'une annonce avec upload d'image depuis la galerie ou URL
- Modification d'une annonce (réservé au vendeur propriétaire)
- Suppression d'une annonce (réservé au vendeur propriétaire)
- Marquage d'une annonce comme vendue

### 5.3 Messagerie
- Envoi d'un premier message depuis la fiche d'une annonce
- Affichage de la liste des conversations de l'utilisateur
- Échange de messages en temps réel dans une conversation
- Compteur de messages non lus

### 5.4 Profil
- Affichage des informations de l'utilisateur connecté
- Affichage des annonces publiées par le vendeur
- Déconnexion

---

## 6. Contraintes techniques

### 6.1 Frontend
- Framework : **Flutter** (Dart)
- Compatibilité : Android, Web
- Gestion d'état : **Provider**
- Stockage local : **SharedPreferences**
- Design : **Material Design 3**

### 6.2 Backend
- Environnement : **Node.js**
- Serveur API : **JSON Server** (REST)
- Hébergement : **Render.com**
- Format de données : JSON

### 6.3 Communication
- Protocole : **HTTP/REST**
- Format d'échange : **JSON**
- Bibliothèque HTTP : package `http` (Flutter)

### 6.4 Gestion des images
- Upload depuis la galerie de l'appareil (mobile)
- Sélection via le navigateur (web)
- Stockage en base64 dans la base de données
- Affichage des images distantes via proxy CORS (`images.weserv.nl`)

---

## 7. Besoins fonctionnels

| ID   | Besoin                                                                 |
|------|------------------------------------------------------------------------|
| BF01 | L'utilisateur doit pouvoir créer un compte avec son email              |
| BF02 | L'utilisateur doit pouvoir se connecter et rester connecté             |
| BF03 | L'utilisateur doit pouvoir consulter les annonces sans être connecté   |
| BF04 | Le vendeur doit pouvoir publier une annonce avec image                 |
| BF05 | Le vendeur doit pouvoir modifier ou supprimer ses annonces             |
| BF06 | L'acheteur doit pouvoir filtrer les annonces par catégorie             |
| BF07 | L'acheteur doit pouvoir rechercher une annonce par mot-clé             |
| BF08 | L'acheteur doit pouvoir contacter un vendeur via la messagerie         |
| BF09 | L'utilisateur doit pouvoir consulter ses conversations                 |
| BF10 | L'utilisateur doit pouvoir se déconnecter                              |

---

## 8. Besoins non fonctionnels

| ID    | Besoin              | Description                                                         |
|-------|---------------------|---------------------------------------------------------------------|
| BNF01 | Performance         | L'application doit répondre en moins de 3 secondes (hors cold start backend) |
| BNF02 | Disponibilité       | Le backend doit être accessible 24h/24 via Render                  |
| BNF03 | Ergonomie           | L'interface doit être intuitive et navigable en moins de 3 clics   |
| BNF04 | Compatibilité       | L'application doit fonctionner sur Android et navigateur web       |
| BNF05 | Sécurité minimale   | Les mots de passe ne doivent pas être stockés en clair             |
| BNF06 | Maintenabilité      | L'architecture doit suivre le pattern MVVM                         |
| BNF07 | Accessibilité       | Les contrastes et la taille des boutons doivent respecter les bonnes pratiques |

---

## 9. Architecture globale

```
┌─────────────────────────────────┐
│        Application Flutter      │
│  ┌─────────┐  ┌──────────────┐  │
│  │ Screens │  │  Providers   │  │
│  └────┬────┘  └──────┬───────┘  │
│       │              │          │
│  ┌────▼──────────────▼───────┐  │
│  │        Services (HTTP)    │  │
│  └────────────┬──────────────┘  │
└───────────────│─────────────────┘
                │ REST/JSON
┌───────────────▼─────────────────┐
│   Backend JSON Server (Render)  │
│   /annonces  /users  /messages  │
└─────────────────────────────────┘
```

---

## 10. Livrables attendus

| Livrable                  | Description                                      |
|---------------------------|--------------------------------------------------|
| Code source               | Dépôt GitHub complet (frontend + backend)        |
| APK de démonstration      | Fichier `.apk` installable sur Android           |
| URL de déploiement        | Backend accessible sur Render                    |
| Cahier des charges        | Ce document                                      |
| Dossier de conception     | Architecture, UML, modèle de données             |
| Dossier UX/UI             | Wireframes, maquettes, charte graphique          |

---

## 11. Planning prévisionnel

| Semaine | Tâche                                          |
|---------|------------------------------------------------|
| 5       | Analyse, cahier des charges, conception        |
| 6       | Développement frontend (UI, navigation)        |
| 7       | Développement backend, intégration API         |
| 8       | Tests, corrections, déploiement, documentation |

---

*Document rédigé dans le cadre du projet final – Activité n°6 – Formation Développement Mobile Avancé – DCLIC*
