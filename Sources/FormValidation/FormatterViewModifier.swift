//
//  FormatterViewModifier.swift
//  FormValidation
//
//  Created by Ahmet Koruk on 17.07.2024.
//

import SwiftUI

struct FormatterViewModifier<FormatterType: Formatter>: ViewModifier {
    
    let formatter: FormatterType
    
    init(
        formatter: FormatterType
    ) {
        self.formatter = formatter
    }
    
    @ViewBuilder
    func body(content: Content) -> some View {
        content
            .onChange(of: formatter.input, perform: { _ in
                formatter.format()
            })
            .onAppear {
                formatter.format()
            }
    }
}

public extension View {
    
    func formatter<FormatterType: Formatter>(_ formatter: FormatterType) -> some View {
        self.modifier(
            FormatterViewModifier(
                formatter: formatter
            )
        )
    }
}
