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
    @State private var test = 0
    
    var body: some View {
        Header()
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
            Button(action: {}) {
                Text("Sign in")
                    .padding()
            }
                .foregroundStyle(.white)
                .background(Color.black)
                .clipShape(.rect(cornerRadius: 15)).shadow(radius: 8)
            Button("Increment") {
                test += 1
            }
            Button("Decrement") {
                test -= 1
            }
            Text("\(test)")
            ZStack {}
        }
    }
}
