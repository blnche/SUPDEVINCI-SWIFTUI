MovieStream – Application iOS de Streaming

🎬 Description
MovieStream est une application mobile développée en Swift et SwiftUI permettant aux utilisateurs de découvrir des films via une API publique, de gérer leur profil et d'organiser leurs films favoris. L'application suit une architecture MVVM stricte pour garantir une séparation claire des responsabilités et une maintenance facilitée.

🚀 Fonctionnalités
Authentification & Profil

Gestion de compte : Création de compte, connexion et déconnexion sécurisées.

Session active : Persistance de la session utilisateur.

Profil : Consultation et modification des informations personnelles (nom, email).

Catalogue & Favoris

Exploration : Affichage d'une liste de films récupérés en temps réel via une API externe.

Détails : Consultation des fiches détaillées (titre, image, description et note).

Favoris : Ajout/retrait de films dans une liste personnalisée, propre à chaque utilisateur et persistante entre les sessions.

🛠 Architecture & Technique
Langage : Swift 

Framework UI : SwiftUI (sans Storyboard) 

Patron d'architecture : MVVM (Model-View-ViewModel) 

Navigation : Utilisation de NavigationStack et TabView 

Persistance : Stockage local des données utilisateurs et des favoris 

API utilisée : TMDB

📂 Structure du Projet
Le code est organisé selon les standards de l'industrie:

Models : User, Movie, Favorite 

Views : LoginView, MovieListView, MovieDetailView, FavoritesView, ProfileView, etc. 

ViewModels : Logique métier séparée pour l'authentification, les films et le profil 

Services : Modules dédiés aux appels API et à la persistance locale 

📖 Installation
Clonez le dépôt.

1 - Ouvrez le fichier .xcodeproj dans Xcode.

2 - Assurez-vous d'avoir une connexion internet pour la récupération des films.

3 - Compilez et lancez l'application sur un simulateur iOS ou un appareil physique.
