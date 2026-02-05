//
//  Authentication.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 04/02/2026.
//

import SwiftUI

struct Login: View {
    @StateObject private var sessionManager = SessionManager.shared
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String? = nil
    @Binding var showRegister: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Sign in to your account")
                .font(.caption)
            VStack(spacing: 20) {
                TextField("Email", text: $username)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.2), lineWidth: 1))
                SecureField("Password", text: $password)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.2), lineWidth: 1))
            }.padding()
            Text("\(password)")
            Button(action: handleLogin) {
                Text("Sign in")
                    .padding()
            }
                .foregroundStyle(.white)
                .background(Color.black)
                .clipShape(.rect(cornerRadius: 15)).shadow(radius: 8)
            Button("Create account") {
                showRegister = true
            }
        }
    }
    
    private func handleLogin() {
        isLoading = true
        Task {
            do {
                try sessionManager.login(username: username, email: email, password: password)
            } catch {
                errorMessage = error.localizedDescription
                isLoading = false
            }
        }
    }
}
