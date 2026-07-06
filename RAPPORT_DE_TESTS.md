# RAPPORT DE TESTS
## Mini Marketplace – Application Mobile Flutter

---

| Champ     | Détail                                |
|-----------|---------------------------------------|
| Auteur    | Abdoul Salam DIALLO                   |
| Formation | Développement Mobile Avancé – DCLIC   |
| Date      | Juillet 2026                          |
| Version   | 1.0.0                                 |

---

## 1. Environnement de test

| Élément | Détail |
|---|---|
| OS hôte | Windows 10 (version 10.0.26200) |
| Flutter | 3.4.0+ |
| Navigateur web | Microsoft Edge 150.0.4078.48 |
| Appareil Android | Samsung Galaxy A06 (Android 16, API 36) |
| Backend | JSON Server déployé sur Render.com |

---

## 2. Stratégie de tests

Les tests réalisés sont des **tests manuels fonctionnels** couvrant l'ensemble des parcours utilisateur de l'application. Chaque cas de test est exécuté sur deux plateformes : Web (Edge) et Android (Samsung A06).

Légende :
- ✅ Passé
- ❌ Échoué
- ⚠️ Partiel

---

## 3. Tests d'authentification

| ID | Cas de test | Plateforme | Résultat | Observations |
|---|---|---|---|---|
| T01 | Connexion avec email valide (buyer@example.com) | Web | ✅ | Redirection vers l'accueil |
| T02 | Connexion avec email valide (seller@example.com) | Web | ✅ | Bouton "Créer annonce" visible |
| T03 | Connexion avec email inexistant | Web | ✅ | Message d'erreur affiché |
| T04 | Connexion avec email sans @ | Web | ✅ | Validation formulaire bloquante |
| T05 | Connexion avec mot de passe < 4 chars | Web | ✅ | Validation formulaire bloquante |
| T06 | Connexion avec email valide | Android | ✅ | Fonctionne après réveil Render (~30s) |
| T07 | Inscription avec tous les champs remplis | Web | ✅ | Utilisateur créé, session active |
| T08 | Inscription avec email déjà utilisé | Web | ✅ | Message "email déjà utilisé" |
| T09 | Inscription avec champ vide | Web | ✅ | Validation bloquante par champ |
| T10 | Choix rôle Acheteur à l'inscription | Web | ✅ | Pas de FAB "Créer annonce" |
| T11 | Choix rôle Vendeur à l'inscription | Web | ✅ | FAB "Créer annonce" visible |
| T12 | Persistance de session après fermeture | Android | ✅ | Session restaurée au redémarrage |
| T13 | Déconnexion | Web | ✅ | Retour à l'écran de connexion |

---

## 4. Tests des annonces

| ID | Cas de test | Plateforme | Résultat | Observations |
|---|---|---|---|---|
| T14 | Chargement de la liste des annonces | Web | ✅ | Grille 2 colonnes affichée |
| T15 | Affichage image distante (Unsplash) | Web | ✅ | Image chargée via renderer HTML |
| T16 | Affichage image base64 | Web | ✅ | Image décodée et affichée |
| T17 | Image avec URL invalide | Web | ✅ | Placeholder icône affiché |
| T18 | Filtrage par catégorie "Electronique" | Web | ✅ | Seules les annonces c1 affichées |
| T19 | Recherche par mot-clé "iPhone" | Web | ✅ | Résultats filtrés en temps réel |
| T20 | Recherche vide (reset) | Web | ✅ | Toutes les annonces affichées |
| T21 | Affichage détail d'une annonce | Web | ✅ | Image, titre, prix, description |
| T22 | Badge "Vendue" sur annonce sold | Web | ✅ | Badge rouge visible |
| T23 | Création d'annonce (vendeur) | Web | ✅ | Annonce apparaît en tête de liste |
| T24 | Création sans image (URL par défaut) | Web | ✅ | Image Unsplash par défaut |
| T25 | Création avec image galerie | Android | ✅ | Image encodée base64, affichée |
| T26 | Création avec image galerie | Web | ✅ | FileUploadInputElement, affichée |
| T27 | Création avec champ prix non numérique | Web | ✅ | Validation bloquante |
| T28 | Modification d'une annonce (propriétaire) | Web | ✅ | Données mises à jour |
| T29 | Bouton édition visible uniquement propriétaire | Web | ✅ | Invisible pour acheteur |
| T30 | Bouton "Contacter le vendeur" visible acheteur | Web | ✅ | Visible sur annonce active |
| T31 | Bouton "Contacter" absent si propriétaire | Web | ✅ | Caché pour le vendeur |

---

## 5. Tests de messagerie

| ID | Cas de test | Plateforme | Résultat | Observations |
|---|---|---|---|---|
| T32 | Contacter un vendeur depuis une annonce | Web | ✅ | Dialog ouverte avec message pré-rempli |
| T33 | Envoi message depuis dialog | Web | ✅ | Message créé, redirection onglet Messages |
| T34 | Conversation créée côté acheteur | Web | ✅ | Visible dans liste conversations |
| T35 | Conversation créée côté vendeur | Web | ✅ | Badge non-lu visible |
| T36 | Affichage conversation avec messages | Web | ✅ | Bulles différenciées envoyé/reçu |
| T37 | Envoi d'un message dans le chat | Web | ✅ | Message ajouté en temps réel |
| T38 | Affichage heure du message | Web | ✅ | Format HH:MM |
| T39 | Compteur non-lus sur onglet Messages | Web | ✅ | Badge orange affiché |
| T40 | Refresh conversations | Web | ✅ | Bouton refresh fonctionnel |

---

## 6. Tests de navigation

| ID | Cas de test | Plateforme | Résultat | Observations |
|---|---|---|---|---|
| T41 | Navigation entre les 4 onglets | Web | ✅ | Transitions fluides |
| T42 | Navigation entre les 4 onglets | Android | ✅ | Fonctionne correctement |
| T43 | Retour arrière depuis détail annonce | Web | ✅ | Retour à la liste |
| T44 | Redirection automatique vers Messages | Web | ✅ | jumpToTab(2) fonctionnel |
| T45 | Splash screen → Onboarding (non connecté) | Web | ✅ | Animation 2s puis redirection |
| T46 | Splash screen → Accueil (connecté) | Android | ✅ | Session restaurée |

---

## 7. Tests de profil

| ID | Cas de test | Plateforme | Résultat | Observations |
|---|---|---|---|---|
| T47 | Affichage nom, email, rôle | Web | ✅ | Données correctement affichées |
| T48 | Affichage annonces publiées (vendeur) | Web | ✅ | Grille des annonces personnelles |
| T49 | Section annonces absente (acheteur) | Web | ✅ | Section masquée |
| T50 | Déconnexion depuis profil | Web | ✅ | Session effacée, retour login |

---

## 8. Tests de robustesse réseau

| ID | Cas de test | Plateforme | Résultat | Observations |
|---|---|---|---|---|
| T51 | Backend inaccessible au démarrage | Web | ✅ | Message "Backend inaccessible" + bouton Réessayer |
| T52 | Backend en cold start (Render gratuit) | Android | ✅ | Réussit après ~45s (timeout 60s) |
| T53 | Requête avec timeout > 60s | Android | ❌ | TimeoutException affichée |
| T54 | Reconnexion après erreur réseau | Web | ✅ | Bouton Réessayer fonctionnel |

---

## 9. Récapitulatif

| Catégorie | Total | Passés | Échoués | Partiels |
|---|---|---|---|---|
| Authentification | 13 | 13 | 0 | 0 |
| Annonces | 18 | 18 | 0 | 0 |
| Messagerie | 9 | 9 | 0 | 0 |
| Navigation | 6 | 6 | 0 | 0 |
| Profil | 4 | 4 | 0 | 0 |
| Robustesse réseau | 4 | 3 | 1 | 0 |
| **Total** | **54** | **53** | **1** | **0** |

**Taux de réussite : 98,1%**

---

## 10. Anomalie identifiée

| ID | Description | Gravité | Statut |
|---|---|---|---|
| BUG-01 | TimeoutException si Render met > 60s à démarrer | Faible | Connu – lié au plan gratuit Render |

**Contournement BUG-01** : Augmenter le timeout ou relancer la requête. Le problème disparaît après le premier réveil du service.

---

*Rapport de tests – Mini Marketplace v1.0.0 – DCLIC – Juillet 2026*
