//
//  SelectionValidationRule.swift
//  FormValidation
//
//  Created by Ahmet Koruk on 1.08.2024.
//

import Foundation

public enum SelectionValidationRule<DataType: Equatable>: ValidationRule {
    case required(ValidationResult)
    
    public func validate(_ input: DataType?) -> ValidationResult {
        switch self {
        case .required(let result):
            input == nil ? result : .success
        }
    }
}
