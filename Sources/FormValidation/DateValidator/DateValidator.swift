//
//  DateValidator.swift
//  FormValidation
//
//  Created by Ahmet Koruk on 13.08.2024.
//

import SwiftUI
import Combine

public class DateValidator: Validator {
    
    // MARK: - Properties
    
    public typealias T = Date?
    public typealias Rule = DateValidationRule
    
    @Published public var value: Date?
    @Published public var isValidating: Bool
    public var rules: [Rule]
    public let isInvalidatingOnChange: Bool
    public var onValidate: ((ValidationResult) -> Void)?
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    public init(
        value: Date?,
        isValidating: Bool,
        rules: [Rule],
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
