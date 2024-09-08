//
//  ValidationResultOverlayModifier.swift
//  FormValidation
//
//  Created by Ahmet Koruk on 9.07.2024.
//

import SwiftUI
import FormValidation

struct ValidationResultOverlayModifier: ViewModifier {
    
    let validationResult: ValidationResult
    let color: Color
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            content
            if let message = validationResult.message {
                Text(message)
                    .font(.caption2)
                    .foregroundColor(color)
                    .padding(.top, 4)
            }
        }
    }
}

extension View {
    
    func validationResultOverlay(validationResult: ValidationResult, color: Color) -> some View {
        self.modifier(ValidationResultOverlayModifier(validationResult: validationResult, color: color))
    }
}

#Preview {
    VStack {
        Spacer()
        HStack {
            Spacer()
            VStack {
                Text("Some content here")
                    .padding(4)
                    .background(
                        Color.gray
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    )
                    .validationResultOverlay(
                        validationResult: .error("Error here"),
                        color: .red
                    )
            }
            Spacer()
        }
        Spacer()
    }
}
