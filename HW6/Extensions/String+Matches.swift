//
//  String+Matches.swift
//  ECE564_HOMEWORK
//
//  Created by Trevor Stevenson on 9/12/19.
//  Copyright © 2019 ece564. All rights reserved.
//

import Foundation

extension String {
    /// If the string matches the given regular expression
    func matches(regex: String) -> Bool {
        let range = NSRange(location: 0, length: utf16.count)

        if let regExp = try? NSRegularExpression(pattern: regex) {
            return regExp.firstMatch(in: self, options: [], range: range)?.range.length == range.length
        }

        return false
    }
}
