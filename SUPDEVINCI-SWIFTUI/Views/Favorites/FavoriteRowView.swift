//
//  FavoriteRowView.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 05/02/2026.
//
import SwiftUI

struct FavoriteRowView: View {
    let favorite: Favorite
    
    var body: some View {
        HStack(spacing: 12) {
            // Image du film
            AsyncImage(url: favorite.movie.posterURL) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 60, height: 90)
            .cornerRadius(6)
            .clipped()
            
            // Informations du film
            VStack(alignment: .leading, spacing: 6) {
                Text(favorite.movie.title)
                    .font(.headline)
                    .lineLimit(2)
                
                // Année et note TMDB
                HStack(spacing: 12) {
                    if let year = favorite.movie.releaseYear {
                        Label(year, systemImage: "calendar")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Label(
                        String(format: "%.1f", favorite.movie.voteAverage / 2),
                        systemImage: "star.fill"
                    )
                    .font(.caption)
                    .foregroundColor(.orange)
                }
                
                // Ma note personnelle si elle existe
                if let personalRating = favorite.personalRating {
                    HStack(spacing: 4) {
                        Text("Ma note:")
                            .font(.caption2)
                            .foregroundColor(.gray)
                        Text("⭐ \(String(format: "%.1f", personalRating))")
                            .font(.caption2)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                    }
                }
                
                // Date d'ajout
                Text(favorite.relativeDate)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Icône de navigation
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 4)
    }
}
