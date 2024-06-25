//
//  GeneralButton.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import UIKit

class GeneralButton: UIView {
    @IBOutlet weak var titleLbl: UILabel!
    
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
        titleLbl.text = title
        self.backgroundColor = isEnable ? UIColor.buttonBlue : UIColor.placeholder
        titleLbl.textColor = isEnable ? UIColor.titleWhite : UIColor.titleBlack
    }
}
