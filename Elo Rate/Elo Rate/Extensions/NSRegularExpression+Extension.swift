//
//  String+Extension.swift
//  Elo Rate
//
//  Created by João Campos on 24/05/2019.
//  Copyright © 2019 João Campos. All rights reserved.
//

import Foundation

extension NSRegularExpression {

    convenience init(_ pattern: String) {

        do {

            try self.init(pattern: pattern, options: .caseInsensitive)

        } catch {

            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }

    func matches(_ text: String?) -> Bool {

        guard let string = text else { return false }

        let range = NSRange(location: 0, length: string.utf16.count)

        return firstMatch(in: string, options: [], range: range) != nil
    }
}
