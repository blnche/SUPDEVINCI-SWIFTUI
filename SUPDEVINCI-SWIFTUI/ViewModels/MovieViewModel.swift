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
    private var sessionManager = SessionManager.shared
    private var favoriteStorage = FavoriteStorage.shared
    
    private let apiService = APIService.shared
    
    func loadPopularMovies() {
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
        print("Trying to toglle....")
        guard sessionManager.isAuthenticated, var userId = sessionManager.currentUser?.id else {
            return
        }
        
        do {
            if sessionManager.isFavorite(movieId: movie.id) {
                print("remove")
                try sessionManager.removeFavoriteMovie(movieId: movie.id)
            } else {
                print("add")
                try sessionManager.addFavoriteMovie(movieId: movie.id)
            }
            
        } catch {
            errorMessage = error.localizedDescription
            print("Erreur: \(error.localizedDescription)")
        }
    }
    
    func isFavorited(movieId: Int) -> Bool{
        return sessionManager.currentUser?.favoriteMoviesIds.filter({$0 == movieId}).count ?? 0 > 0
    }
}
