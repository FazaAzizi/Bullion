//
//  FormUserView.swift
//  Bullion
//
//  Created by Faza Azizi on 25/06/24.
//

import UIKit
import Combine
import MobileCoreServices
import UniformTypeIdentifiers

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
    @IBOutlet weak var addressTxtField: GeneralTextField!
    @IBOutlet weak var boxMaleImgVw: UIImageView!
    @IBOutlet weak var femaleGenderView: UIView!
    @IBOutlet weak var boxFemaleImgVw: UIImageView!
    
    @IBOutlet weak var submitButton: GeneralButton!
    
    var presenter: FormUserPresenter?
    var anyCancellable = Set<AnyCancellable>()
    var data: UserModel?
    private let datePicker = UIDatePicker()
    var gender: Int = 0
    var originalDateString: String?
    var base64Image: String?
    
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
        
        bindingData()
        
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
            placeHolderText: "Input Date of Birth",
            type: .calendar)
        dobTxtField.delegate = self
        photoProfileTxtField.delegate = self
        emailTxtField.configure(
            title: "Email Address",
            placeHolderText: "Input Email Address",
            type: .normal)
        phoneNumbTxtField.configure(
            title: "Phone Number",
            placeHolderText: "Input Phone Number",
            type: .normal)
        addressTxtField.configure(
            title: "Address",
            placeHolderText: "Input Address",
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
        self.gender = data.gender == "male" ? 1 : 2
        self.originalDateString = data.dateOfBirth
        nameTxtField.configure(
            title: "Name",
            placeHolderText: "Input Name",
            value: data.name ?? "",
            type: .normal)
        dobTxtField.configure(
            title: "Date of Birth",
            placeHolderText: "Input Date of Birth",
            value: formatDateStringPicker(data.dateOfBirth) ?? "",
            type: .calendar)
        dobTxtField.delegate = self
        photoProfileTxtField.delegate = self
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
        addressTxtField.configure(
            title: "Address",
            placeHolderText: "Input Address",
            value: data.address,
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
                self?.gender = 1
            }
            .store(in: &anyCancellable)
        
        femaleGenderView.gesture()
            .sink { [weak self] _ in
                self?.boxMaleImgVw.image = UIImage(named: "ic_uncheckedbox")
                self?.boxFemaleImgVw.image = UIImage(named: "ic_checkedbox")
                self?.gender = 2
            }
            .store(in: &anyCancellable)
        
        submitButton.gesture()
            .sink { [weak self] _ in
                self?.handleSubmit()
            }
            .store(in: &anyCancellable)
    }
    
    private func bindingData() {
        guard let presenter = self.presenter else { return }
        presenter.$isSuccess
            .sink { [weak self] isSuccess in
                guard let self else { return }
                DispatchQueue.main.async {
                    if isSuccess {
                        self.showAlertSuccesss()
                    }
                }
            }
            .store(in: &anyCancellable)
        
        presenter.$isSuccessUpdate
            .sink { [weak self] isSuccess in
                guard let self else { return }
                DispatchQueue.main.async {
                    if isSuccess {
                        self.showAlertUpdateSuccesss()
                    }
                }
            }
            .store(in: &anyCancellable)
    }
}

extension FormUserView {
    private func handleSubmit() {
        let formValidator = FormValidator()
        let validationResult = formValidator.validate(
            name: nameTxtField.textField.text,
            gender: gender == 1 ? "male" : gender == 2 ? "female" : nil,
            dateOfBirth: dobTxtField.textField.text,
            email: emailTxtField.textField.text,
            phoneNumber: phoneNumbTxtField.textField.text,
            address: addressTxtField.textField.text,
            photoProfile: base64Image,
            password: passwordTxtField.textField.text,
            confirmPassword: confirmPasswordTxtField.textField.text,
            isAdd: presenter?.type == .add ? true : false
        )
        
        if presenter?.type == .add {
            if validationResult.isValid {
                var firstName = ""
                var lastName = ""

                if let name = nameTxtField.textField.text {
                    let names = name.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
                    if names.count >= 1 {
                        firstName = String(names[0])
                    }
                    if names.count >= 2 {
                        lastName = String(names[1])
                    }
                }
                
                let data = UserModel(
                    id: "",
                    gender: gender == 1 ? "male" : "female",
                    dateOfBirth: originalDateString ?? "",
                    name: nameTxtField.textField.text ?? "",
                    email: emailTxtField.textField.text ?? "",
                    photo: base64Image ?? "",
                    phone: phoneNumbTxtField.textField.text ?? "",
                    address: addressTxtField.textField.text ?? "",
                    password: passwordTxtField.textField.text ?? "",
                    firstName: firstName,
                    lastName: lastName
                )
                
                self.presenter?.fetchRegister(data: data)
            } else {
                for error in validationResult.errors {
                    switch error {
                    case .requiredField(let field):
                        showAlert(message: "\(field) is required")
                    case .invalidEmail:
                        showAlert(message: "Invalid email format")
                    case .invalidPassword:
                        showAlert(message: "Password must be at least 8 characters long, contain a number, an uppercase letter, and a lowercase letter")
                    case .passwordMismatch:
                        showAlert(message: "Passwords do not match")
                    case .photoTooLarge:
                        showAlert(message: "Photo profile size must not exceed 5MB")
                    case .photoInvalidFormat:
                        showAlert(message: "Photo profile must be in JPG or JPEG format")
                    }
                }
            }
        } else {
            if validationResult.isValid {
                var firstName = ""
                var lastName = ""

                if let name = nameTxtField.textField.text {
                    let names = name.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
                    if names.count >= 1 {
                        firstName = String(names[0])
                    }
                    if names.count >= 2 {
                        lastName = String(names[1])
                    }
                }
                
                let data = UserModel(
                    id: self.presenter?.data?.id ?? "",
                    gender: gender == 1 ? "male" : "female",
                    dateOfBirth: originalDateString ?? "",
                    name: nameTxtField.textField.text ?? "",
                    email: emailTxtField.textField.text ?? "",
                    photo: "",
                    phone: phoneNumbTxtField.textField.text ?? "",
                    address: addressTxtField.textField.text ?? "",
                    password: "",
                    firstName: firstName,
                    lastName: lastName
                )
                
                self.presenter?.fetchUpdateUser(data: data)
            } else {
                for error in validationResult.errors {
                    switch error {
                    case .requiredField(let field):
                        showAlert(message: "\(field) is required")
                    case .invalidEmail:
                        showAlert(message: "Invalid email format")
                    case .invalidPassword:
                        showAlert(message: "Password must be at least 8 characters long, contain a number, an uppercase letter, and a lowercase letter")
                    case .passwordMismatch:
                        showAlert(message: "Passwords do not match")
                    case .photoTooLarge:
                        showAlert(message: "Photo profile size must not exceed 5MB")
                    case .photoInvalidFormat:
                        showAlert(message: "Photo profile must be in JPG or JPEG format")
                    }
                }
            }
        }
        
 
    }
    
    private func showAlertSuccesss() {
        let alert = UIAlertController(title: "Registration Success", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.navigationController?.popViewController(animated: false)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    private func showAlertUpdateSuccesss() {
        let alert = UIAlertController(title: "Update Data Success", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.navigationController?.popViewController(animated: false)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func showDatePickerAlert() {
        let alert = UIAlertController(title: "Select Date of Birth", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.maximumDate = .now
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        
        let datePickerContainerView = UIView(frame: CGRect(x: 0, y: 30, width: alert.view.frame.width - 20, height: 200))
        datePicker.frame = CGRect(x: 0, y: 0, width: datePickerContainerView.frame.width, height: 200)
        datePickerContainerView.addSubview(datePicker)
        
        alert.view.addSubview(datePickerContainerView)
        
        let doneAction = UIAlertAction(title: "Done", style: .cancel) { [weak self] _ in
            let selectedDate = datePicker.date
            
            let isoDateFormatter = ISO8601DateFormatter()
            self?.originalDateString = isoDateFormatter.string(from: selectedDate)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            self?.dobTxtField.textField.text = dateFormatter.string(from: selectedDate)
        }
        alert.addAction(doneAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    @objc private func dateChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        
        let isoDateFormatter = ISO8601DateFormatter()
        self.originalDateString = isoDateFormatter.string(from: selectedDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dobTxtField.textField.text = dateFormatter.string(from: selectedDate)
    }
    
}


extension FormUserView: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func addImageButtonTapped() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = [UTType.image.identifier]
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            picker.dismiss(animated: true, completion: nil)
            return
        }
        
        var imageName: String?
        if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            imageName = imageURL.lastPathComponent
        }
        
        if let jpegData = pickedImage.jpegData(compressionQuality: 1.0) {
            let maxSize: Int = 5 * 1024 * 1024
            if jpegData.count > maxSize {
                showAlert(message: "Selected image size exceeds 5 MB.")
            } else {
                let base64String = jpegData.base64EncodedString()
                
                if let name = imageName {
                    photoProfileTxtField.textField.text = name
                }
                base64Image = base64String
            }
        } else {
            showAlert(message: "Failed to process the selected image.")
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

extension FormUserView: GeneralTextFieldDelegate {
    func didTapTxtField(_ view: UIView) {
        if view == dobTxtField {
            showDatePickerAlert()
        } else if view == photoProfileTxtField {
            addImageButtonTapped()
        }
    }
}
