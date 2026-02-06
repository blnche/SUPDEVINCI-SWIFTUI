//
//  Chip.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Cours on 06/02/2026.
//

import SwiftUI

struct GenreChip: View {
    let title: String
    let color: Color
    
    var body: some View {
        Text(title)
            .font(.footnote)
            .fontWeight(.medium)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(color.opacity(0.15))
            .foregroundColor(color)
            .clipShape(Capsule())
    }
}
