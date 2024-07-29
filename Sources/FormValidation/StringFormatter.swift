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
    @Binding public var input: String
    
    // MARK: - Init
    
    public init(
        input: Binding<String>,
        rule: StringFormationRule
    ) {
        self._input = input
        self.rule = rule
    }
}
