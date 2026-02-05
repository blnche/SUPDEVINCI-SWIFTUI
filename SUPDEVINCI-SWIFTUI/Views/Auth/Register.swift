//
//  Authentication.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 04/02/2026.
//

import SwiftUI

struct Register: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Create a new account")
                .font(.caption)
            VStack(spacing: 20) {
                TextField("Email", text: $username)
                SecureField("Password", text: $password)
                SecureField("Confirm password", text: $confirmPassword)
            }
                .padding()
                .textFieldStyle(.roundedBorder)
            Button(action: {}) {
                Text("Register")
                    .padding()
            }
                .foregroundStyle(.white)
                .background(Color.black)
                .clipShape(.rect(cornerRadius: 15)).shadow(radius: 8)
            Button("Already have an account ? Login") {
                showLogin = true
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
