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
        ZStack {
            if viewModel.isLoading {
//                LoadingView()
                Text("Loading...")
            } else if let errorMessage = viewModel.errorMessage {
//                ErrorView(message: errorMessage)
                Text("Error: \(errorMessage)")
            } else {
                List(viewModel.movies) { movie in
                    Text("\(movie.title)")
                }
            }
        }
        .onAppear() {
            viewModel.loadPopularMovies()
        }
    }
}
