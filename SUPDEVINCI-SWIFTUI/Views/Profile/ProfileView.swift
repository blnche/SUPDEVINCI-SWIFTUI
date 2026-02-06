//
//  ProfileView.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 05/02/2026.
//

import SwiftUI
import Foundation

struct ProfileView: View {
    
    @StateObject private var sessionManager = SessionManager.shared
    @StateObject private var viewModel = FavoriteViewModel()

    private var username = "lola56"
    private var name: String = "Lola"
    private var email: String = "lola@gmail.com"
    private var password: String = "123456"
    private var favorites: [String] = ["Avatar", "Inception", "Mad Max: Fury Road"]
    private var favoritesGenres: [String] = ["Action", "Adventure", "Thriller", "Action", "Action", "Action", "Science", "Science"]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {

                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Movie Buff")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.secondary)
                            .tracking(2)
                        
                        Text("\(username)")
                            .font(.system(.largeTitle, design: .serif))
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    Button {
                        sessionManager.logout()
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.red.opacity(0.8))
                            .padding(10)
                            .background(Circle().fill(.red.opacity(0.1)))
                    }
                }
                .padding(.horizontal)
                
                ZStack(alignment: .bottomTrailing) {
                    Circle()
                        .fill(LinearGradient(colors: [.purple.opacity(0.3), .pink.opacity(0.3)], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(width: 120, height: 120)
                        .overlay(
                            Image(systemName: "person.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 60)
                                .foregroundColor(.white)
                        )
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                }
                
                HStack(spacing: 40) {
                    StatView(number: "\(viewModel.favorites.count)", label: "Favorites")
//                    StatView(number: "42", label: "Reviews")
                }
                .padding(.vertical, 10)

                VStack(alignment: .leading, spacing: 16) {
                    InfoRow(icon: "envelope.fill", title: "Email", value: "\(email)")
                    InfoRow(icon: "lock.shield.fill", title: "Security", value: "••••••••••••")
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color(uiColor: .secondarySystemBackground)))
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text("Top Genres")
                        .font(.headline)
                        .padding(.leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(viewModel.findDuplicateGenres(inFavorites: viewModel.favorites), id: \.self) { genre in
                                GenreChip(title: "\(genre)", color: .blue)
                            }
                            GenreChip(title: "Noir", color: .indigo)
                            GenreChip(title: "Rom-Com", color: .pink)
                            GenreChip(title: "Indie", color: .orange)
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding(.top)
        }
    }
}

#Preview {
    ProfileView()
}
