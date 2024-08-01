//
//  StringValidationRule.swift
//  FormValidation
//
//  Created by Ahmet Koruk on 17.07.2024.
//

import Foundation

public enum StringValidationRule: ValidationRule {
    case nonRequired
    case required(ValidationResult)
    case email(ValidationResult)
    case phone(Int, ValidationResult)
    case min(Int, ValidationResult)
    case max(Int, ValidationResult)
    
    public func validate(_ input: String) -> ValidationResult {
        switch self {
        case .nonRequired:
            return .success
        case .required(let result):
            return input.isEmpty ? result : .success
        case .email(let result):
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
            return emailPred.evaluate(with: input) ? .success : result
        case .phone(let count, let result):
            return StringFormationRule.phone("").unformat(input).count == count ? .success : result
        case .min(let count, let result):
            return input.count >= count ? .success : result
        case .max(let count, let result):
            return input.count <= count ? .success : result
        }
    }
}
