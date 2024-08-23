//
//  String+Compare.swift
//  FormValidation
//
//
//  Created by Ahmet KÖRÜK on 23.08.2024.
//

import Foundation

extension String {

    func isEqualTo(_ string: String, caseInsensitive: Bool) -> Bool {
        self.compare(string, options: caseInsensitive ? .caseInsensitive : []) == .orderedSame
    }
}
