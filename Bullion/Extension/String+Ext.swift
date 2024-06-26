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

func formatDateString(_ dateString: String) -> String? {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    inputFormatter.timeZone = TimeZone(secondsFromGMT: 0)
    
    if let date = inputFormatter.date(from: dateString) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMMM dd, yyyy"
        outputFormatter.timeZone = TimeZone.current
        return outputFormatter.string(from: date)
    } else {
        return nil
    }
}
