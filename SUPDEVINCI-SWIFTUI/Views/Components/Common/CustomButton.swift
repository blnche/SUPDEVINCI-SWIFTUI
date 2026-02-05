//
//  CustomButton.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 05/02/2026.
//

import SwiftUI

struct CustomButton: View {
    let title: String
    let action: () -> Void
    var isLoading: Bool = false
    var isEnabled: Bool = true
    var style: ButtonStyle = .primary
    var size: ButtonSize = .medium
    
    enum ButtonStyle {
        case primary
        case secondary
        case ghost
        case outline
        case danger
    }
    
    enum ButtonSize {
        case small
        case medium
        case large
    }
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if isLoading {
                    ProgressView()
                        .tint(.white)
                }
                
                Text(title)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .frame(height: buttonHeight)
            .background(buttonBackgroundColor)
            .foregroundColor(.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(buttonBorderColor, lineWidth: 1)
            )
        }
        .disabled(!isEnabled || isLoading)
        .opacity(isEnabled ? 1.0 : 0.6)
    }
        
    private var buttonHeight: CGFloat {
        switch size {
        case .small:
            return 36
        case .medium:
            return 44
        case .large:
            return 52
        }
    }
    
    private var buttonBackgroundColor: Color {
        switch style {
        case .primary:
            return Color.blue
        case .secondary:
            return Color.gray
        case .danger:
            return Color.red
        case .ghost:
            return Color.clear
        case .outline:
            return Color.clear
        }
    }
    
    private var buttonBorderColor: Color {
        if !isEnabled {
            return Color.gray.opacity(0.3)
        }
        return buttonBackgroundColor.opacity(0.5)
    }
}

#Preview {
    VStack(spacing: 16) {
        CustomButton(
            title: "Bouton Principal",
            action: {},
            style: .primary
        )
        
        CustomButton(
            title: "Bouton Secondaire",
            action: {},
            style: .secondary
        )
        
        CustomButton(
            title: "Bouton Danger",
            action: {},
            style: .danger
        )
        
        CustomButton(
            title: "Bouton Ghost",
            action: {},
            style: .ghost
        )
        
        CustomButton(
            title: "Bouton Contour",
            action: {},
            style: .outline
        )
        
        CustomButton(
            title: "Chargement...",
            action: {},
            isLoading: true,
            style: .primary
        )
        
        CustomButton(
            title: "Désactivé",
            action: {},
            isEnabled: false,
            style: .primary
        )
        
        CustomButton(
            title: "Petit Bouton",
            action: {},
            size: .small
        )
        
        CustomButton(
            title: "Grand Bouton",
            action: {},
            size: .large
        )
    }
    .padding()
}
