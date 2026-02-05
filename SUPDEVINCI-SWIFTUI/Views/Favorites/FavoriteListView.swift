//
//  FavoriteListView.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 05/02/2026.
//

import SwiftUI

struct FavoriteListView {
    @StateObject private var viewModel = FavoriteViewModel()
    @State private var sortOption = FavoriteViewModel.SortOption.dateAdded
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading {
                    LoadingView()
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
                    List {
                        ForEach(viewModel.getSortedFavorites(by: sortOption)) { favorite in
                            NavigationLink(destination: FavoritesDetailView(favorite: favorite)) {
                                FavoriteRowView(favorite: favorite)
                            }
                        }
                        .onDelete(perform: deleteFavorite)
                    }
                }
            }
            .navigationTitle("Mes favoris (\(viewModel.favoriteCount))")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Trier par", selection: $sortOption) {
                            Text("Plus récents").tag(FavoriteViewModel.SortOption.dateAdded)
                            Text("Plus anciens").tag(FavoriteViewModel.SortOption.dateAddedOldest)
                            Text("Ma note").tag(FavoriteViewModel.SortOption.rating)
                            Text("Titre").tag(FavoriteViewModel.SortOption.movieTitle)
                        }
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
            }
            .onAppear {
                viewModel.loadFavorites()
            }
            .alert("Erreur", isPresented: .constant(viewModel.errorMessage != nil)) {
                Button("OK") {
                    viewModel.errorMessage = nil
                }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
        }
    }
    
    private func deleteFavorite(at offsets: IndexSet) {
        let sortedFavorites = viewModel.getSortedFavorites(by: sortOption)
        offsets.forEach { index in
            let favorite = sortedFavorites[index]
            viewModel.removeFromFavorites(favoriteId: favorite.id)
        }
    }
    
}
