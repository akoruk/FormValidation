//
//  StringFormationRule.swift
//  FormValidation
//
//  Created by Ahmet Koruk on 17.07.2024.
//

import Foundation

public enum StringFormationRule: FormationRule {
    case max(Int)
    case phone(String)
    case creditCard(String)
    case email
    case filter(allowedCharacters: String)
    case lowercase
    case uppercase

    public func format(_ input: String) -> String {
        switch self {
        case .max(let count):
            if input.count > count {
                return String(input.prefix(count))
            }
            return input
        case .phone(let mask):
            let unformattedInput = unformat(input)
            return maskString(unformattedInput, with: mask)
        case .creditCard(let mask):
            let unformattedInput = unformat(input)
            return maskString(unformattedInput, with: mask)
        case .email:
            return StringFormationRule
                .filter(allowedCharacters: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@.-_")
                .format(input)
                .lowercased()
        case .filter(let allowedCharacters):
            let allowedChars = CharacterSet(charactersIn: allowedCharacters)
            return input
                .filter { String($0).rangeOfCharacter(from: allowedChars) != nil }
                .lowercased()
        case .lowercase:
            return input.localizedLowercase
        case .uppercase:
            return input.localizedUppercase
        }
    }

    public func unformat(_ input: String) -> String {
        switch self {
        case .max:
            return input
        case .phone(let mask):
            return unmaskStringToNumber(input, with: mask)
        case .creditCard(let mask):
            return unmaskStringToNumber(input, with: mask)
        case .email:
            return input
        case .filter:
            return input
        case .lowercase:
            return input
        case .uppercase:
            return input
        }
    }

    private func maskString(_ input: String, with mask: String) -> String {
        var result = ""
        var inputIndex = input.startIndex
        var maskIndex = mask.startIndex

        while maskIndex < mask.endIndex && inputIndex < input.endIndex {
            if mask[maskIndex] == "X" {
                result.append(input[inputIndex])
                inputIndex = input.index(after: inputIndex)
            } else {
                result.append(mask[maskIndex])
            }
            maskIndex = mask.index(after: maskIndex)
        }

        return result
    }

    private func unmaskStringToNumber(_ input: String, with mask: String) -> String {
        input.filter({ $0.isNumber })
    }
}
