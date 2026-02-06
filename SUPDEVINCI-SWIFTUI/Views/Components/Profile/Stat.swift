//
//  Stat.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Cours on 06/02/2026.
//

import SwiftUI

struct StatView: View {
    let number: String
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            Text(number)
                .font(.title3)
                .fontWeight(.bold)
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
