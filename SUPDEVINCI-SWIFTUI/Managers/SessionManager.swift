//
//  SessionManager.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 05/02/2026.
//

import Foundation

class SessionManager: ObservableObject {
    static let shared = SessionManager()
    
    @Published var currentUser: User?
    @Published var isAuthenticated = false
    
    private let userStorage = UserStorage.shared
    
    init() {
        loadSession()
//        print(currentUser)
//        print(currentUser?.favoriteMoviesIds)
    }
    
    func login(email: String, password: String) throws {
        let user = try userStorage.verifyCredentials(email: email, password: password)
        currentUser = user
        isAuthenticated = true
        saveSession()
    }
    
    func register(name: String, username: String, email: String, password: String) throws {
        let newUser = User(username: username, name: name, email: email, password: password)
        try userStorage.createUser(newUser)
        currentUser = newUser
        isAuthenticated = true
        saveSession()
    }
    
    func logout() {
        currentUser = nil
        isAuthenticated = false
        clearSession()
    }
    
    func addFavoriteMovie(movieId: Int) throws {
        guard var user = currentUser else {
            throw SessionManagerError.notAuthenticated
        }
        
        try userStorage.addFavoriteMovie(movieId: movieId, userId: user.id)
        user.addFavoriteMovie(movieId: movieId)
        currentUser = user
        saveSession()
    }
    
    func removeFavoriteMovie(movieId: Int) throws {
        guard var user = currentUser else {
            throw SessionManagerError.notAuthenticated
        }
        
        try userStorage.removeFavoriteMovie(movieId: movieId, userId: user.id)
        user.removeFavoriteMovie(movieId: movieId)
        currentUser = user
        saveSession()
    }
    
    func isFavorite(movieId: Int) -> Bool {
//        print(currentUser?.favoriteMoviesIds)
        return currentUser?.favoriteMoviesIds.contains(movieId) ?? false
    }
    
    func updateProfile(username: String, name: String, email: String) throws {
        guard var user = currentUser else {
            throw SessionManagerError.notAuthenticated
        }
        
        user.username = username
        user.name = name
        user.email = email
        
        try userStorage.updateUser(user)
        currentUser = user
        saveSession()
    }
    
    private func saveSession() {
        guard let user = currentUser else { return }
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(user) {
            UserDefaults.standard.set(data, forKey: "currentSession")
        }
    }
    
    private func loadSession() {
        guard let data = UserDefaults.standard.data(forKey: "currentSession") else { return }
        let decoder = JSONDecoder()
        if let user = try? decoder.decode(User.self, from: data) {
            currentUser = user
            isAuthenticated = true
        }
    }
    
    private func clearSession() {
        UserDefaults.standard.removeObject(forKey: "currentSession")
    }
}

enum SessionManagerError: LocalizedError {
    case notAuthenticated
    
    var errorDescription: String? {
        return "Utilisateur non authentifié"
    }
}
