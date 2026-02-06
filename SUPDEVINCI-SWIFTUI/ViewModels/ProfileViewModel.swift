//
//  ProfileViewModel.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 05/02/2026.
//

import Foundation

class ProfileViewModel: ObservableObject {
    private let session = SessionManager.shared
    
    func logout() {
        session.logout()
    }
}
