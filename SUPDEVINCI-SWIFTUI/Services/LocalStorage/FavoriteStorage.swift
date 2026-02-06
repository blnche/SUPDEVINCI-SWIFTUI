//
//  FavoriteStorage.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 05/02/2026.
//

import Foundation

class FavoriteStorage {
    static let shared = FavoriteStorage()
    
    private let userDefaults = UserDefaults.standard
    private let favoritesKey = "favorites"
    
    func addFavorite(_ favorite: Favorite) throws {
        var favorites = try getFavorites(for: favorite.userId)
        
        // Vérifier que le film n'est pas déjà en favori
        if favorites.contains(where: { $0.movieId == favorite.movieId }) {
            throw FavoriteStorageError.alreadyExists
        }
        
        favorites.append(favorite)
        try saveFavorites(favorites, for: favorite.userId)
    }
    
    func getFavorites(for userId: String) throws -> [Favorite] {
        let key = "\(favoritesKey)_\(userId)"
        
        guard let data = userDefaults.data(forKey: key) else {
            return []
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Favorite].self, from: data)
            return favorites
        } catch {
            throw FavoriteStorageError.decodingError
        }
    }
    
    func removeFavorite(withId favoriteId: String, userId: String) throws {
        var favorites = try getFavorites(for: userId)
        guard let index = favorites.firstIndex(where: { $0.id == favoriteId }) else {
            throw FavoriteStorageError.notFound
        }
        favorites.remove(at: index)
        try saveFavorites(favorites, for: userId)
    }
    
    func removeFavoriteByMovieId(_ movieId: Int, userId: String) throws {
        var favorites = try getFavorites(for: userId)
        
        guard let index = favorites.firstIndex(where: { $0.movieId == movieId }) else {
            throw FavoriteStorageError.notFound
        }
        
        favorites.remove(at: index)
        try saveFavorites(favorites, for: userId)
    }
    
    func updateFavorite(
        withId favoriteId: String,
        personalRating: Double? = nil,
        notes: String? = nil,
        userId: String
    ) throws {
        var favorites = try getFavorites(for: userId)
        
        guard let index = favorites.firstIndex(where: { $0.id == favoriteId }) else {
            throw FavoriteStorageError.notFound
        }
        
        let existing = favorites[index]
        
        let updatedFavorite = Favorite(
            id: existing.id,
            userId: existing.userId,
            movieId: existing.movieId,
            movie: existing.movie,
            dateAdded: existing.dateAdded,
            personalRating: personalRating ?? existing.personalRating,
            notes: notes ?? existing.notes
        )
        
        favorites[index] = updatedFavorite
        
        try saveFavorites(favorites, for: userId)
    }
    
    func isFavorited(movieId: Int, userId: String) throws -> Bool {
        let favorites = try getFavorites(for: userId)
        return favorites.contains(where: { $0.movieId == movieId })
    }
    
    func getFavorite(byMovieId movieId: Int, userId: String) throws -> Favorite? {
        let favorites = try getFavorites(for: userId)
        return favorites.first(where: { $0.movieId == movieId })
    }
    
    func deleteAllFavorites(for userId: String) throws {
        let key = "\(favoritesKey)_\(userId)"
        userDefaults.removeObject(forKey: key)
    }
    
    private func saveFavorites(_ favorites: [Favorite], for userId: String) throws {
        let key = "\(favoritesKey)_\(userId)"
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(favorites)
            userDefaults.set(data, forKey: key)
        } catch {
            throw FavoriteStorageError.encodingError
        }
    }
    
    func saveFavorite(movie: Movie, userId: String) throws {
        let newFavorite = Favorite(userId: userId, movieId: movie.id, movie: movie)
        try addFavorite(newFavorite)
    }
}

enum FavoriteStorageError: LocalizedError {
    case notFound
    case alreadyExists
    case encodingError
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .notFound:
            return "Le favori n'a pas été trouvé"
        case .alreadyExists:
            return "Ce film est déjà dans vos favoris"
        case .encodingError:
            return "Erreur lors de l'enregistrement"
        case .decodingError:
            return "Erreur lors de la lecture des données"
        }
    }
}
