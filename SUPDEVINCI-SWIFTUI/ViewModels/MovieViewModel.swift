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
}
