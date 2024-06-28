//
//  UIImageView+Ext.swift
//  Bullion
//
//  Created by Faza Azizi on 26/06/24.
//

import Foundation
import UIKit

extension UIImageView {
    func setImage(fromBase64 base64String: String) {
        if let data = Data(base64Encoded: base64String),
           let image = UIImage(data: data) {
            self.image = image
        } else {
            print("Invalid Base64 string")
        }
    }
}
