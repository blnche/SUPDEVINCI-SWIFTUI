//
//  MovieViewModel.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 05/02/2026.
//

import Foundation

@MainActor
class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var favoriteMovieIds: Set<Int> = []
    
    private let favoriteStorage = FavoriteStorage.shared
    private let sessionManager = SessionManager.shared
    private let apiService = APIService.shared
    
    func loadPopularMovies() {
        if let userFavorites = sessionManager.currentUser?.favoriteMoviesIds {
            self.favoriteMovieIds = Set(userFavorites)
        }
        
        Task {
            isLoading = true
            errorMessage = nil
            
            do {
                movies = try await apiService.fecthPopularMovies()
            } catch {
                errorMessage = error.localizedDescription
            }
            
            isLoading = false
        }
    }
    
    func toggleFavorite(movie: Movie) {
        guard sessionManager.isAuthenticated, let userId = sessionManager.currentUser?.id else {
            errorMessage = "Connectez-vous pour ajouter aux favoris"
            return
        }
        
        do {
            if isFavorited(movieId: movie.id) {
                // 1. Retirer de la session (UserStorage interne)
                try sessionManager.removeFavoriteMovie(movieId: movie.id)
                // 2. Retirer l'objet Movie complet du stockage dédié
                favoriteStorage.removeFavorite(withId: movie.id, userId: userId)
                // 3. Update UI
                favoriteMovieIds.remove(movie.id)
            } else {
                // 1. Ajouter à la session (UserStorage interne)
                try sessionManager.addFavoriteMovie(movieId: movie.id)
                // 2. Sauvegarder l'objet Movie complet
                favoriteStorage.saveFavorite(movie: movie, userId: userId)
                // 3. Update UI
                favoriteMovieIds.insert(movie.id)
            }
        } catch {
            errorMessage = error.localizedDescription
            print("❌ Erreur: \(error.localizedDescription)")
        }
    }
    
    func isFavorited(movieId: Int) -> Bool {
        return favoriteMovieIds.contains(movieId)
    }
}
