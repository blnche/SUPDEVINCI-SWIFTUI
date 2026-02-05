//
//  Demo.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 04/02/2026.
//

import SwiftUI

struct StackDemo: View {
  var body: some View {
    VStack(spacing: 12) {
      Text("Title")
            .font(.title)
      HStack {
          Image(systemName: "arrow.left.circle")
        Text("Left")
        Spacer()
        Text("Right")
          Image(systemName: "arrow.right.circle")

      }
        Spacer()
    ZStack {
//        Text("Overlay")
//            .font(.headline)
        Color.orange.opacity(0.6)
            .frame(width: 100, height: 100)
            .position(x: 50, y: 50)
        Color.black.opacity(0.8)
            .frame(width: 80, height: 20)
            .position(x: 50, y: 150)
        Color.black.opacity(0.6)
            .frame(width: 50, height: 100)
            .position(x: 50, y: 200)
        Text("W").position(x: 50, y: 220).foregroundStyle(.white)
        Color.orange.opacity(0.6)
            .frame(width: 100, height: 100)
            .position(x: 320, y: 50)
        Color.black.opacity(0.8)
            .frame(width: 80, height: 20)
            .position(x: 320, y: 150)
        Color.black.opacity(0.6)
            .frame(width: 50, height: 100)
            .position(x: 320, y: 200)
        Text("W").position(x: 320, y: 220).foregroundStyle(.white)
        Color.orange.opacity(0.6)
            .frame(height: 100)
            .position(x: 185, y: 585)
        Circle().size(width: 30, height: 30).position(x: 350, y: 695).foregroundStyle(.brown)
    }.clipShape(.rect(cornerRadius: 15)).shadow(radius: 8)
        Spacer()
        HStack{
            Text("Description")
        }
    }.padding()
  }
}
