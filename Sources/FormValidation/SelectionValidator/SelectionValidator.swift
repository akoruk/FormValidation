//
//  SelectionValidator.swift
//  FormValidation
//
//  Created by Ahmet Koruk on 1.08.2024.
//

import SwiftUI
import Combine

public class SelectionValidator<Data: Equatable>: Validator {
    
    // MARK: - Properties
    
    public typealias T = Data?
    public typealias Rule = SelectionValidationRule
    
    @Published public var value: Data?
    @Published public var isValidating: Bool
    public var rules: [SelectionValidationRule<Data>]
    public let isInvalidatingOnChange: Bool
    public var onValidate: ((ValidationResult) -> Void)?
    
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init
    
    public init(
        value: Data?,
        isValidating: Bool,
        rules: [SelectionValidationRule<Data>],
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
