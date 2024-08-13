//
//  ValidatorFactory.swift
//  ExampleApp
//
//  Created by Ahmet Koruk on 13.08.2024.
//

import Foundation
import FormValidation

final class ValidatorFactory {
    
    static func createRequiredStringValidator(
        value: String = "",
        minLength: Int = 1,
        onValidate: ((ValidationResult) -> Void)? = nil
    ) -> StringValidator {
        StringValidator(
            value: value,
            isValidating: false,
            rules: [
                .required(.warning("This field is required")),
                .min(minLength, .error(String(format: "Enter minimum \(minLength) characters")))
            ],
            isInvalidatingOnChange: true,
            onValidate: onValidate
        )
    }
    
    static func createPhoneNumberValidator(
        value: String = "",
        length: Int,
        onValidate: ((ValidationResult) -> Void)? = nil
    ) -> StringValidator {
        StringValidator(
            value: value,
            isValidating: false,
            rules: [
                .required(.warning("Phone number is required")),
                .phone(length, .error("Phone number is invalid"))
            ],
            isInvalidatingOnChange: true,
            onValidate: onValidate
        )
    }
    
    static func createEmailValidator(
        value: String = "",
        onValidate: ((ValidationResult) -> Void)? = nil
    ) -> StringValidator {
        StringValidator(
            value: value,
            isValidating: false,
            rules: [
                .required(.warning("Email is required")),
                .email(.error("Email is invalid"))
            ],
            isInvalidatingOnChange: true,
            onValidate: onValidate
        )
    }
    
    static func createRequiredSelectionValidator<Data>(
        value: Data? = nil,
        onValidate: ((ValidationResult) -> Void)? = nil
    ) -> SelectionValidator<Data> {
        SelectionValidator<Data>(
            value: value,
            isValidating: false,
            rules: [
                .required(.warning("This is required"))
            ],
            isInvalidatingOnChange: true,
            onValidate: onValidate
        )
    }
}
