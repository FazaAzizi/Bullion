//
//  LoginView.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import UIKit

class LoginView: UIViewController {
    
    @IBOutlet weak var emailAddressTxtField: GeneralTextField!
    @IBOutlet weak var passwordTxtField: GeneralTextField!
    
    @IBOutlet weak var signInButton: GeneralButton!
    @IBOutlet weak var addNewUserButton: GeneralButton!
    
    @IBOutlet weak var containerView: UIView!
    
    var presenter: LoginPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension LoginView {
    private func setupView() {
        emailAddressTxtField.configure(
            title: "Email Address",
            placeHolderText: "Input Email Address")
        passwordTxtField.configure(
            title: "Password",
            placeHolderText: "Input Password")
        
        signInButton.configure(
            title: "Sign In",
            isEnable: true)
        addNewUserButton.configure(
            title: "Add New User",
            isEnable: true)
        
        containerView.makeCornerRadius(24, [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        self.view.applyGradient(colors: [
            UIColor.orangeFiirst,
            UIColor.orangeSecond,
            UIColor.orangeThird
        ])
        
        signInButton.delegate = self
        addNewUserButton.delegate = self
    }
}

extension LoginView: GeneralButtonDelegate {
    func didTapButton(_ view: UIView) {
        switch view {
        case signInButton:
            let view = HomeRouter().showView()
            self.navigationController?.pushViewController(view, animated: true)
        case addNewUserButton:
            let view = FormUserRouter().showView()
            self.navigationController?.pushViewController(view, animated: true)
        default: break
        }
    }
}

