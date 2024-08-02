//
//  FormationRule.swift
//  FormValidation
//
//  Created by Ahmet Koruk on 17.07.2024.
//

import Foundation

public protocol FormationRule<T> {
    associatedtype T
    
    func format(_ input: T) -> T
    func unformat(_ input: T) -> T
}
