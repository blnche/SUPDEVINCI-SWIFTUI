//
//  User.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 05/02/2026.
//

import Foundation

struct User: Codable, Identifiable {
    let id: String
    var username: String
    var email: String
    var name: String
    var password: String
    var favoriteMoviesIds: [Int]
    
    init(
        id: String = UUID().uuidString,
        username: String,
        name: String,
        email: String,
        password: String,
        favoriteMovieIds: [Int] = []
    ) {
        self.id = id
        self.username = username
        self.name = name
        self.email = email
        self.password = Self.hashPassword(password)
        self.favoriteMoviesIds = favoriteMovieIds
    }
    
    func verifyPassword(_ password: String) -> Bool {
        return Self.hashPassword(password) == password
    }
    
    func isFavorite(movieId: Int) -> Bool {
        return favoriteMoviesIds.contains(movieId)
    }
    
    private static func hashPassword(_ password: String) -> String {
        // Simple hash pour le développement local
        let data = password.data(using: .utf8) ?? Data()
        let hash = data.hashValue
        return String(hash)
    }
    
    mutating func addFavoriteMovie(movieId: Int) {
        if !favoriteMoviesIds.contains(movieId) {
            favoriteMoviesIds.append(movieId)
        }
    }
    
    mutating func removeFavoriteMovie(movieId: Int) {
        favoriteMoviesIds.removeAll { $0 == movieId }
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case email
        case password
        case favoriteMoviesIds
    }
}
