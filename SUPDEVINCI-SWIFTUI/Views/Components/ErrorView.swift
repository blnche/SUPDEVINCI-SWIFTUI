//
//  ErrorView.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 05/02/2026.
//

import SwiftUI

struct ErrorView: View {
    let message: String
    
    var body: some View {
        Text("Error : \(message)")
    }
}
