//
//  NewsCVC.swift
//  Bullion
//
//  Created by Faza Azizi on 26/06/24.
//

import UIKit

class NewsCVC: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    static let identifier = String(describing: NewsCVC.self)
    static let nib = {
        UINib(nibName: identifier, bundle: nil)
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.makeCornerRadius(12)
    }
}
