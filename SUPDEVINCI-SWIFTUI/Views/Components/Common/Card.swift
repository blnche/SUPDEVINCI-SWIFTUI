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
            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.1), radius: 4, x: 0, y: 4)
            .mask(TicketShape())
    }
}

struct TicketShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let cornerRadius: CGFloat = 15

        path.addRoundedRect(in: rect, cornerSize: CGSize(width: cornerRadius, height: cornerRadius))

        return path
    }
}

