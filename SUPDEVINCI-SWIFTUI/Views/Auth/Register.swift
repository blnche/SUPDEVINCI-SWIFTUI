//
//  Authentication.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 04/02/2026.
//

import SwiftUI

struct Register: View {
    @StateObject private var viewModel = AuthViewModel()
    @Binding var showLogin: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create a new account")
                .font(.caption)
            VStack(spacing: 20) {
                TextField("Username", text: $viewModel.username)
                TextField("Name", text: $viewModel.name)
                TextField("Email", text: $viewModel.email)
                SecureField("Password", text: $viewModel.password)
                SecureField("Confirm password", text: $viewModel.confirmPassword)
            }
                .padding()
                .textFieldStyle(.roundedBorder)
            
            if viewModel.passwordTooShort {
                Text("Password must be at least 6 characters")
                    .font(.caption2)
                    .foregroundColor(.orange)
            }
            
            if viewModel.passwordMismatch {
                Text("Passwords do not match")
                    .font(.caption2)
                    .foregroundColor(.red)
            }
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
            }
            Button(action: viewModel.register) {
                Text("Register")
                    .padding()
            }
                .disabled(!viewModel.isRegisterFormValid || viewModel.isLoading)
                .foregroundStyle(.white)
                .background(Color.black)
                .clipShape(.rect(cornerRadius: 15))
                .shadow(radius: 8)
            
            Button(action: { showLogin = true }) {
                Text("Already have an account ? Login")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
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
}
