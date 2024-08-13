//
//  StringValidationRule.swift
//  FormValidation
//
//  Created by Ahmet Koruk on 17.07.2024.
//

import Foundation

public enum StringValidationRule: ValidationRule {
    case required(ValidationResult)
    case email(ValidationResult)
    case phone(Int, ValidationResult)
    case min(Int, ValidationResult)
    case max(Int, ValidationResult)
    case equal(String, ValidationResult)
    case existsIn([String], ValidationResult)
    case notExistIn([String], ValidationResult)
    case regex(String, ValidationResult)
    case creditCard(ValidationResult)
    case url(ValidationResult)
    case strongPassword(ValidationResult)
    case nonEmptyWhenTrimmed(ValidationResult)
    case numerical(ValidationResult)
    case alphabetical(ValidationResult)
    case alphanumerical(ValidationResult)
    case inCharset(CharacterSet, ValidationResult)
    
    public func validate(_ input: String) -> ValidationResult {
        switch self {
        case .required(let result):
            return input.isEmpty ? result : .success
        case .email(let result):
            let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            return isMatchingRegex(input: input, with: regex) ? .success : result
        case .phone(let count, let result):
            // TODO: - this is not good looking. String formation should not be here
            return StringFormationRule.phone("").unformat(input).count == count ? .success : result
        case .min(let count, let result):
            return input.count >= count ? .success : result
        case .max(let count, let result):
            return input.count <= count ? .success : result
        case .equal(let string, let result):
            return input == string ? .success : result
        case .existsIn(let items, let result):
            return items.contains(input) ? .success : result
        case .notExistIn(let items, let result):
            return !items.contains(input) ? .success : result
        case .regex(let pattern, let result):
            return isMatchingRegex(input: input, with: pattern) ? .success : result
        case .creditCard(let result):
            return isValidCreditCardNumber(input) ? .success : result
        case .url(let result):
            let regex = "http[s]?://(?:[a-zA-Z]|[0-9]|[$-_@.&+]|[!*\\(\\),]|(?:%[0-9a-fA-F][0-9a-fA-F]))+"
            return isMatchingRegex(input: input, with: regex) ? .success : result
        case .strongPassword(let result):
            let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
            return isMatchingRegex(input: input, with: regex) ? .success : result
        case .nonEmptyWhenTrimmed(let result):
            return input.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? result : .success
        case .numerical(let result):
            let regex = "^[0-9]+$"
            return isMatchingRegex(input: input, with: regex) ? .success : result
        case .alphabetical(let result):
            let regex = "^[a-zA-Z]+$"
            return isMatchingRegex(input: input, with: regex) ? .success : result
        case .alphanumerical(let result):
            let regex = "^[a-zA-Z0-9]+$"
            return isMatchingRegex(input: input, with: regex) ? .success : result
        case .inCharset(let charset, let result):
            let inputSet = CharacterSet(charactersIn: input)
            return charset.isSuperset(of: inputSet) ? .success : result
        }
    }
    
    private func isMatchingRegex(input: String, with pattern: String) -> Bool {
        let regexPred = NSPredicate(format: "SELF MATCHES %@", pattern)
        return regexPred.evaluate(with: input)
    }
    
    private func isValidCreditCardNumber(_ number: String) -> Bool {
        let sanitized = number.filter("0123456789".contains)
        return luhnCheck(string: sanitized)
    }
    
    private func luhnCheck(string: String) -> Bool {
        var sum = 0
        let digitStrings = string.reversed().enumerated().map { (index, character) -> Int in
            let digit = Int(String(character))!
            if index % 2 == 1 {
                return (digit * 2 > 9) ? (digit * 2 - 9) : (digit * 2)
            }
            return digit
        }
        sum = digitStrings.reduce(0, +)
        return sum % 10 == 0
    }
}
