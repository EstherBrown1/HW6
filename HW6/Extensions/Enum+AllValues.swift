//
//  Enum+AllValues.swift
//  ECE564_HOMEWORK
//
//  Created by Trevor Stevenson on 9/21/19.
//  Copyright © 2019 ece564. All rights reserved.
//

import Foundation

extension CaseIterable where Self: RawRepresentable {
    /// A list of all the raw values
    static var allValues: [RawValue] {
        return Self.allCases.map { $0.rawValue }
    }
}
