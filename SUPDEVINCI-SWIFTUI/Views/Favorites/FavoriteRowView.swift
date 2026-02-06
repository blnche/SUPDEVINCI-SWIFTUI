////
////  FavoriteRowView.swift
////  SUPDEVINCI-SWIFTUI
////
////  Created by Blanche Peltier on 05/02/2026.
////

import SwiftUI

struct FavoriteRowView: View {
    let favorite: Favorite
    @State private var isFavorite: Bool = true
    @State private var showDrawer = false
    
    var body: some View {
        Card{
            HStack(spacing: 0) {
                AsyncImage(url: favorite.movie.posterURL) { image in
                    image.resizable().aspectRatio(contentMode: .fill)
                } placeholder: { Color.gray.opacity(0.2) }
                    .frame(width: 80, height: 110)
                    .clipped()
                    .cornerRadius(8)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(favorite.movie.title)
                        .font(.system(.headline, design: .rounded))
                        .lineLimit(1)
                    Spacer()
                    
                }
                
                Text(favorite.movie.overview)
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                
                Spacer()
                
                Button { isFavorite.toggle() } label: {
                    Spacer()
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .red : .gray)
                }
            }
        }
        .onTapGesture {
            showDrawer.toggle()
        }
        .sheet(isPresented: $showDrawer) {
            VStack {
                FavoriteDetailView(favorite: favorite)
            }
        }
    }
}
