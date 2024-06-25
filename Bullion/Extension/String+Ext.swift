//
//  String+Ext.swift
//  Bullion
//
//  Created by Faza Azizi on 26/06/24.
//

import Foundation
import CryptoKit

extension String {
    func sha256() -> String {
        if let data = self.data(using: .utf8) {
            let hash = SHA256.hash(data: data)
            return hash.compactMap { String(format: "%02x", $0) }.joined()
        }
        return ""
    }
}
