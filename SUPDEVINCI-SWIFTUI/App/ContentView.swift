//
//  ContentView.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 04/02/2026.
//

import SwiftUI

struct ContentView: View {
    @State var user: Bool = true
    var body: some View {
        if user {
            VStack {
                TabView {
                    Text("Movies").tabItem { Label("Movies", systemImage: "film") }
                    Text("Favorites").tabItem { Label("Favorites", systemImage: "heart") }
                    Text("Account").tabItem { Label("Account", systemImage: "person") }
                }
            }
        } else {
             Register()
        }
    }
}

#Preview {
    ContentView()
}
