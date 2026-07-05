# Backend — Mini Marketplace (JSON Server)

Tourne sur **http://localhost:3001**

## Démarrage

```bash
cd app-mobile/backend
npm install
npm run dev
```

## Endpoints disponibles

| Méthode | Endpoint | Description |
|---------|----------|-------------|
| GET | /annonces | Liste toutes les annonces |
| GET | /annonces?categorie=c1 | Filtrer par catégorie |
| GET | /annonces?titre_like=iPhone | Recherche par titre |
| GET | /annonces/:id | Détail d'une annonce |
| POST | /annonces | Créer une annonce |
| PUT | /annonces/:id | Modifier une annonce |
| DELETE | /annonces/:id | Supprimer une annonce |
| GET | /users | Liste utilisateurs |
| GET | /users?email=x@y.com | Chercher par email |
| POST | /users | Créer un utilisateur |
| GET | /messages?annonceId=a1 | Messages d'une annonce |
| POST | /messages | Envoyer un message |
| GET | /conversations?userId=u1 | Conversations d'un utilisateur |
| GET | /products | Alias produits (collection secondaire) |

## Collections db.json

- **users** : id, firstName, lastName, email, phone, role, avatar
- **products** : id, titre, description, prix, etat, image, categorie, localisation, vendeurId, statut
- **annonces** : id, titre, description, prix, image, categorie, localisation, vendeurId, condition, status, createdAt
- **messages** : id, annonceId, fromId, toId, content, read, createdAt
- **conversations** : id, userId, otherUserId, otherUserName, annonceId, annonceTitle, lastMessage, unreadCount, updatedAt
