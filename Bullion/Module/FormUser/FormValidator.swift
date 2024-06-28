//
//  FormValidator.swift
//  Bullion
//
//  Created by Faza Azizi on 26/06/24.
//

import Foundation
import UIKit

enum ValidationError: Error {
    case requiredField(field: String)
    case invalidEmail
    case invalidPassword
    case passwordMismatch
    case photoTooLarge
    case photoInvalidFormat
}

struct ValidationResult {
    let isValid: Bool
    let errors: [ValidationError]
}

class FormValidator {

    func validate(name: String?,
                  gender: String?,
                  dateOfBirth: String?,
                  email: String?,
                  phoneNumber: String?,
                  address: String?,
                  photoProfile: String?,
                  password: String?,
                  confirmPassword: String?,
                  isAdd: Bool = true
    ) -> ValidationResult {
        
        var errors = [ValidationError]()
        
        // Validate required fields
        validateRequiredField(name, fieldName: "Name", errors: &errors)
        validateRequiredField(gender, fieldName: "Gender", errors: &errors)
        validateRequiredField(dateOfBirth, fieldName: "Date of Birth", errors: &errors)
        validateRequiredField(email, fieldName: "Email", errors: &errors)
        validateRequiredField(phoneNumber, fieldName: "Phone Number", errors: &errors)
        validateRequiredField(address, fieldName: "Address", errors: &errors)
        
        // Split name into first and last names
        if let name = name {
            let names = name.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
            if names.count < 2 {
                errors.append(.requiredField(field: "First Name and Last Name"))
            } else {
                validateRequiredField(String(names[0]), fieldName: "First Name", errors: &errors)
                validateRequiredField(String(names[1]), fieldName: "Last Name", errors: &errors)
            }
        }
        
        // Validate email format
        if let email = email, !isValidEmail(email) {
            errors.append(.invalidEmail)
        }
        
        // Validate password and confirm password if 'isAdd' is true
        if isAdd {
            validateRequiredField(password, fieldName: "Password", errors: &errors)
            validateRequiredField(confirmPassword, fieldName: "Confirm Password", errors: &errors)
            validateRequiredField(photoProfile, fieldName: "Photo Profile", errors: &errors)
            
            if let password = password, let confirmPassword = confirmPassword, password != confirmPassword {
                errors.append(.passwordMismatch)
            }
            
            if let password = password, !isValidPassword(password) {
                errors.append(.invalidPassword)
            }
        }
        
        return ValidationResult(isValid: errors.isEmpty, errors: errors)
    }
    
    private func validateRequiredField(_ fieldValue: String?, fieldName: String, errors: inout [ValidationError]) {
        if fieldValue?.isEmpty ?? true {
            errors.append(.requiredField(field: fieldName))
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{8,}$"
        let passwordPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
}
