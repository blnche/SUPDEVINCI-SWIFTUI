//
//  ContentView.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 04/02/2026.
//

import SwiftUI

struct ContentView: View {
    @State var user: Bool = false
    var body: some View {
            VStack {
                TabView {
                    MovieListView().tabItem { Label("Movies", systemImage: "film") }
//                    if user {
//                        FavoriteListView().tabItem { Label("Favorites", systemImage: "heart") }
//                    }
                    Authentication().tabItem { Label("Account", systemImage: "person") }
                }
            }
    }
}

#Preview {
    ContentView()
}
