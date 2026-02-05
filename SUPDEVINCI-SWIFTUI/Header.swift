//
//  Header.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 04/02/2026.
//

import SwiftUI

struct Header: View {
    var body: some View {
        HStack {
            Text("The Sea")
                .font(.largeTitle)
            Image(systemName: "film")
                .foregroundStyle(.blue)
                .imageScale(.large)
        }
    }
}
