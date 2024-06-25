//
//  UIView+Ext.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import Foundation
import UIKit

extension UIView {
    public func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
    }
    
    func makeCornerRadius(_ radius: CGFloat, _ maskedCorner: CACornerMask? = nil) {
        layer.cornerRadius = radius
        layer.maskedCorners = maskedCorner ?? [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        clipsToBounds = true
    }
    
    func addBorder(width: CGFloat = 1, colorBorder: CGColor = UIColor.white.cgColor) {
        layer.borderWidth = width
        layer.borderColor = colorBorder
    }
    
    func addShadow(_ radius: CGFloat) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = radius
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
    }
    
}
