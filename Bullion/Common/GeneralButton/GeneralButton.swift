//
//  GeneralButton.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import UIKit

protocol GeneralButtonDelegate: AnyObject {
    func didTapButton(_ view: UIView)
}

class GeneralButton: UIView {
    @IBOutlet weak var titleLbl: UILabel!
    
    weak var delegate: GeneralButtonDelegate?

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

extension GeneralButton {
    func configure(title: String, isEnable: Bool) {
        setupAction()
        titleLbl.text = title
        self.backgroundColor = isEnable ? UIColor.buttonBlue : UIColor.placeholder
        titleLbl.textColor = isEnable ? UIColor.titleWhite : UIColor.titleBlack
        self.makeCornerRadius(24)
    }
    
    private func setupAction() {
        let buttonTappedGesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapAction(_:)))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(buttonTappedGesture)
    }
    
    @objc private func buttonTapAction(_ sender: UITapGestureRecognizer) {
        self.delegate?.didTapButton(self)
    }
}
