//
//  ContentView.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 04/02/2026.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var sessionManager = SessionManager.shared
    @State var test: Bool = true
    
    var body: some View {
        VStack {
            TabView {
                MovieListView()
                    .tabItem { Label("Movies", systemImage: "film") }
                if sessionManager.isAuthenticated {
                    FavoriteListView()
                        .tabItem { Label("Favorites", systemImage: "heart") }
                }
                Authentication()
                    .tabItem { Label("Account", systemImage: "person") }
            }
        }
    }
}

#Preview {
    ContentView()
}
