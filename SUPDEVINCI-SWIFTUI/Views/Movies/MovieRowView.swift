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
    @State private var showDrawer = false

    
    var body: some View {
        Card{
            HStack(spacing: 0) {
                
                AsyncImage(url: movie.posterURL) { image in
                    image.resizable().aspectRatio(contentMode: .fill)
                } placeholder: { Color.gray.opacity(0.2) }
                .frame(width: 80, height: 110)
                .clipped()
                .cornerRadius(8)

                DashedLine()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                    .frame(width: 1)
                    .foregroundColor(.gray.opacity(0.4))
                    .padding(.vertical, 5)
                    .padding(.horizontal, 15)

                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(movie.title)
                            .font(.system(.headline, design: .rounded))
                            .lineLimit(1)
                        Spacer()
                        
                    }
                    
                    Text(movie.overview)
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
        }
        .onTapGesture {
            showDrawer.toggle()
        }
        .sheet(isPresented: $showDrawer) {
            VStack {
                MovieDetailView(movie: movie)
            }
        }
    }
}


struct DashedLine: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 0, y: rect.height))
        return path
    }
}
