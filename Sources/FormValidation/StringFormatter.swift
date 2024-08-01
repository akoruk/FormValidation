//
//  StringFormatter.swift
//  FormValidation
//
//  Created by Ahmet Koruk on 17.07.2024.
//

import SwiftUI

public class StringFormatter: Formatter {
    
    // MARK: - Properties
    
    public var rule: any FormationRule<String>
    @Binding public var value: String
    
    // MARK: - Init
    
    public init(
        rule: StringFormationRule,
        value: Binding<String>
    ) {
        self.rule = rule
        self._value = value
    }
}
