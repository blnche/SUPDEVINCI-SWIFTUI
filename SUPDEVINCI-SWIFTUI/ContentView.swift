//
//  ContentView.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 04/02/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            NavigationStack {
                HStack(spacing: 40) {
                    NavigationLink("Login") {
                        Login()
                    }
                    NavigationLink("Register") {
                        Register()
                    }
                }
            }
        }.padding()
    }
}

#Preview {
    ContentView()
}
