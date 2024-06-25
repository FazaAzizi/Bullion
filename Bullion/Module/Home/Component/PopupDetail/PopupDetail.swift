//
//  PopupDetail.swift
//  Bullion
//
//  Created by Faza Azizi on 26/06/24.
//

import UIKit
import Combine

protocol PopupDetailDelegate: AnyObject {
    func didTapEdit(data: UserModel)
}

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
    var data: UserModel?
    var delegate: PopupDetailDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension PopupDetail {
    private func setupView() {
        containerView.makeCornerRadius(16)
        editUserBtn.configure(title: "Edit User", isEnable: true)
        editUserBtn.delegate = self
        
        if let data = data {
            nameLbl.text = data.name
            emailLbl.text = data.email
            phoneNumbLbl.text = data.phone
            genderLbl.text = data.gender
            dobLbl.text = data.dateOfBirth
            addressLbl.text = data.address
        }
        
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

extension PopupDetail: GeneralButtonDelegate {
    func didTapButton(_ view: UIView) {
        guard let data = data,
              let delegate = self.delegate
        else {return}
        
        self.dismiss(animated: false)
        delegate.didTapEdit(data: data)
    }
}
