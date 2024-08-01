//
//  Formatter.swift
//  FormValidation
//
//  Created by Ahmet Koruk on 17.07.2024.
//

import Foundation

public protocol Formatter: ObservableObject {
    
    associatedtype T: Equatable
    var rule: any FormationRule<T> { get }
    var value: T { get set }
    
    func format()
    func unformat()
}

public extension Formatter {
    
    func format() {
        value = rule.format(value)
    }
    
    func unformat() {
        value = rule.unformat(value)
    }
}
