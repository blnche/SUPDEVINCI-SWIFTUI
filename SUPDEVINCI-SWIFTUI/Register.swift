//
//  Authentication.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 04/02/2026.
//

import SwiftUI

struct Login: View {
    @State private var username: String = ""
    @State private var password: String = ""
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("The Sea")
                    .font(.largeTitle)
                Image(systemName: "film")
                    .foregroundStyle(.blue)
                    .imageScale(.large)
            }
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
            Button(action: {}) {
                Text("Sign in")
                    .padding()
            }
                .foregroundStyle(.white)
                .background(Color.black)
                .clipShape(.rect(cornerRadius: 15)).shadow(radius: 8)
            ZStack {}
        }
    }
}
