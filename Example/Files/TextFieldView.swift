//
//  TextFieldView.swift
//  FormValidation
//
//  Created by Ahmet Koruk on 9.07.2024.
//

import SwiftUI
import FormValidation

struct TextFieldView: View, Validatable {
    let placeholder: String
    let validationResult: ValidationResult
    @Binding var text: String
    
    private var validationColor: Color {
        switch validationResult {
        case .none:
                .clear
        case .success:
                .green
        case .warning:
                .yellow
        case .error:
                .red
        }
    }
    
    init(
        placeholder: String,
        validationResult: ValidationResult = .none,
        text: Binding<String>
    ) {
        self.placeholder = placeholder
        self.validationResult = validationResult
        self._text = text
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 8) {
                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text(placeholder)
                            .foregroundColor(.gray)
                    }
                    TextField(placeholder, text: $text)
                        .background(Color.white)
                }
            }
            .padding(8)
            .background(
                Color.white
                    .clipShape(
                        RoundedRectangle(cornerRadius: 8)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(validationColor, lineWidth: 1)
                    )
            )
        }
        .validationResultOverlay(
            validationResult: validationResult,
            color: validationColor
        )
    }
}

#Preview {
    VStack {
        Spacer()
        TextFieldView(
            placeholder: "Enter your username",
            validationResult: .none,
            text: .constant("akoruk")
        )
        Spacer()
    }
    .padding()
    .background(Color.gray)
}
