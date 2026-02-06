//
//  Favorite.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 05/02/2026.
//

import Foundation

struct Favorite: Codable, Identifiable {
    let id: String
    let userId: String
    let movieId: Int
    let movie: Movie
    let dateAdded: Date
    let personalRating: Double?
    let notes: String?
    
    init(id: String = UUID().uuidString,
         userId: String,
         movieId: Int,
         movie: Movie,
         dateAdded: Date = Date(),
         personalRating: Double? = nil,
         notes: String? = nil) {
        self.id = id
        self.userId = userId
        self.movieId = movieId
        self.movie = movie
        self.dateAdded = dateAdded
        self.personalRating = personalRating
        self.notes = notes
    }
    
    var formattedDateAdded: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "fr_FR")
        return formatter.string(from: dateAdded)
    }
    
    var hasPersonalRating: Bool {
        personalRating != nil
    }
    
    var hasNotes: Bool {
        notes != nil
    }
}   

