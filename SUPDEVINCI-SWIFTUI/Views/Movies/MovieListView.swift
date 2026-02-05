//
//  MovieListView.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 05/02/2026.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieViewModel()
    
    var body: some View {
        VStack (alignment: .leading) {
            if viewModel.isLoading {
                LoadingView()
            } else if let errorMessage = viewModel.errorMessage {
                ErrorView(message: errorMessage)
            } else {
                Text("Popular Movies")
                    .font(.largeTitle)
                ScrollView {
                    VStack (spacing: 20) {
                        ForEach(viewModel.movies, id: \.id ) { movie in
                            MovieRowView(movie: movie)
                        }
                    }
                    .padding(15)
                }
            }
        }
        .padding()
        .onAppear() {
            viewModel.loadPopularMovies()
        }
    }
}
