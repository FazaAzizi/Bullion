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
    @IBOutlet weak var maleGenderView: UIView!
    @IBOutlet weak var boxMaleImgVw: UIImageView!
    @IBOutlet weak var femaleGenderView: UIView!
    @IBOutlet weak var boxFemaleImgVw: UIImageView!
    
    @IBOutlet weak var submitButton: GeneralButton!
    
    var presenter: FormUserPresenter?
    var anyCancellable = Set<AnyCancellable>()
    var data: UserModel?
    var gender: Int = 0

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
        guard let presenter = presenter else { return }
        
        data = presenter.data
        
        containerView.makeCornerRadius(24, [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        view.applyGradient(colors: [
            UIColor.orangeFiirst,
            UIColor.orangeSecond,
            UIColor.orangeThird
        ])
        
        if presenter.type == .add {
            configureFieldsForAdd()
        } else {
            configureFieldsForUpdate()
        }
        
        submitButton.configure(
            title: presenter.type == .add ? "Add User" : "Update User",
            isEnable: true)
    }
    
    private func configureFieldsForAdd() {
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
    }
    
    private func configureFieldsForUpdate() {
        guard let data = data else { return }
        
        nameTxtField.configure(
            title: "Name",
            placeHolderText: "Input Name",
            value: data.name,
            type: .normal)
        dobTxtField.configure(
            title: "Date of Birth",
            placeHolderText: "Input",
            value: data.dateOfBirth,
            type: .calendar)
        emailTxtField.configure(
            title: "Email Address",
            placeHolderText: "Input Email Address",
            value: data.email,
            type: .normal)
        phoneNumbTxtField.configure(
            title: "Phone Number",
            placeHolderText: "Input Phone Number",
            value: data.phone,
            type: .normal)
        passwordTxtField.isHidden = true
        confirmPasswordTxtField.isHidden = true
        photoProfileTxtField.configure(
            title: "Photo Profile",
            placeHolderText: "Input Photo Profile",
            type: .link)
        boxMaleImgVw.image = data.gender.lowercased() == "male" ? UIImage(named: "ic_checkedbox") : UIImage(named: "ic_uncheckedbox")
        boxFemaleImgVw.image = data.gender.lowercased() == "female" ? UIImage(named: "ic_checkedbox") : UIImage(named: "ic_uncheckedbox")
    }
    
    private func setupAction() {
        backImgVw.gesture()
            .sink { [weak self] _ in
                self?.navigationController?.popViewController(animated: false)
            }
            .store(in: &anyCancellable)
        
        maleGenderView.gesture()
            .sink { [weak self] _ in
                self?.boxMaleImgVw.image = UIImage(named: "ic_checkedbox")
                self?.boxFemaleImgVw.image = UIImage(named: "ic_uncheckedbox")
            }
            .store(in: &anyCancellable)
        
        femaleGenderView.gesture()
            .sink { [weak self] _ in
                self?.boxMaleImgVw.image = UIImage(named: "ic_uncheckedbox")
                self?.boxFemaleImgVw.image = UIImage(named: "ic_checkedbox")
            }
            .store(in: &anyCancellable)
    }
}

