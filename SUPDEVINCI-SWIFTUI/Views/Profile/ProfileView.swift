//
//  ProfileView.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 05/02/2026.
//

import SwiftUI
import Foundation

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack {
            Text("Profile View")
            Button("Logout") {
                viewModel.logout()
            }
        }
    }
}
