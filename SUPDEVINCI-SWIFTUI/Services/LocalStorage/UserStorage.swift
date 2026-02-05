//
//  UserStorage.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 05/02/2026.
//

import Foundation

class UserStorage {
    static let shared = UserStorage()
        
    private let userDefaults = UserDefaults.standard
    private let usersKey = "users"
    
    func createUser(_ user: User) throws {
        var users = try getAllUsers()
        
        // Vérifier que l'email n'existe pas déjà
        if users.contains(where: { $0.email == user.email }) {
            throw UserStorageError.emailAlreadyExists
        }
        
        users.append(user)
        try saveUsers(users)
    }
    
    func getAllUsers() throws -> [User] {
        guard let data = userDefaults.data(forKey: usersKey) else {
            return []
        }
        
        do {
            let decoder = JSONDecoder()
            let users = try decoder.decode([User].self, from: data)
            return users
        } catch {
            throw UserStorageError.decodingError
        }
    }
    
    func getUser(withEmail email: String) throws -> User {
        let users = try getAllUsers()
        guard let user = users.first(where: { $0.email == email }) else {
            throw UserStorageError.userNotFound
        }
        
        return user
    }
    
    func getUser(withId id: String) throws -> User {
        let users = try getAllUsers()
        guard let user = users.first(where: { $0.id == id }) else {
            throw UserStorageError.userNotFound
        }
        
        return user
    }
    
    func updateUser(_ user: User) throws {
        var users = try getAllUsers()
        
        guard let index = users.firstIndex(where: { $0.id == user.id }) else {
            throw UserStorageError.userNotFound
        }
        
        users[index] = user
        try saveUsers(users)
    }
    
    func deleteUser(withId id: String) throws {
        var users = try getAllUsers()
        
        guard let index = users.firstIndex(where: { $0.id == id }) else {
            throw UserStorageError.userNotFound
        }
        
        users.remove(at: index)
        try saveUsers(users)
    }
    
    func verifyCredentials(email: String, password: String) throws -> User {
        let user = try getUser(withEmail: email)
        
        if !user.verifyPassword(password) {
            throw UserStorageError.invalidCredentials
        }
        
        return user
    }
    
    private func saveUsers(_ users: [User]) throws {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(users)
            userDefaults.set(data, forKey: usersKey)
        } catch {
            throw UserStorageError.encodingError
        }
    }
    
    func addFavoriteMovie(movieId: Int, userId: String) throws {
        var users = try getAllUsers()
        
        guard let index = users.firstIndex(where: { $0.id == userId }) else {
            throw UserStorageError.userNotFound
        }
        
        users[index].addFavoriteMovie(movieId: movieId)
        try saveUsers(users)
    }
}

enum UserStorageError: LocalizedError {
    case emailAlreadyExists
    case userNotFound
    case invalidCredentials
    case encodingError
    case decodingError
    
    var errorDescription: String? {
        switch self {
        case .emailAlreadyExists:
            return "Un compte avec cet email existe déjà"
        case .userNotFound:
            return "Utilisateur non trouvé"
        case .invalidCredentials:
            return "Email ou mot de passe incorrect"
        case .encodingError:
            return "Erreur lors de l'enregistrement"
        case .decodingError:
            return "Erreur lors de la lecture des données"
        }
    }
}
