////
////  FavoriteListView.swift
////  SUPDEVINCI-SWIFTUI
////
////  Created by Blanche Peltier on 05/02/2026.
////

import SwiftUI

struct FavoriteListView {
    @StateObject private var viewModel = FavoriteViewModel()
    
    var body: some View {
        VStack {
            if viewModel.isLoading {
                LoadingView()
            } else if let errorMessage = viewModel.errorMessage {
                ErrorView(message: errorMessage)
            } else if viewModel.favorites.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "heart.slash")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                    Text("Aucun favori")
                        .font(.headline)
                    Text("Ajoutez des films à vos favoris pour les retrouver ici")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            } else {
                Text("Favorites Movies")
                    .font(.system(size: 34, weight: .heavy, design: .serif))
                    .multilineTextAlignment(.leading)
                ScrollView {
                    VStack (spacing: 20) {
                        ForEach(viewModel.favorites, id: \.id ) { favorite in
                            FavoriteRowView(favorite: favorite)
                        }
                    }
                    .padding(15)
                }
            }
        }
        .padding()
        .onAppear {
            viewModel.loadFavorites()
        }
    }
}
