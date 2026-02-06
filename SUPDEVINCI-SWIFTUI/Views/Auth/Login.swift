//
//  Authentication.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 04/02/2026.
//

import SwiftUI

struct Login: View {
    @StateObject private var viewModel = AuthViewModel()
    @Binding var showRegister: Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Sign in to your account")
                .font(.caption)
            VStack(spacing: 20) {
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.2), lineWidth: 1))
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.gray.opacity(0.2), lineWidth: 1))
            }.padding()
//            Text("\(password)")
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundColor(.red)
            }
            Button(action: viewModel.login) {
                Text("Sign in")
                    .padding()
            }
                .disabled(!viewModel.isLoginFormValid || viewModel.isLoading)
                .foregroundStyle(.white)
                .background(Color.black)
                .clipShape(.rect(cornerRadius: 15))
                .shadow(radius: 8)
            Button(action: { showRegister = false }) {
                Text("Register here")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
            }
        }
    }
}
