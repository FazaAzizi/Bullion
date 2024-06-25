//
//  UIFont_Ext.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import Foundation
import UIKit

extension UIFont {
    // Roboto Fonts
    static func robotoBlack(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Black", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func robotoBlackItalic(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-BlackItalic", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func robotoBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Bold", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func robotoBoldItalic(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-BoldItalic", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func robotoItalic(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Italic", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func robotoLight(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Light", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func robotoLightItalic(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-LightItalic", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func robotoMedium(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Medium", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func robotoMediumItalic(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-MediumItalic", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func robotoRegular(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func robotoThin(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Thin", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func robotoThinItalic(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-ThinItalic", size: size) ?? .systemFont(ofSize: size)
    }
    
    // Inter Fonts
    static func interBlack(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Black", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func interBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Bold", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func interExtraBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-ExtraBold", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func interExtraLight(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-ExtraLight", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func interLight(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Light", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func interMedium(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Medium", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func interRegular(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func interSemiBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-SemiBold", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func interThin(_ size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Thin", size: size) ?? .systemFont(ofSize: size)
    }
}
