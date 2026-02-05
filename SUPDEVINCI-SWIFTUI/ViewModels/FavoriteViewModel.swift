////
////  FavoriteViewModel.swift
////  SUPDEVINCI-SWIFTUI
////
////  Created by Blanche Peltier on 05/02/2026.
////
//
//import Foundation
//
//class FavoriteViewModel: ObservableObject {
//    @Published var favorites: [Favorite] = []
//    @Published var isLoading = false
//    @Published var errorMessage: String?
//    
//    private let favoriteStorage = FavoriteStorage.shared
//    private let sessionManager = SessionManager.shared
//    
//    func loadFavorites() {
//        guard let userId = sessionManager.currentUser?.id else {
//            errorMessage = "Utilisateur non connecté"
//            return
//        }
//        
//        Task {
//            isLoading = true
//            errorMessage = nil
//            
//            do {
//                favorites = try favoriteStorage.getFavorites(for: userId)
//            } catch {
//                errorMessage = "Erreur lors du chargement des favoris"
//            }
//            
//            isLoading = false
//        }
//    }
//    
//    func addToFavorites(for movie: Movie, personalRating: Double? = nil,
//                        notes: String? = nil) {
//        guard let userId = sessionManager.currentUser?.id else {
//            errorMessage = "Utilisateur non connecté"
//            return
//        }
//        
//        Task {
//            do {
//                let favorite = Favorite(
//                    userId: userId,
//                    movieId: movie.id,
//                    movie: movie,
//                    personalRating: personalRating,
//                    notes: notes
//                )
//                
//                try favoriteStorage.addFavorite(favorite)
//                
//                // Ajouter à la liste locale
//                await MainActor.run {
//                    favorites.append(favorite)
//                }
//                
//            } catch {
//                await MainActor.run {
//                    errorMessage = "Erreur lors de l'ajout aux favoris"
//                }
//            }
//        }
//    }
//    
//    func removeFromFavorites(favoriteId: String) {
//        guard let userId = sessionManager.currentUser?.id else {
//            errorMessage = "Utilisateur non connecté"
//            return
//        }
//        
//        Task {
//            do {
//                try favoriteStorage.removeFavorite(withId: favoriteId, userId: userId)
//                
//                // Retirer de la liste locale
//                await MainActor.run {
//                    favorites.removeAll { $0.id == favoriteId }
//                }
//                
//            } catch {
//                await MainActor.run {
//                    errorMessage = "Erreur lors de la suppression du favori"
//                }
//            }
//        }
//    }
//    
//    func getSortedFavorites(by sortOption: SortOption) -> [Favorite] {
//        switch sortOption {
//        case .dateAdded:
//            return favorites.sorted { $0.dateAdded > $1.dateAdded }
//        case .dateAddedOldest:
//            return favorites.sorted { $0.dateAdded < $1.dateAdded }
//        case .rating:
//            return favorites.sorted { ($0.personalRating ?? 0) > ($1.personalRating ?? 0) }
//        case .movieTitle:
//            return favorites.sorted { $0.movie.title < $1.movie.title }
//        }
//    }
//    
//    enum SortOption {
//        case dateAdded
//        case dateAddedOldest
//        case rating
//        case movieTitle
//    }
//    
//    func updateFavoriteNotes(
//        favoriteId: String,
//        personalRating: Double? = nil,
//        notes: String? = nil
//    ) {
//        guard let userId = sessionManager.currentUser?.id else {
//            errorMessage = "Utilisateur non connecté"
//            return
//        }
//        
//        Task {
//            do {
//                try favoriteStorage.updateFavorite(
//                    withId: favoriteId,
//                    personalRating: personalRating,
//                    notes: notes,
//                    userId: userId
//                )
//                
//                // Mettre à jour la liste locale
//                await MainActor.run {
//                    if let index = favorites.firstIndex(where: { $0.id == favoriteId }) {
//                        favorites[index] = Favorite(
//                            id: favoriteId,
//                            userId: userId,
//                            movieId: favorites[index].movieId,
//                            movie: favorites[index].movie,
//                            dateAdded: favorites[index].dateAdded,
//                            personalRating: personalRating,
//                            notes: notes
//                        )
//                    }
//                }
//                
//            } catch {
//                await MainActor.run {
//                    errorMessage = "Erreur lors de la mise à jour du favori"
//                }
//            }
//        }
//    }
//}
