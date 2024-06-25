//
//  PopupDetail.swift
//  Bullion
//
//  Created by Faza Azizi on 26/06/24.
//

import UIKit
import Combine

class PopupDetail: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var closeBtn: UIView!
    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var editUserBtn: GeneralButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var phoneNumbLbl: UILabel!
    @IBOutlet weak var dobLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    
    var anyCancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension PopupDetail {
    private func setupView() {
        containerView.makeCornerRadius(16)
        editUserBtn.configure(title: "Edit User", isEnable: true)
        setupAction()
    }
    
    private func setupAction() {
        closeBtn.gesture()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.dismiss(animated: false)
            }
            .store(in: &anyCancellable)
    }
}
