//
//  GeneralTextField.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import UIKit

class GeneralTextField: UIView {
    @IBOutlet weak var titleTxtField: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var containerTxtField: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        let view = self.loadNib()
        view.frame = self.bounds
        self.addSubview(view)
    }
}

extension GeneralTextField {
    func configure(
        title: String,
        placeHolderText: String
    ) {
        titleTxtField.text = title
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.placeholder,
            .font: UIFont.robotoRegular(14)
        ]
        
        let attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
        
        containerTxtField.addBorder(width: 1, colorBorder: UIColor.placeholder.cgColor)
        containerTxtField.makeCornerRadius(24)
    }
}
