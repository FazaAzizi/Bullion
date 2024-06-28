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
        
        emailAddressTxtField.textField.delegate = self
        passwordTxtField.textField.delegate = self
        
        updateSignInButtonState()
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
    
    func updateSignInButtonState() {
        let isEmailValid = isValidEmail(emailAddressTxtField.textField.text)
        let isPasswordValid = passwordTxtField.textField.text?.count ?? 0 > 1
        
        signInButton.configure(title: "Sign In", isEnable: isEmailValid && isPasswordValid)
    }
    
    func isValidEmail(_ email: String?) -> Bool {
        guard let email = email else { return false }
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailPredicate.evaluate(with: email)
    }
}

extension LoginView: GeneralButtonDelegate {
    func didTapButton(_ view: UIView) {
        switch view {
        case signInButton:
            guard let email = emailAddressTxtField.textField.text,
                  let pass = passwordTxtField.textField.text
            else {return}
            presenter?.fetchCourseList(email: email, password: pass)
        case addNewUserButton:
            let vc = FormUserRouter().showView(type: .add)
            self.navigationController?.pushViewController(vc, animated: true)
        default: break
        }
    }
}

extension LoginView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailAddressTxtField.textField || textField == passwordTxtField.textField {
            DispatchQueue.main.async { [weak self] in
                self?.updateSignInButtonState()
            }
        }
        return true
    }
}
