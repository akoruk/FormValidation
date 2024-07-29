//
//  ContentView.swift
//  FormValidation
//
//  Created by Ahmet Koruk on 9.07.2024.
//

import SwiftUI
import FormValidation

struct ContentView: View {
    @StateObject private var viewModel: ContentViewModel
    
    init() {
        self._viewModel = StateObject(
            wrappedValue: ContentViewModel()
        )
    }
    
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            TextFieldView(
                placeholder: "Enter your username",
                validationResult: viewModel.usernameValidationResult,
                text: $viewModel.usernameValidator.value
            )
            
            TextFieldView(
                placeholder: "Enter your email",
                validationResult: viewModel.emailValidationResult,
                text: $viewModel.emailValidator.value
            )
            
            TextFieldView(
                placeholder: "Enter your phone",
                text: $viewModel.phoneNumber
            )
            .formatter(
                StringFormatter(
                    input: $viewModel.phoneNumber,
                    rule: .phone("+(XX) XXX XXX XXXX")
                )
            )
            
            Button {
                viewModel.validate()
            } label: {
                Text("Validate")
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            Button {
                viewModel.invalidate()
            } label: {
                Text("Invalidate")
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.green)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }

            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.1))
    }
}

#Preview {
    ContentView()
}
