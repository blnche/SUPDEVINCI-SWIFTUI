//
//  FavoriteViewModel.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 05/02/2026.
//

import Foundation

@MainActor
class FavoriteViewModel: ObservableObject {
    @Published var favorites: [Favorite] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let favoriteStorage = FavoriteStorage.shared
    private let sessionManager = SessionManager.shared
    
    func loadFavorites() {
        print("🔍 Starting loadFavorites")
        print("🔍 User ID: \(sessionManager.currentUser?.id ?? "nil")")
        print("🔍 Favorite IDs: \(sessionManager.currentUser?.favoriteMoviesIds ?? [])")
        
        guard let userId = sessionManager.currentUser?.id,
              let favoriteMovieIds = sessionManager.currentUser?.favoriteMoviesIds else {
            print("❌ No user or favorite IDs")
            errorMessage = "Utilisateur non connecté"
            return
        }
        
        // If no favorites, don't even start loading
        guard !favoriteMovieIds.isEmpty else {
            print("⚠️ No favorite movies to load")
            return
        }
        
        Task {
            isLoading = true
            errorMessage = nil
            favorites = []
            print("⏳ Loading started")
            
            do {
                let movies = try await withThrowingTaskGroup(of: Movie.self) { group in
                    for movieId in favoriteMovieIds {
                        group.addTask {
                            try await self.fetchMovieDetails(movieId: movieId)
                        }
                    }
                    
                    var fetchedMovies: [Movie] = []
                    for try await movie in group {
                        fetchedMovies.append(movie)
                    }
                    return fetchedMovies
                }
                
                favorites = movies.map { movie in
                    Favorite(
                        userId: userId,
                        movieId: movie.id,
                        movie: movie,
                        personalRating: nil,
                        notes: nil
                    )
                }
                
                print("✅ Loaded \(favorites.count) favorites")
                
            } catch {
                errorMessage = "Erreur lors du chargement des favoris: \(error.localizedDescription)"
                print("❌ Error: \(error)")
            }
            
            isLoading = false
            print("✅ Loading finished")
        }
    }

    private func fetchMovieDetails(movieId: Int) async throws -> Movie {
        print("📡 Starting fetch for movie \(movieId)")
        let movie = try await APIService.shared.fetchMovie(id: movieId)
        print("✅ Completed fetch for movie \(movieId): \(movie.title)")
        return movie
    }
    
    func loadFavoritesOld() {
        guard let userId = sessionManager.currentUser?.id else {
            errorMessage = "Utilisateur non connecté"
            return
        }
        
        Task {
            isLoading = true
            errorMessage = nil
            
            do {
                favorites = try favoriteStorage.getFavorites(for: userId)
            } catch {
                errorMessage = "Erreur lors du chargement des favoris"
            }
            
            isLoading = false
        }
    }
    
    func addToFavorites(for movie: Movie, personalRating: Double? = nil,
                        notes: String? = nil) {
        guard let userId = sessionManager.currentUser?.id else {
            errorMessage = "Utilisateur non connecté"
            return
        }
        
        Task {
            do {
                let favorite = Favorite(
                    userId: userId,
                    movieId: movie.id,
                    movie: movie,
                    personalRating: personalRating,
                    notes: notes
                )
                
                try favoriteStorage.addFavorite(favorite)
                
                // Ajouter à la liste locale
                await MainActor.run {
                    favorites.append(favorite)
                }
                
            } catch {
                await MainActor.run {
                    errorMessage = "Erreur lors de l'ajout aux favoris"
                }
            }
        }
    }
    
    func removeFromFavorites(favoriteId: String) {
        guard let userId = sessionManager.currentUser?.id else {
            errorMessage = "Utilisateur non connecté"
            return
        }
        
        Task {
            do {
                try favoriteStorage.removeFavorite(withId: favoriteId, userId: userId)
                
                // Retirer de la liste locale
                await MainActor.run {
                    favorites.removeAll { $0.id == favoriteId }
                }
                
            } catch {
                await MainActor.run {
                    errorMessage = "Erreur lors de la suppression du favori"
                }
            }
        }
    }
    
    func getSortedFavorites(by sortOption: SortOption) -> [Favorite] {
        switch sortOption {
        case .dateAdded:
            return favorites.sorted { $0.dateAdded > $1.dateAdded }
        case .dateAddedOldest:
            return favorites.sorted { $0.dateAdded < $1.dateAdded }
        case .rating:
            return favorites.sorted { ($0.personalRating ?? 0) > ($1.personalRating ?? 0) }
        case .movieTitle:
            return favorites.sorted { $0.movie.title < $1.movie.title }
        }
    }
    
    enum SortOption {
        case dateAdded
        case dateAddedOldest
        case rating
        case movieTitle
    }
    
    func updateFavoriteNotes(
        favoriteId: String,
        personalRating: Double? = nil,
        notes: String? = nil
    ) {
        guard let userId = sessionManager.currentUser?.id else {
            errorMessage = "Utilisateur non connecté"
            return
        }
        
        Task {
            do {
                try favoriteStorage.updateFavorite(
                    withId: favoriteId,
                    personalRating: personalRating,
                    notes: notes,
                    userId: userId
                )
                
                // Mettre à jour la liste locale
                await MainActor.run {
                    if let index = favorites.firstIndex(where: { $0.id == favoriteId }) {
                        favorites[index] = Favorite(
                            id: favoriteId,
                            userId: userId,
                            movieId: favorites[index].movieId,
                            movie: favorites[index].movie,
                            dateAdded: favorites[index].dateAdded,
                            personalRating: personalRating,
                            notes: notes
                        )
                    }
                }
                
            } catch {
                await MainActor.run {
                    errorMessage = "Erreur lors de la mise à jour du favori"
                }
            }
        }
    }
}
