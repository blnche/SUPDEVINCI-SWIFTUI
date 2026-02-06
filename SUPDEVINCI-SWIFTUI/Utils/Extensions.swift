//
//  Extensions.swift
//  SUPDEVINCI-SWIFTUI
//
//  Created by Blanche Peltier on 05/02/2026.
//

import Foundation
import CryptoKit

// extension permet de l'utiliser 
extension String {
    func sha256() -> String {
        // convertit "test123" en données binaires
        let digest = SHA256.hash(data: self.data(using: .utf8) ?? Data())
        // convertit le résultat en string lisible
        return digest.map { String(format: "%02hhx", $0) }.joined()
    }
}
