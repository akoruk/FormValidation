//
//  Validator.swift
//  FormValidation
//
//  Created by Ahmet Koruk on 9.07.2024.
//

import Foundation

public protocol Validator: ObservableObject {
    
    associatedtype T: Equatable
    associatedtype Rule: ValidationRule<T>
    
    var value: T { get set }
    var isValidating: Bool { get set }
    var rules: [Rule] { get }
    var isInvalidatingOnChange: Bool { get }
    var onValidate: ((ValidationResult) -> Void)? { get }
    
    var isValid: Bool { get }
    
    func validate() -> ValidationResult
}

public extension Validator {
    
    var isValid: Bool {
        validate().isValid
    }
    
    func validate() -> ValidationResult {
        guard isValidating else {
            return .none
        }
        
        // only returns the first
        for rule in rules {
            let type = rule.validate(value)
            switch type {
            case .none, .success:
                continue
            case .warning, .error:
                return type
            }
        }
        return .success
    }
}
