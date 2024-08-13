//
//  StringValidator.swift
//  FormValidation
//
//  Created by Ahmet Koruk on 24.07.2024.
//

import SwiftUI
import Combine

public class StringValidator: Validator {
    
    // MARK: - Properties
    
    public typealias T = String
    public typealias Rule = StringValidationRule
    
    @Published public var value: String
    @Published public var isValidating: Bool
    public var rules: [StringValidationRule]
    public let isInvalidatingOnChange: Bool
    public var onValidate: ((ValidationResult) -> Void)?
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    public init(
        value: String,
        isValidating: Bool,
        rules: [StringValidationRule],
        isInvalidatingOnChange: Bool,
        onValidate: ((ValidationResult) -> Void)? = nil
    ) {
        self.value = value
        self.isValidating = isValidating
        self.rules = rules
        self.isInvalidatingOnChange = isInvalidatingOnChange
        self.onValidate = onValidate
        
        self.setupSubscribers()
    }
    
    func setupSubscribers() {
        $value
            .dropFirst()
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self else {
                    return
                }
                let shouldValidate = isValidating && !isInvalidatingOnChange
                isValidating = shouldValidate
                onValidate?(validate())
            }
            .store(in: &cancellables)
        
        $isValidating
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                guard let self else {
                    return
                }
                onValidate?(validate())
            }
            .store(in: &cancellables)
    }
}
