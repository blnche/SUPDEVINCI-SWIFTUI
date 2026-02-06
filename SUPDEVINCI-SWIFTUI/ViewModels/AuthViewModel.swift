//
//  AuthViewModel.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 05/02/2026.
//

import Foundation

class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var name: String = ""
    @Published var username: String = ""
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    private let sessionManager = SessionManager.shared
    
    func login() {
        isLoading = true
        errorMessage = nil
        
        do {
            try sessionManager.login(email: email, password: password)
            print("✅ Login réussi")
            resetForm()
        } catch {
            print("❌ Erreur login: \(error.localizedDescription)")
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    
    func register() {
        isLoading = true
        errorMessage = nil
        
        do {
            try sessionManager.register(
                name: name,
                username: username,
                email: email,
                password: password
            )
            print("✅ Register réussi")
            resetForm()
        } catch {
            print("❌ Erreur register: \(error.localizedDescription)")
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    
    var isLoginFormValid: Bool {
        !email.isEmpty && !password.isEmpty && email.contains("@")
    }
    
    var isRegisterFormValid: Bool {
        !name.isEmpty &&
        !username.isEmpty &&
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
    
    private func resetForm() {
        email = ""
        password = ""
        confirmPassword = ""
        name = ""
        username = ""
        errorMessage = nil
        isLoading = false
    }
}
