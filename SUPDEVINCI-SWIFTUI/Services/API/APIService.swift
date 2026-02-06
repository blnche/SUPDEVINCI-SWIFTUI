//
//  Untitled.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 05/02/2026.
//

import Foundation

class APIService {
    static let shared = APIService()
    
    private let apiKey = "2bcf0f2ea4a982b289f2bf3e3de2477f"
    private let baseUrl = "https://api.themoviedb.org/3"
    
    func fectchData<T: Codable>(endpoint: String, queryItems: [URLQueryItem] = []) async throws -> T {
        var components = URLComponents(string: endpoint)
        var defaultItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: "en-US")
        ]
        
        defaultItems.append(contentsOf: queryItems)
        components?.queryItems = defaultItems
        
        guard let url = components?.url else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw NSError(domain: "Invalid HTTP response", code: 0, userInfo: nil)
        }
                
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw error
        }
    }
    
    func fecthPopularMovies(page: Int = 1) async throws -> [Movie] {
        let endpoint = "\(baseUrl)/movie/popular"
        let queryItems = [URLQueryItem(name: "page", value: String(page))]
        
        let response: MovieResponse = try await fectchData(endpoint: endpoint, queryItems: queryItems)
        
        return response.results
    }
    
    func fetchMovie(id: Int) async throws -> Movie {
        let endpoint = "\(baseUrl)/movie/\(id)"
        print("🌐 Full URL: \(endpoint)")
        
        do {
            let movie: Movie = try await fectchData(endpoint: endpoint)
            print("✅ Successfully fetched movie: \(movie.title)")
            return movie
        } catch {
            print("❌ API Error fetching movie \(id): \(error)")
            print("❌ Error type: \(type(of: error))")
            throw error
        }
    }
}
