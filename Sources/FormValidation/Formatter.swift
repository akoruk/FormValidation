//
//  Formatter.swift
//  FormValidation
//
//  Created by Ahmet Koruk on 17.07.2024.
//

import Foundation

public protocol Formatter: ObservableObject {
    
    associatedtype T: Equatable
    var input: T { get set }
    var rule: any FormationRule<T> { get }
    
    func format()
    func unformat()
}

public extension Formatter {
    
    func format() {
        input = rule.format(input)
    }
    
    func unformat() {
        input = rule.unformat(input)
    }
}
