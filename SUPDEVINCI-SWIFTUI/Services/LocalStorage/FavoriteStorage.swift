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
    
    func removeFavorite(withId favoriteId: Int, userId: String) throws {
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
        try saveFavorite(favorites, for: userId)
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
        
        var updatedFavorite = favorites[index]
        
        if let personalRating = personalRating {
            updatedFavorite = Favorite(
                id: updatedFavorite.id,
                userId: updatedFavorite.userId,
                movieId: updatedFavorite.movieId,
                movie: updatedFavorite.movie,
                dateAdded: updatedFavorite.dateAdded,
                personalRating: personalRating,
                notes: notes ?? updatedFavorite.notes
            )
        } else if let notes = notes {
            updatedFavorite = Favorite(
                id: updatedFavorite.id,
                userId: updatedFavorite.userId,
                movieId: updatedFavorite.movieId,
                movie: updatedFavorite.movie,
                dateAdded: updatedFavorite.dateAdded,
                personalRating: updatedFavorite.personalRating,
                notes: notes
            )
        }
        
        favorites[index] = updatedFavorite
        try saveFavorite(favorites, for: userId)
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
    
    func saveFavorite(movie: Movie, userId: String) throws {
        let key = "\(favoritesKey)_\(userId)"
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(favorites)
            userDefaults.set(data, forKey: key)
        } catch {
            throw FavoriteStorageError.encodingError
        }
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
