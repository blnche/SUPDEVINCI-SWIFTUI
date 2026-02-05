//
//  FavoriteDetailView.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 05/02/2026.
//

import SwiftUI

struct FavoriteDetailView: View {
    let favorite: Favorite
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            
            AsyncImage(url: favorite.movie.posterURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Color.black
            }
            .ignoresSafeArea()
            .frame(maxWidth: UIScreen.main.bounds.width)
            
            LinearGradient(
                gradient: Gradient(colors: [.clear, .black.opacity(0.5), .black]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 12) {
                Text(favorite.movie.title)
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)
                
                Text(favorite.movie.overview)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.8))
                
                Label("\(favorite.movie.formattedRating)", systemImage: "star.fill")
                    .foregroundColor(.yellow)
                    .font(.headline)
                
            }
            .padding(30)
        }
    }
}
