//
//  Card.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 05/02/2026.
//

import SwiftUI

struct Card<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            content
        }
            .padding()
            .background(Color.white)
            .clipShape(.rect(cornerRadius: 15))
            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.1), radius: 4, x: 0, y: 4)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
    }
}
