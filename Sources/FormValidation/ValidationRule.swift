//
//  ValidationRule.swift
//  FormValidation
//
//  Created by Ahmet Koruk on 9.07.2024.
//

import Foundation

public protocol ValidationRule<T> {
    associatedtype T
    
    func validate(_ input: T) -> ValidationResult
}
