//
//  ContentViewModel.swift
//  FormValidation
//
//  Created by Ahmet Koruk on 10.07.2024.
//

import Foundation
import Combine
import FormValidation

class ContentViewModel: ObservableObject {
    
    @Published var usernameValidator = ValidatorFactory.createRequiredStringValidator(minLength: 5)
    @Published var emailValidator = ValidatorFactory.createEmailValidator()
    @Published var phoneNumberValidator = ValidatorFactory.createPhoneNumberValidator(length: 12)
    @Published var passwordValidator = ValidatorFactory.createPasswordValidator()

    private var validators: [any Validator] = []
    
    @Published private(set) var usernameValidationResult: ValidationResult = .none
    @Published private(set) var emailValidationResult: ValidationResult = .none
    @Published private(set) var phoneValidationResult: ValidationResult = .none
    @Published private(set) var passwordValidationResult: ValidationResult = .none
    
    @Published var phoneMask = "+(XX) XXX XXX XX XX"
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setValidators()
    }
    
    private func setValidators() {
        usernameValidator.onValidate = { [weak self] validationResult in
            self?.usernameValidationResult = validationResult
        }
        
        emailValidator.onValidate = { [weak self] validationResult in
            self?.emailValidationResult = validationResult
        }
        
        passwordValidator.onValidate = { [weak self] validationResult in
            self?.passwordValidationResult = validationResult
        }
        
        phoneNumberValidator.onValidate = { [weak self] validationResult in
            self?.phoneValidationResult = validationResult
        }
        
        validators.append(usernameValidator)
        validators.append(emailValidator)
        validators.append(passwordValidator)
        validators.append(phoneNumberValidator)
    }
    
    func showValues() {
    }
    
    func validate() {
        validators.forEach { validator in
            validator.isValidating = true
        }
        
        let isValid = validators.allSatisfy({ $0.isValid })
        print(isValid ? "Valid all" : "Not valid")
    }
    
    func invalidate() {
        validators.forEach { validator in
            validator.isValidating = false
        }
    }
}
