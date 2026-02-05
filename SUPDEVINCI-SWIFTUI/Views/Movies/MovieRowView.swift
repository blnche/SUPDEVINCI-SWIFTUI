//
//  MovieRowView.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 05/02/2026.
//

import SwiftUI

struct MovieRowView: View {
    let movie: Movie
    @State private var isFavorite: Bool = false
    
    var body: some View {
        Card{
            HStack {
                Text("\(movie.title)")
                    .font(.headline)
                Spacer()
                Button {
                    isFavorite.toggle()
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .yellow : .gray)
                        .font(.title3) // Makes the icon slightly bigger/bolder
                }
            }
                .frame(maxWidth: .infinity)
                .padding(.bottom)
            Text("\(movie.overview)")
                .font(.caption)
        }
    }
}
