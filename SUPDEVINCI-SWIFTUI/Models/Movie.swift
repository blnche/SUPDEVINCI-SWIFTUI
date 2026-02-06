//
//  Movie.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 05/02/2026.
//

import Foundation

struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let overview: String
    let poster_path: String?
    let backdrop_path: String?
    let vote_average: Double
    let vote_count: Int
    let release_date: String?
    let original_language: String?
    let popularity: Double?
    let adult: Bool?
    let genre_ids: [Int]
    
    
    var posterURL: URL? {
        guard let path = poster_path else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
        
    var backdropURL: URL? {
        guard let path = backdrop_path else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/original\(path)")
    }
    
    var formattedRating: String {
        String(format: "%.1f", vote_average)
    }
}
