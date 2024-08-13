//
//  DateValidationRule.swift
//  FormValidation
//
//  Created by Ahmet Koruk on 13.08.2024.
//

import Foundation

public enum DateValidationRule: ValidationRule {
    case required(ValidationResult)
    case min(Date, ValidationResult)
    case max(Date, ValidationResult)
    case equal(Date, ValidationResult)
    case inTheSamePeriod(Date, Calendar.Component, ValidationResult)
    case minAge(Int, ValidationResult)
    case maxAge(Int, ValidationResult)
    
    public func validate(_ input: Date?) -> ValidationResult {
        switch self {
        case .required(let result):
            return input == nil ? result : .success
        case .min(let date, let result):
            guard let input = input else {
                return result // Assuming result indicates a failure due to missing input
            }
            return input >= date ? .success : result
        case .max(let date, let result):
            guard let input = input else {
                return result
            }
            return input <= date ? .success : result
        case .equal(let date, let result):
            guard let input = input else {
                return result
            }
            return Calendar.current.isDate(input, equalTo: date, toGranularity: .second) ? .success : result
        case .inTheSamePeriod(let date, let component, let result):
            guard let input = input else {
                return result
            }
            return Calendar.current.isDate(input, equalTo: date, toGranularity: component) ? .success : result
        case .minAge(let age, let result):
            guard let input = input else {
                return result
            }
            let birthdate = Calendar.current.date(byAdding: .year, value: -age, to: Date())
            return input <= birthdate! ? .success : result
        case .maxAge(let age, let result):
            guard let input = input else {
                return result
            }
            let birthdate = Calendar.current.date(byAdding: .year, value: -age, to: Date())
            return input >= birthdate! ? .success : result
        }
    }
}
