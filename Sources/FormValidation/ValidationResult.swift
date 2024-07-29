//
//  ValidationResult.swift
//  FormValidation
//
//  Created by Ahmet Koruk on 9.07.2024.
//

import Foundation
import SwiftUI

public enum ValidationResult {
    case none
    case success
    case warning(_ message: String)
    case error(_ message: String)
    
    public var message: String? {
        switch self {
        case .none:
            nil
        case .success:
            nil
        case .warning(let message):
            message
        case .error(let message):
            message
        }
    }
}

extension ValidationResult: Equatable {
    
    static public func ==(lhs: ValidationResult, rhs: ValidationResult) -> Bool {
        switch (lhs, rhs) {
        case (.none, none),
            (.success, .success):
            return true
        case (.warning(let a), .warning(let b)):
            return a == b
        case (.error(let a), .error(let b)):
            return a == b
        default:
            return false
        }
    }
}
