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
    public let rules: [StringValidationRule]
    public let isInvalidatingOnChange: Bool
    public let onValidate: ((ValidationResult) -> Void)?
    
    private var cancellables = Set<AnyCancellable>()

    
    // MARK: - Init
    
    public init(
        value: String,
        isValidating: Bool,
        rules: [StringValidationRule],
        isInvalidatingOnChange: Bool,
        onValidate: ((ValidationResult) -> Void)?
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
            .removeDuplicates { previous, current in
                previous == current
            }
            .receive(on: RunLoop.main)
            .sink { [weak self] value in
                let shouldValidate = (self?.isValidating ?? false) && !(self?.isInvalidatingOnChange ?? false)
                self?.isValidating = shouldValidate
                let result = self?.validate() ?? .none
                self?.onValidate?(result)
            }
            .store(in: &cancellables)
        
        $isValidating
            .removeDuplicates { previous, current in
                previous == current
            }
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                let result = self?.validate() ?? .none
                self?.onValidate?(result)
            }
            .store(in: &cancellables)
    }
}
