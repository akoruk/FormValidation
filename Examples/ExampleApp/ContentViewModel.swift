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
    
    @Published var usernameValidator: StringValidator!
    @Published var emailValidator: StringValidator!
    @Published var phoneNumberValidator: StringValidator!
    
    private var validators: [any Validator] = []
    
    @Published private(set) var usernameValidationResult: ValidationResult = .none
    @Published private(set) var emailValidationResult: ValidationResult = .none
    @Published private(set) var phoneValidationResult: ValidationResult = .none
    
    @Published var phoneMask = "+(XX) XXX XXX XX XX"
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setValidators()
    }
    
    private func setValidators() {
        usernameValidator = StringValidator(
            value: "",
            isValidating: true,
            rules: [
                .required(.warning("this is required")),
                .min(5, .warning("Min 5 characters"))
            ],
            isInvalidatingOnChange: false,
            onValidate: { [weak self] validationResult in
                self?.usernameValidationResult = validationResult
            }
        )
        
        emailValidator = StringValidator(
            value: "",
            isValidating: false,
            rules: [
                .required(.warning("this is required")),
                .email(.error("email is invalid"))
            ],
            isInvalidatingOnChange: false,
            onValidate: { [weak self] validationResult in
                self?.emailValidationResult = validationResult
            }
        )
        
        phoneNumberValidator = StringValidator(
            value: "",
            isValidating: false,
            rules: [
                .required(.warning("this is required")),
                .phone(12, .error("phone is invalid"))
            ],
            isInvalidatingOnChange: false,
            onValidate: { [weak self] validationResult in
                self?.phoneValidationResult = validationResult
            }
        )

        validators.append(usernameValidator)
        validators.append(emailValidator)
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
