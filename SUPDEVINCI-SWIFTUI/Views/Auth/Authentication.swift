//
//  Authentication.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 05/02/2026.
//

import SwiftUI

struct AuthenticationFlow: View {
    @StateObject private var sessionManager = SessionManager.shared
    
    var body: some View {
        if sessionManager.isAuthenticated {
            // L'utilisateur est connecté → afficher la MainTabView
//            MainTabView()
            print("Vous êtes connecté.")
        } else {
            // L'utilisateur n'est pas connecté → afficher l'écran d'authentification
            AuthChoiceView()
        }
    }
}

struct AuthChoiceView: View {
    @State private var showLogin = true
    
    var body: some View {
        ZStack {
            if showLogin {
                Login(showRegister: $showLogin)
                    .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .trailing)))
            } else {
                Register(showLogin: $showLogin)
                    .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
            }
        }
        .animation(.easeInOut, value: showLogin)
    }
}
