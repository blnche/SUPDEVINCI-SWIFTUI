//
//  FavoriteDetailView.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 05/02/2026.
//

import SwiftUI

struct FavoritesDetailView: View {
    let favorite: Favorite
    @StateObject private var favoriteViewModel = FavoriteViewModel()
    @State private var isEditingNotes = false
    @State private var editedNotes = ""
    @State private var editedRating: Double = 3.0
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Image du film en grand
                AsyncImage(url: favorite.movie.backdropPath ?? favorite.movie.posterURL) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(height: 200)
                .cornerRadius(12)
                .clipped()
                
                VStack(alignment: .leading, spacing: 12) {
                    // Titre
                    Text(favorite.movie.title)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    // Informations du film
                    HStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Sortie")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(favorite.movie.formattedReleaseDate ?? "N/A")
                                .font(.subheadline)
                        }
                        
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Note TMDB")
                                .font(.caption)
                                .foregroundColor(.gray)
                            HStack(spacing: 4) {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.orange)
                                Text(String(format: "%.1f", favorite.movie.voteAverage / 2))
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 12)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }
                .padding(.horizontal)
                
                // Section Ma note personnelle
                Card(style: .tinted) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Ma note personnelle")
                            .font(.headline)
                        
                        HStack(spacing: 12) {
                            ForEach(1...5, id: \.self) { rating in
                                Button(action: {
                                    editedRating = Double(rating)
                                }) {
                                    Image(systemName: rating <= Int(editedRating) ? "star.fill" : "star")
                                        .font(.title3)
                                        .foregroundColor(.orange)
                                }
                            }
                            
                            Spacer()
                            
                            if editedRating > 0 {
                                Text(String(format: "%.1f", editedRating))
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                // Section Notes
                Card(style: .default) {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Mes notes")
                                .font(.headline)
                            Spacer()
                            Button(action: { isEditingNotes.toggle() }) {
                                Image(systemName: isEditingNotes ? "checkmark.circle.fill" : "pencil")
                                    .foregroundColor(.blue)
                            }
                        }
                        
                        if isEditingNotes {
                            TextEditor(text: $editedNotes)
                                .frame(height: 100)
                                .padding(8)
                                .background(Color.gray.opacity(0.1))
                                .cornerRadius(6)
                        } else {
                            if editedNotes.isEmpty {
                                Text("Aucune note")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                    .italic()
                            } else {
                                Text(editedNotes)
                                    .font(.body)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                // Description du film
                Card(style: .default) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Synopsis")
                            .font(.headline)
                        
                        Text(favorite.movie.overview)
                            .font(.body)
                            .lineHeight(1.5)
                    }
                }
                .padding(.horizontal)
                
                // Informations d'ajout
                VStack(alignment: .leading, spacing: 8) {
                    Divider()
                    
                    HStack {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            .font(.caption)
                        
                        Text("Ajouté aux favoris")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        Spacer()
                        
                        Text(favorite.formattedDateAdded)
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                    .padding(.horizontal)
                }
                
                // Boutons d'action
                VStack(spacing: 12) {
                    if isEditingNotes {
                        CustomButton(
                            title: "Enregistrer les modifications",
                            action: saveChanges,
                            style: .primary
                        )
                    }
                    
                    CustomButton(
                        title: "Retirer des favoris",
                        action: removeFavorite,
                        style: .danger
                    )
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .navigationTitle("Détail du favori")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            editedNotes = favorite.notes ?? ""
            editedRating = favorite.personalRating ?? 3.0
        }
    }
    
    private func saveChanges() {
        favoriteViewModel.updateFavoriteNotes(
            favoriteId: favorite.id,
            personalRating: editedRating,
            notes: editedNotes.isEmpty ? nil : editedNotes
        )
        isEditingNotes = false
    }
    
    private func removeFavorite() {
        favoriteViewModel.removeFromFavorites(favoriteId: favorite.id)
        dismiss()
    }
}
