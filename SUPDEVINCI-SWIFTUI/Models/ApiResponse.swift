//
//  ApiResponse.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 05/02/2026.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
    let page: Int?
    let totalPages: Int?
    let totalResults: Int?
}
