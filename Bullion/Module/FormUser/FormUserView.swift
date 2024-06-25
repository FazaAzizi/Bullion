// 
//  FormUserView.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import UIKit
import Combine

class FormUserView: UIViewController {
    
    @IBOutlet weak var backImgVw: UIImageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameTxtField: GeneralTextField!
    @IBOutlet weak var dobTxtField: GeneralTextField!
    @IBOutlet weak var emailTxtField: GeneralTextField!
    @IBOutlet weak var phoneNumbTxtField: GeneralTextField!
    @IBOutlet weak var photoProfileTxtField: GeneralTextField!
    @IBOutlet weak var passwordTxtField: GeneralTextField!
    @IBOutlet weak var confirmPasswordTxtField: GeneralTextField!

    @IBOutlet weak var submitButton: GeneralButton!
    
    var presenter: FormUserPresenter?
    var anyCancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

extension FormUserView {
    private func setupView() {
        containerView.makeCornerRadius(24, [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        self.view.applyGradient(colors: [
            UIColor.orangeFiirst,
            UIColor.orangeSecond,
            UIColor.orangeThird
        ])
        
        nameTxtField.configure(
            title: "Name",
            placeHolderText: "Input Name",
            type: .normal)
        dobTxtField.configure(
            title: "Date of Birth",
            placeHolderText: "Input",
            type: .calendar)
        emailTxtField.configure(
            title: "Email Address",
            placeHolderText: "Input Email Address",
            type: .normal)
        phoneNumbTxtField.configure(
            title: "Phone Number",
            placeHolderText: "Input Phone Number",
            type: .normal)
        passwordTxtField.configure(
            title: "Password",
            placeHolderText: "Input Password",
            type: .password)
        confirmPasswordTxtField.configure(
            title: "Confirm Password",
            placeHolderText: "Input Confirm Password",
            type: .password)
        photoProfileTxtField.configure(
            title: "Photo Profile",
            placeHolderText: "Input Photo Profile",
            type: .link)
        
        submitButton.configure(
            title: "Add Users",
            isEnable: true)
    }
    
    private func setupAction() {
        backImgVw.gesture()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.navigationController?.popViewController(animated: false)
            }
            .store(in: &anyCancellable)
    }
}

