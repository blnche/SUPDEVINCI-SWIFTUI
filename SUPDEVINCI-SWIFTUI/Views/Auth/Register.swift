//
//  Authentication.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 04/02/2026.
//

import SwiftUI

struct Register: View {
    @StateObject private var sessionManager = SessionManager.shared
    @State private var username: String = ""
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String?
    @State private var isLoading = false
    @Binding var showLogin: Bool
    
    var isFormValid: Bool {
        !username.isEmpty &&
        !name.isEmpty &&
        !email.isEmpty &&
        !password.isEmpty &&
        !confirmPassword.isEmpty &&
        email.contains("@") &&
        password == confirmPassword &&
        password.count >= 6
    }
    
    var passwordMismatch: Bool {
        !password.isEmpty && !confirmPassword.isEmpty && password != confirmPassword
    }
    
    var passwordTooShort: Bool {
        !password.isEmpty && password.count < 6
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create a new account")
                .font(.caption)
            VStack(spacing: 20) {
                TextField("Username", text: $username)
                TextField("Name", text: $name)
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                SecureField("Confirm password", text: $confirmPassword)
            }
                .padding()
                .textFieldStyle(.roundedBorder)
            Button(action: handleRegister) {
                Text("Register")
                    .padding()
            }
                .foregroundStyle(.white)
                .background(Color.black)
                .clipShape(.rect(cornerRadius: 15)).shadow(radius: 8)
            Button(action: { showLogin = true }) {
                Text("Already have an account ? Login")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
            }
            
            if let errorMessage = errorMessage {
                HStack(spacing: 12) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(.red)
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundColor(.red)
                }
                .padding(12)
                .background(Color.red.opacity(0.1))
                .cornerRadius(8)
            }
//            NavigationStack {
//                
//                NavigationLink("Already have an account ? Login") {
//                    Login()
//                }
//            }
            ZStack {}
        }
    }
    
    private func handleRegister() {
        isLoading = true
        errorMessage = nil
        
        Task {
            do {
                try sessionManager.register(name: name, username: username, email: email, password: password)
            } catch {
                await MainActor.run {
                    errorMessage = error.localizedDescription
                    isLoading = false
                }
            }
        }
    }
}
