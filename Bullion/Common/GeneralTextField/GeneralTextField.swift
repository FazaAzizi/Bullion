//
//  GeneralTextField.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import UIKit

class GeneralTextField: UIView {
    @IBOutlet weak var titleTxtField: GradientLabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var containerTxtField: UIView!
    @IBOutlet weak var calendarImgVw: UIImageView!
    @IBOutlet weak var containerImgView: UIView!
    @IBOutlet weak var eyeImgVw: UIImageView!
    
    
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
        placeHolderText: String,
        type: GeneralTextFieldType = .normal
    ) {
        switch type {
        case .normal:
            calendarImgVw.isHidden = true
            containerImgView.isHidden = true
            break
        case .password:
            calendarImgVw.isHidden = true
            containerImgView.isHidden = false
        case .calendar:
            calendarImgVw.isHidden = false
            containerImgView.isHidden = true
        case .link:
            containerImgView.isHidden = false
            calendarImgVw.isHidden = true
            eyeImgVw.image = UIImage(named: "ic_attechment")
        }
        
        titleTxtField.text = title
        titleTxtField.backgroundColor = UIColor.clear
        
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

enum GeneralTextFieldType {
    case normal
    case password
    case calendar
    case link
}
