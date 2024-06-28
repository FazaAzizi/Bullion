//
//  UIColor+Ext.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import Foundation
import UIKit

extension UIColor {
    
    // MARK: - Additional
    static let orangeFirstColor              = #colorLiteral(red: 0.9882352941, green: 0.4078431373, blue: 0.2274509804, alpha: 1)
    static let orangeSecondColor             = #colorLiteral(red: 0.9411764706, green: 0.3529411765, blue: 0.1647058824, alpha: 1)
    static let orangeThirdColor              = #colorLiteral(red: 0.9450980392, green: 0.7294117647, blue: 0.6588235294, alpha: 1)
    static let wordingGradientFirstColor     = #colorLiteral(red: 0.568627451, green: 0.2117647059, blue: 0.1019607843, alpha: 1)
    static let wordingGradientSecondColor    = #colorLiteral(red: 0.9411764706, green: 0.3529411765, blue: 0.1647058824, alpha: 1)
    static let wordingGradientThirdColor     = #colorLiteral(red: 0.9725490196, green: 0.5843137255, blue: 0.462745098, alpha: 1)
    static let placeholderColor              = #colorLiteral(red: 0.6823529412, green: 0.6823529412, blue: 0.6980392157, alpha: 1)
    static let titleBlackColor               = #colorLiteral(red: 0.1833985746, green: 0.1628054082, blue: 0.1674172878, alpha: 1)
    static let subTitleBlackColor            = #colorLiteral(red: 0.3647058824, green: 0.3647058824, blue: 0.3647058824, alpha: 1)
    static let titleLinkColor                = #colorLiteral(red: 0.2941176471, green: 0.568627451, blue: 0.8235294118, alpha: 1)
    static let buttonBlueColor               = #colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1)
    static let titleWhiteColor               = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        // swiftlint:disable identifier_name
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
